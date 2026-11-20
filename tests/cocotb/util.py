import os
import re
from subprocess import run
from elftools.elf.elffile import ELFFile
import numpy as np

DEFAULT_ARGS = [
     "-Wno-fatal", 
     "--no-stop-fail", 
     "-Wno-REDEFMACRO"
]

COMMON_MK = os.path.abspath(
    os.path.join(os.path.dirname(__file__), "../../common.mk")
)
if not os.path.exists(COMMON_MK):
    raise FileNotFoundError(f"Could not find makefile: {COMMON_MK}")

def get_make_var(var_name, makefile=COMMON_MK):
    try:
        output = run(
            ["make", "-f", COMMON_MK, "-p", var_name],
            capture_output=True
        ).stdout.decode('ascii')
    except Exception as e:
        print(f"Error retrieving make variable {var_name}: {e}")
    pattern = rf"^{re.escape(var_name)}\s*:?=\s*(.*)$"
    res = re.search(pattern, output, re.MULTILINE)
    if res is None:
        raise ValueError(f"Variable {var_name} not found in {COMMON_MK}.")
    return res.groups()[0]

def run_make(makefile, config, target="all"):
    env = os.environ.copy()
    env["CONFIG"] = config
    try:
        output = run(
            ["make", "-f", str(makefile), target],
            env=env,
            capture_output=True
        ).stdout.decode('ascii')
    except Exception as e:
        print(f"Make error: {output}. Exception: {e}")
    return output

CONFIG_DIR = get_make_var("CONFIG_DIR")
if not os.path.exists(CONFIG_DIR):
    raise FileNotFoundError(f"Could not find config dir: {CONFIG_DIR}")

def get_config_var(var_name, config):
    config_mk = os.path.abspath(
        os.path.join(CONFIG_DIR, f"{config}.mk") 
    )
    return get_make_var(var_name, makefile=config_mk)

def get_valid_configs():
    configs = []
    for entry in os.listdir(CONFIG_DIR):
        entry_path = os.path.join(CONFIG_DIR, entry)
        if os.path.isfile(entry_path) and entry.endswith(".mk"):
            configs.append(entry[:-3]) # remove .mk
    return configs

def get_buildargs(config, WAVES=False, sim='verilator'):
    root_dir =  get_make_var("ROOT_DIR")
    buildargs = DEFAULT_ARGS
    buildargs += ["-f", f"{root_dir}/build/{config}/config/sim_sources.flist"]
    if WAVES:
        if sim == "verilator":
            buildargs += ['--trace', '--trace-structs']
    return  buildargs

def get_parameters(config):
    # TODO
    return {}

def gen_bender_flist(config):
    env = os.environ.copy()
    env["CONFIG"] = config
    try:
        output = run(
            ["make", "-f", COMMON_MK, "sim_flist"],
            env=env,
            capture_output=True,
        )
    except Exception as e:
        print(f"Failed to build sim flist for config {config}. Output: {output}.")

def elf2hex(elf_file) -> str:
    "Transforms .elf file to hex and writes it to hex_file"
    hex_str=""
    with open(elf_file, 'rb') as f:
        elf = ELFFile(f)
        for segment in elf.iter_segments():
            if segment['p_type'] == 'PT_LOAD':
                addr = segment['p_paddr']
                assert addr >= 0x8000_0000
                rel_word_addr = int((addr - 0x8000_0000) / 4)
                hex_str += f"@{rel_word_addr:08x}\n"
                data = list(map(lambda d: f"{d:02x}", segment.data()))
                if len(data) % 4 != 0:
                    nzeros = 4 - (len(data) % 4)
                    for _ in range(nzeros):
                        data.append('00')
                arr = np.array(data)
                narr = arr.reshape(-1, 4)
                for word in narr:
                    hex_str += word[3] + word[2] + word[1] + word[0] + "\n"
    with open(elf_file.with_suffix('.hex'), 'w') as hex_file:
        hex_file.write(hex_str)
    return elf_file.with_suffix('.hex')

def get_exit_addr(elf_file) -> int:
    "Based on the elf file determines the exit address"
    with open(elf_file, 'rb') as f:
        elf = ELFFile(f)
        for section in elf.iter_sections():
            if section.name == ".symtab":
                exit_symbol = get_exit_symbol(sym_section=section)
                if exit_symbol:
                    exit_addr = exit_symbol[0]["st_value"]
                    return exit_addr

    raise KeyError(f"Symbol '{exit_symbol}' not found")

def get_exit_symbol(sym_section) -> str:
    "Based on the elf file determines the exit symbol"
    candidates = ["write_tohost", "tohost_exit"]
    for candidate in candidates:
        exit_symbol = sym_section.get_symbol_by_name(candidate)
        if exit_symbol:
            return exit_symbol
    raise KeyError("No exit symbol found in ELF file")

