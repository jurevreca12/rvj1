import os
import subprocess
import json
from pathlib import Path
from cocotb_tools.runner import get_runner

LANGUAGE = os.getenv("HDL_TOPLEVEL_LANG", "verilog").lower().strip()
WAVES = os.getenv("WAVES", default=False)
RVFI = os.getenv("RVFI", default=True)
RVFI_TRACE = os.getenv("RVFI_TRACE", default=False)
ASSERTIONS = os.getenv("ASSERTIONS", default=True)

def get_rtl_files():
    rtl_files = []
    sources = subprocess.run(
        "bender sources -t rtl -t sim -t tech_cells_generic_exclude_deprecated --flatten", 
        capture_output=True, 
        shell=True
    )
    sources = json.loads(sources.stdout)
    for src_pkg in sources:
        for file in src_pkg['files']:
            rtl_files.append(Path(file))
    return rtl_files


def get_inc_dirs():
    inc_dirs = []
    sources = subprocess.run(
        "bender sources --keep-excluded-incdirs -t rtl -t sim -t tech_cells_generic_exclude_deprecated --flatten", 
        capture_output=True, 
        shell=True
    )
    sources = json.loads(sources.stdout)
    for src_pkg in sources:
        for inc_dir in src_pkg['include_dirs']:
            inc_dirs.append(Path(inc_dir))
    return inc_dirs

def get_test_runner(hdl_top):
    sim = os.getenv("SIM", default="verilator")
    build_args = ["-Wno-fatal", "--no-stop-fail", "-Wno-REDEFMACRO"]
    if WAVES:
        build_args += ["--trace-fst"]
    if RVFI:
        build_args += [f"-DRVFI"]
    if RVFI_TRACE:
        build_args += [f"-DRVFI_TRACE"]
    if ASSERTIONS:
        build_args += [f"-DASSERTIONS"]
    runner = get_runner(sim)
    runner.build(
        sources=get_rtl_files(),
        includes=get_inc_dirs(),
        build_args=build_args,
        hdl_toplevel=hdl_top,
        always=True,
        waves=False,
    )
    return runner
