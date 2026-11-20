import os
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
                  get_parameters,
                  gen_bender_flist,
                  run_make)
from pytest import FixtureRequest, Module
from cocotb.handle import SimHandleBase
from cocotb_tools._pytest.fixtures import dut
from cocotb_tools.runner import get_runner

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
        ("cpu_build", "elf"),
        cases,
        indirect=["cpu_build"],
        ids=ids,
        scope="session"
    )

def pytest_collection_modifyitems(items):
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
    orders = [order0, order1]
    for order in orders:
        items.sort(
            key=lambda item: (
                order.get(item.originalname or item.name.split("[")[0], 99),
                item.nodeid,
            )
        )


@pytest.fixture(scope="session")
def cpu_build(request: FixtureRequest):
    config = request.param
    build_dir = os.path.join(
        ROOT_DIR, 'build', config, 'cocotb', 'sim_build' 
    )
    os.makedirs(build_dir, exist_ok=True)
    # Call bender make for this config, to make sure the flist file exists
    gen_bender_flist(config)

    option = request.config.option
    runner = get_runner('verilator')

    hdl_toplevel = get_config_var("TOP_SIM", config)
    runner.build(
        always=False,
        sources=[],  # flist
        includes=[], # flist
        defines={
            'RVFI': int(RVFI),
            'RVFI_TRACE': int(RVFI_TRACE),
            'ASSERTIONS': int(ASSERTIONS)
        },
        hdl_toplevel=hdl_toplevel,
        build_args=get_buildargs(config, WAVES, 'verilator'),
        parameters=get_parameters(config),
        build_dir=str(build_dir),
        verbose=False,
        waves=False, # use buildargs for waveform gen (to get fst)
    )
    return (runner, hdl_toplevel, build_dir)

@pytest.fixture()
def cpu_fixture(request: FixtureRequest, cpu_build, elf) -> Callable[[], Any] | SimHandleBase:
    (runner, hdl_toplevel, build_dir) = cpu_build
    hex_file = elf2hex(elf)
    # results_xml = Path(build_dir).parent.joinpath(
    #    elf.relative_to(Path(build_dir).parent.parent)
    # ).joinpath('results.xml')
    return lambda: runner.test(
        hdl_toplevel=hdl_toplevel,
        hdl_toplevel_lang='verilog',
        test_module="test_regcmp",
        plusargs=[f"+MEM_INIT_FILE={str(hex_file)}"],
        build_dir=build_dir,
        test_dir=get_make_var("TEST_COCOTB_DIR"),
        #results_xml=results_xml,
        extra_env={"ELF_FILE": elf},
        verbose=True
    )
