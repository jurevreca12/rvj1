import os
from filelock import FileLock
from typing import Callable, Any
from subprocess import run
from pathlib import Path
import pytest
from util import elf2hex
from util import get_exit_addr
from util import (get_make_var, 
                  get_valid_configs, 
                  get_config_var,
                  get_buildargs,
                  gen_bender_flist,
                  run_make,
                  MAIN_MK)
from pytest import FixtureRequest, Module
from cocotb.handle import SimHandleBase
from cocotb_tools._pytest.fixtures import dut
from cocotb_tools.runner import get_runner
import cocotb

ROOT_DIR   = get_make_var("ROOT_DIR")
CONFIGS    = get_valid_configs()

ELF_GROUP_DIRS = {
    "regcmp": ["bringup"],
    "cosim": ["rvgen", "riscv-tests"],
}
SKIP_LIST = (
    "rv32ic-bringup-misaligned_jal", # C extension has no misaligned jumps
)

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
    parser.addoption("--case", action="append", default=[])

def pytest_generate_tests(metafunc):
    if "elf" in metafunc.fixturenames:
        generate_elf_cases(metafunc)
    elif 'lsu_fixture' in metafunc.fixturenames:
        generate_lsu_cases(metafunc)

def generate_elf_cases(metafunc):
    marker = metafunc.definition.get_closest_marker("elf_group")
    if marker is None or not marker.args:
        raise pytest.UsageError(
            f"{metafunc.definition.name} needs @pytest.mark.elf_group('regcmp' or 'cosim')"
        )

    elf_group = marker.args[0]
    if elf_group not in ELF_GROUP_DIRS:
        raise pytest.UsageError(f"Unknown ELF group: {elf_group}")

    requested_configs = metafunc.config.getoption("--config")
    configs = requested_configs if requested_configs else CONFIGS

    unknown = set(configs) - set(CONFIGS)
    if unknown:
        raise pytest.UsageError(f"Unknown config(s): {', '.join(sorted(unknown))}")

    explicit_elfs = metafunc.config.getoption("--elf")
    rows = []

    for config in configs:
        run_make(
            makefile=MAIN_MK,
            config=config,
            target="devtreeblob"
        )
        for directory in ELF_GROUP_DIRS[elf_group]:
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
                for directory in ELF_GROUP_DIRS[elf_group]
                for elf in Path(os.path.join(config_build, directory)).rglob("*.elf")
            )
        missing = [elf[1] for elf in elfs if not elf[1].is_file()]
        if missing:
            raise pytest.UsageError(
                f"Missing ELF(s): {', '.join(str(p) for p in missing)}"
            )
        if not elfs:
            raise pytest.UsageError(
                f"No ELFs found for elf group {elf_group!r}, config {config!r}"
            )
        for directory, elf in elfs:
            if f"{config}-{directory}-{elf.stem}" in SKIP_LIST:
                continue
            rows.append(
                pytest.param(
                    config,
                    elf,
                    id=f"{config}-{directory}-{elf.stem}",
                )
            )
    if cocotb.is_simulation:
        current_elf = Path(os.environ["ELF_FILE"])
        rows = list(filter(lambda row: (row.values[1] == current_elf), rows))

    # Each row pairs exactly one config with one ELF.
    # The config value is passed to cpu_fixture via request.param.
    metafunc.parametrize(
        ("cpu_build", "elf"),
        rows,
        indirect=["cpu_build"],
        scope="session"
    )

def generate_lsu_cases(metafunc):
    if "burst_len" in metafunc.fixturenames:
        choices = [os.environ["LSU_BURST_LEN"]] if cocotb.is_simulation else ["4", "6", "9"]
        metafunc.parametrize("burst_len", choices)
    if "cmd" in metafunc.fixturenames:
        choices = [os.environ["LSU_CMD"]] if cocotb.is_simulation else ["STORE", "LOAD"]
        metafunc.parametrize("cmd", choices)

def pytest_collection_modifyitems(config, items):
    cases = config.getoption("--case")
    if cases:
        selected = [
            item for item in items
            if any(item.nodeid.endswith(f"[{case}]") for case in cases)
        ]
        deselected = [item for item in items if item not in selected]

        if deselected:
            config.hook.pytest_deselected(items=deselected)
            items[:] = selected
    order0 = {
        "regcmp": 0,
        "cosim": 1,
    }
    order1 = {
        "bringup": 0,
        "rvgen": 1,
        "riscv-tests": 2,
        "explicit": 3
    }
    order2 = {
        "rvj1_ifu" : 0,
        "rvj1_ifu_rvc": 1
    }
    orders = (order0, order1, order2)
    for order in orders:
        items.sort(
            key=lambda item: (
                order.get(item.originalname or item.name.split("[")[0], 99),
                item.nodeid,
            )
        )

@pytest.fixture(scope="session")
def cpu_build(request: FixtureRequest, worker_id):
    config = request.param
    root_build_dir = Path(
        ROOT_DIR, 'build', config, 'cocotb' 
    )
    root_build_dir.mkdir(exist_ok=True)
    build_dir = root_build_dir / 'sim_build'
    lock_path =  root_build_dir / '.lock'
    ready_path = root_build_dir / '.complete'
    runner = get_runner('verilator')
    hdl_toplevel = get_config_var("TOP_SIM", config)
    with FileLock(str(lock_path)):
        if not ready_path.exists():
            # Call bender make for this config, to make sure the flist file exists
            gen_bender_flist(config)
            runner.build(
                always=True,
                sources=[],  # flist
                includes=[], # flist
                defines={
                    'RVFI': int(RVFI),
                    'RVFI_TRACE': int(RVFI_TRACE),
                    'ASSERTIONS': int(ASSERTIONS)
                },
                hdl_toplevel=hdl_toplevel,
                build_args=get_buildargs(config, WAVES, 'verilator'),
                parameters={
                    'CompressedEnabled': int('c' in config)
                },
                build_dir=str(build_dir),
                verbose=False,
                waves=False, # use buildargs for waveform gen (to get fst)
            )
            ready_path.write_text("BUILD COMPLETE\n")
        return (runner, hdl_toplevel, build_dir)

