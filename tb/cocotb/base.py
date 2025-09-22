import os
import glob
from pathlib import Path
from cocotb_tools.runner import get_runner

RTL_DIRS = (
    "/foss/designs/riscv-jedro-1/rtl/inc",  # needs to be before others
    "/foss/designs/riscv-jedro-1/rtl",
    "/foss/designs/riscv-jedro-1/tb/support",
    "/foss/designs/riscv-jedro-1/tb/riscof-plugin/tb/",
)
LANGUAGE = os.getenv("HDL_TOPLEVEL_LANG", "verilog").lower().strip()
WAVES = os.getenv("WAVES", default=False)


def get_rtl_files(lang):
    rtl_files = []
    if lang == "verilog":
        for rootdir in RTL_DIRS:
            rtl_files += list(glob.glob(f"{rootdir}/**/*.v", recursive=True))
            rtl_files += list(glob.glob(f"{rootdir}/**/*.sv", recursive=True))
    else:
        raise NotImplementedError

    # Remove duplicates, while preserving order (defines must be first)
    rtl_files = list(map(lambda x: Path(x), rtl_files))
    seen = set()
    rtl_files = [x for x in rtl_files if not (x in seen or seen.add(x))]
    return rtl_files


def get_test_runner(hdl_top):
    sim = os.getenv("SIM", default="verilator")
    build_args = ["-Wno-fatal"]
    if WAVES:
        build_args += ["--trace-fst"]
    runner = get_runner(sim)
    runner.build(
        sources=get_rtl_files(LANGUAGE),
        includes=["/riscv-jedro-1/rtl/inc"],
        build_args=build_args,
        hdl_toplevel=hdl_top,
        always=True,
        waves=False,
    )
    return runner
