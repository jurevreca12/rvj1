import os
from subprocess import run
from pathlib import Path
import pytest
from cocotb_tools._pytest.hdl import HDL
from util import elf2hex
from util import get_exit_addr
from util import (get_make_var, 
                  get_valid_configs, 
                  get_config_var,
                  get_buildargs,
                  get_parameters,
                  gen_bender_flist,
                  run_make)


ROOT_DIR   = get_make_var("ROOT_DIR")
CONFIGS    = get_valid_configs()

ELF_GROUP_DIRS = {
    "regcmp": ["bringup"],
    "cosim": ["rvgen", "riscv-tests"],
}

WAVES      = os.getenv("WAVES",        default=False)
RVFI       = os.getenv("RVFI",         default=True)
RVFI_TRACE = os.getenv("RVFI_TRACE",   default=False)
ASSERTIONS = os.getenv("ASSERTIONS",   default=True)

def pytest_addoption(parser):
    parser.addoption(
        "--config",
        action="append",
        default=None,
        help="Run a config; repeat for several. Default: all discovered configs.",
    )
    parser.addoption(
        "--elf",
        action="append",
        default=None,
        help="Run this ELF instead of discovering ELFs; may be repeated",
    )


def pytest_generate_tests(metafunc):
    if "elf" not in metafunc.fixturenames:
        return

    marker = metafunc.definition.get_closest_marker("elf_group")
    if marker is None or not marker.args:
        raise pytest.UsageError(
            f"{metafunc.definition.name} needs @pytest.mark.elf_group('regcmp' or 'cosim')"
        )

    group = marker.args[0]
    if group not in ELF_GROUP_DIRS:
        raise pytest.UsageError(f"Unknown ELF group: {group}")

    requested_configs = metafunc.config.getoption("--config")
    configs = requested_configs if requested_configs else CONFIGS

    unknown = set(configs) - set(CONFIGS)
    if unknown:
        raise pytest.UsageError(f"Unknown config(s): {', '.join(sorted(unknown))}")

    explicit_elfs = metafunc.config.getoption("--elf")
    cases = []
    grouped_cases = []

    for config in configs:
        for directory in ELF_GROUP_DIRS[group]:
            mf = os.path.abspath(
                os.path.join(ROOT_DIR, "tests", f"{directory}.mk")
            )
            run_make(makefile=mf, config=config, target="all")
        if explicit_elfs:
            elfs = [('explicit', Path(p).expanduser().resolve()) for p in explicit_elfs]
        else:
            config_build = os.path.abspath(
                os.path.join(ROOT_DIR, "build", config, "tests")
            )
            elfs  = sorted(
                (directory, elf)
                for directory in ELF_GROUP_DIRS[group]
                for elf in Path(os.path.join(config_build, directory)).rglob("*.elf")
            )
        missing = [elf[1] for elf in elfs if not elf[1].is_file()]
        if missing:
            raise pytest.UsageError(
                f"Missing ELF(s): {', '.join(str(p) for p in missing)}"
            )
        if not elfs:
            raise pytest.UsageError(
                f"No ELFs found for group {group!r}, config {config!r}"
            )

        for elf in elfs:
            grouped_cases.append((config, elf[0], elf[1]))
            cases.append((config, elf[1]))

    ids = [f"{config}-{test_dir}-{elf.stem}" for config, test_dir, elf in grouped_cases]

    # Each row pairs exactly one config with one ELF.
    # The config value is passed to cpu_fixture via request.param.
    metafunc.parametrize(
        ("cpu_fixture", "elf"),
        cases,
        indirect=["cpu_fixture"],
        ids=ids,
        scope="session"
    )

def pytest_collection_modifyitems(items):
    order0 = {
        "test_regcmp_runner": 0,
        "test_cosim_runner": 1,
    }
    order1 = {
        "bringup": 0,
        "rvgen": 1,
        "riscv-tests": 2,
        "explicit": 3
    }
    orders = [order0, order1]
    for order in orders:
        items.sort(
            key=lambda item: (
                order.get(item.originalname or item.name.split("[")[0], 99),
                item.nodeid,
            )
        )


