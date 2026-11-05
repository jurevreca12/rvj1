import os
import pytest
from cocotb_tools.pytest.hdl import HDL

DEF_SOURCES_FILE = os.path.join(os.path.dirname(__file__), "..", "sources.f")

WAVES        = os.getenv("WAVES",        default=False)
RVFI         = os.getenv("RVFI",         default=True)
RVFI_TRACE   = os.getenv("RVFI_TRACE",   default=False)
ASSERTIONS   = os.getenv("ASSERTIONS",   default=True)
SOURCES_FILE = os.getenv("SOURCES_FILE", default=DEF_SOURCES_FILE)

DEFAULT_ARGS = [
    "-Wno-fatal", 
    "--no-stop-fail", 
    "-Wno-REDEFMACRO",
    "-f", SOURCES_FILE,
]

def proc_env_args(build_args):
    if WAVES:
        build_args += ["--trace-fst", "--trace-structs"]
    if RVFI:
        build_args += [f"-DRVFI"]
    if RVFI_TRACE:
        build_args += [f"-DRVFI_TRACE"]
    if ASSERTIONS:
        build_args += [f"-DASSERTIONS"]
    return build_args

@pytest.fixture
def top_test_fixture(hdl: HDL) -> HDL:
    build_args = DEFAULT_ARGS
    build_args = proc_env_args(build_args)
    hdl.toplevel = "rvj1_test_top"
    hdl.build(
        build_args = build_args,
        parameters = {
            "IRAM_BASE_ADDR": 0x8000_0000, 
            "IRAM_WORD_SIZE": (1 << 8),
            "DRAM_BASE_ADDR": (0x8000_0000 + ((1 << 8) * 4)),
            "DRAM_WORD_SIZE": (1 << 8),
            "DmRomAddr": 0x8000_0050,
        },
        waves = False,
    )
    return hdl

@pytest.fixture
def cosim_fixture(hdl: HDL) -> HDL:
    build_args = DEFAULT_ARGS
    build_args += ["--timing"]
    build_args = proc_env_args(build_args)
    hdl.toplevel="rvj1_cosim_top"
    hdl.build(
        build_args = build_args,
        waves      = False
    )
    return hdl

@pytest.fixture
def ifu_fixture(hdl: HDL) -> HDL:
    build_args = DEFAULT_ARGS
    build_args = proc_env_args(build_args)
    hdl.toplevel = "ifu_mem_test_top"
    hdl.build(
        build_args = build_args,
        parameters = {"BASE_ADDR": 0x8000_0000, "MEM_SIZE_WORDS":64},
        always=True,
        waves = False,
    )
    return hdl

@pytest.fixture
def lsu_fixture(hdl: HDL) -> HDL:
    build_args = DEFAULT_ARGS
    build_args = proc_env_args(build_args)
    hdl.toplevel = "lsu_mem_test_top"
    hdl.build(
        build_args = build_args,
        parameters = {"BASE_ADDR": 0x8000_0000, "MEM_SIZE_WORDS":64},
        always=True,
        waves = False,
    )
    return hdl