@pytest.fixture()
def cpu_fixture(request: FixtureRequest, cpu_build) -> Callable[[], Any] | SimHandleBase:
    (runner, hdl_toplevel, build_dir) = cpu_build
    config = request.node.callspec.params["cpu_build"]
    elf = request.node.callspec.params["elf"]
    hex_file = elf2hex(elf)
    exit_addr = get_exit_addr(elf)
    print(f"Using  the exit address: {hex(exit_addr)}")
    return lambda: runner.test(
        hdl_toplevel=hdl_toplevel,
        hdl_toplevel_lang='verilog',
        test_module=request.module.__name__,
        plusargs=[f"+MEM_INIT_FILE={str(hex_file)}"],
        build_dir=build_dir,
        test_dir=get_make_var("TEST_COCOTB_DIR"),
        #results_xml=results_xml,
        extra_env={
            "ELF_FILE": elf,
            "DTB_FILE": f"/workspaces/rvj1/build/{config}/config/sim.dtb",
            "EXIT_ADDR": str(exit_addr),
        },
        verbose=True
    )


@pytest.fixture(scope="session", params=["rvj1_ifu", "rvj1_ifu_rvc"])
def ifu_build(request):
    config = request.param
    root_build_dir = Path(
        ROOT_DIR, 'build', config, 'sim_build' 
    )
    root_build_dir.mkdir(exist_ok=True)
    build_dir = root_build_dir / 'sim_build'
    lock_path =  root_build_dir / '.lock'
    ready_path = root_build_dir / '.complete'
    is_compressed = int(config == "rvj1_ifu_rvc")
    runner = get_runner('verilator')
    with FileLock(str(lock_path)):
        if not ready_path.exists():
            # Call bender make to make sure the flist file exists
            gen_bender_flist(config)
            runner.build(
                hdl_toplevel = "ifu_mem_test_top",
                build_args = get_buildargs(config),
                parameters = {
                    "CompressedEnabled" : is_compressed,
                    "BASE_ADDR": 0x8000_0000, 
                    "MEM_SIZE_WORDS": 64
                },
                build_dir=build_dir,
                always=True,
                waves = False,
            )
            ready_path.write_text("BUILD COMPLETE\n")
    return (runner, request.param, build_dir)

@pytest.fixture()
def ifu_fixture(request: FixtureRequest, ifu_build) -> Callable[[], Any] | SimHandleBase:
    (runner, hdl_toplevel, build_dir) = ifu_build
    return lambda: runner.test(
        hdl_toplevel="ifu_mem_test_top",
        hdl_toplevel_lang='verilog',
        test_module=request.module.__name__,
        plusargs=[f"+MEM_INIT_FILE=/workspaces/rvj1/tests/cocotb/ifu_test_mem.hex"],
        build_dir=build_dir,
        test_dir=get_make_var("TEST_COCOTB_DIR"),
        #results_xml=results_xml,
        verbose=True
    )

@pytest.fixture(scope="session")
def lsu_build(request):
    root_build_dir = Path(
        ROOT_DIR, 'build', 'lsu', 'sim_build' 
    )
    root_build_dir.mkdir(exist_ok=True)
    build_dir = root_build_dir / 'sim_build'
    lock_path =  root_build_dir / '.lock'
    ready_path = root_build_dir / '.complete'

    runner = get_runner('verilator')
    with FileLock(str(lock_path)):
        if not ready_path.exists():
            # Call bender make to make sure the flist file exists
            gen_bender_flist("lsu")
            runner.build(
                hdl_toplevel = "lsu_mem_test_top",
                build_args = get_buildargs("lsu"),
                parameters = {
                    "BASE_ADDR": 0x8000_0000, 
                    "MEM_SIZE_WORDS": 64
                },
                build_dir=build_dir,
                always=True,
                waves = False,
            )
            ready_path.write_text("BUILD COMPLETE\n")
    return (runner, build_dir)

@pytest.fixture()
def lsu_fixture(request: FixtureRequest, lsu_build) -> Callable[[], Any] | SimHandleBase:
    (runner, build_dir) = lsu_build
    print(f"\nREQUEST: {request}")
    print(f"NODE: {request.node}")
    print(f"NODEID: {request.node.nodeid}")
    print(f"FIxturename: {request.fixturename}")
    if hasattr(request, "_parent_request"):
        print("PARENT REQUEST:", request._parent_request)
        print("PARENT NODE:", request._parent_request.node)
        print("PARENT NODEID:", request._parent_request.node.nodeid)
    callspec = getattr(request.node, "callspec", None)
    params = callspec.params if callspec is not None else {}
    cmd = params.get('cmd', "")
    burst_len = params.get('burst_len', "")
    return lambda: runner.test(
        hdl_toplevel="lsu_mem_test_top",
        hdl_toplevel_lang='verilog',
        test_module=request.module.__name__,
        plusargs=[],
        build_dir=build_dir,
        test_dir=get_make_var("TEST_COCOTB_DIR"),
        #results_xml=results_xml,
        extra_env={
            "LSU_CMD": cmd,
            "LSU_BURST_LEN": burst_len
        },
        verbose=True
    )