@pytest.fixture(scope="session")
def cpu_fixture(request, hdl_session: HDL) -> HDL:
    config = request.param
    build_dir = os.path.join(
        ROOT_DIR, 'build', config, 'cocotb', 'sim_build' 
    )
    os.makedirs(build_dir, exist_ok=True)
    # Call bender make for this config, to make sure the flist file exists
    gen_bender_flist(config)

    # How to handle gate-level sim?
    hdl_session.build(
        always=False,
        library=f"{config}_top",
        sources=[],  # flist
        includes=[], # flist
        defines={
            'RVFI': int(RVFI),
            'RVFI_TRACE': int(RVFI_TRACE),
            'ASSERTIONS': int(ASSERTIONS)
        },
        toplevel=get_config_var("TOP_SIM", config),
        build_args=get_buildargs(config, WAVES, hdl_session.simulator),
        parameters=get_parameters(config),
        build_dir=str(build_dir),
        verbose=False,
        waves=False, # use buildargs for waveform gen (to get fst)
)
    hdl_session.cpu_build_dir = build_dir
    hdl_session.cpu_toplevel = get_config_var("TOP_SIM", config)
    return hdl_session

def elf_runner(cpu_fixture, elf, test_module):
    hex_file = elf2hex(elf)
    results_xml_dir = Path(cpu_fixture.cpu_build_dir).parent.joinpath(
        elf.relative_to(Path(cpu_fixture.cpu_build_dir).parent.parent)
    ).joinpath('results.xml')
    cpu_fixture.test(
        toplevel=cpu_fixture.cpu_toplevel,
        test_module=test_module,
        plusargs=[f"+MEM_INIT_FILE={hex_file.name}"],
        build_dir=cpu_fixture.cpu_build_dir,
        test_dir=get_make_var("TEST_COCOTB_DIR"),
        results_xml=results_xml,
        env={"ELF_FILE": elf}
    )

# @pytest.fixture(scope="session")
# def top_test_fixture(hdl: HDL) -> HDL:
#     build_args = DEFAULT_ARGS
#     build_args = proc_env_args(build_args)
#     hdl.toplevel = "rvj1_test_top"
#     hdl.build(
#         build_args = build_args,
#         parameters = {
#             "IRAM_BASE_ADDR": 0x8000_0000, 
#             "IRAM_WORD_SIZE": (1 << 8),
#             "DRAM_BASE_ADDR": (0x8000_0000 + ((1 << 8) * 4)),
#             "DRAM_WORD_SIZE": (1 << 8),
#             "DmRomAddr": 0x8000_0050,
#         },
#         waves = False,
#     )
#     return hdl

# @pytest.fixture
# def cosim_fixture(hdl: HDL) -> HDL:
#     build_args = DEFAULT_ARGS
#     build_args += ["--timing"]
#     build_args = proc_env_args(build_args)
#     hdl.toplevel="rvj1_cosim_top"
#     hdl.build(
#         build_args = build_args,
#         waves      = False
#     )
#     return hdl

# @pytest.fixture
# def ifu_fixture(hdl: HDL) -> HDL:
#     build_args = DEFAULT_ARGS
#     build_args = proc_env_args(build_args)
#     hdl.toplevel = "ifu_mem_test_top"
#     hdl.build(
#         build_args = build_args,
#         parameters = {"BASE_ADDR": 0x8000_0000, "MEM_SIZE_WORDS":64},
#         always=True,
#         waves = False,
#     )
#     return hdl

# @pytest.fixture
# def lsu_fixture(hdl: HDL) -> HDL:
#     build_args = DEFAULT_ARGS
#     build_args = proc_env_args(build_args)
#     hdl.toplevel = "lsu_mem_test_top"
#     hdl.build(
#         build_args = build_args,
#         parameters = {"BASE_ADDR": 0x8000_0000, "MEM_SIZE_WORDS":64},
#         always=True,
#         waves = False,
#     )
#     return hdl
