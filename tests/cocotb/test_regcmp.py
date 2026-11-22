import os
import ast
import tempfile
import datetime
import pytest
from forastero.monitor import MonitorEvent
from cocotb.triggers import ClockCycles, ValueChange, with_timeout
from rvfi.io import RvfiIO
from rvj1.sequence import irq_rand_seq
from riscv.sim import sim_t
from riscv.cfg import cfg_t, mem_cfg_t
from riscv.debug_module import debug_module_config_t
from cpu_tb import CpuTB
import cocotb
from elftools.elf.elffile import ELFFile

DTB_FILE = "/workspaces/rvj1/tests/cocotb/cosim-rv32i.dtb"
START_PC = 0x8000_0000

ELF_FILES=(
    "/workspaces/rvj1/build/rv32i/tests/bringup/i/add.elf",
    "/workspaces/rvj1/build/rv32i/tests/bringup/i/addi.elf",
    "/workspaces/rvj1/build/rv32i/tests/bringup/i/andi.elf",
    "/workspaces/rvj1/build/rv32i/tests/bringup/i/srl.elf",
)

@CpuTB.testcase(
   reset_wait_during=2,
   reset_wait_after=2,
   timeout=2000000,
   shutdown_delay=2000,
   shutdown_loops=1,
   fixture="cpu_fixture"
)
@pytest.mark.cocotb
@pytest.mark.elf_group("regcmp")
async def test_regcmp(
    tb: CpuTB,
    cpu_fixture,
    elf,
    log
):
    log.info(f"Running test on {cpu_fixture} with ELF file:{elf}")

    # Get expected result from spike simulation
    spike_sim_res = spike_sim_elf(
        elf, 
        "rv32i_zicsr", 
        DTB_FILE, 
        START_PC,
        log
    )

    # get expected results in ELF file.
    exp_sim_res = elf_expected_results(elf, log)
    for reg, exp_val in exp_sim_res.items():
        spike_val = (spike_sim_res[reg] & 0xFFFF_FFFF)
        assert spike_val == exp_val, (
            f"Spike simulation result for register x{reg} does not match expected value from ELF file. "
            f"Spike: {hex(spike_val)}, Expected: {hex(exp_val)}"
        )

    # Now run the RTL simulation on DUT and compare results with spike simulation.
    regfile_inst = tb.dut.rvj1_inst.rvj1_inst.regfile_inst
    await with_timeout(
        ValueChange(regfile_inst.regfile[31]),
        1000,
        "ns"
    )
    if regfile_inst.regfile[31].value == 1:
        log.info(f"Reached exit condition (x31 == 1), ending RTL simulation.")

    # Compare RTL simulation results with spike simulation results.
    rtl_sim_res = {i: regfile_inst.regfile[i].value for i in range(32)}
    for reg, exp_val in exp_sim_res.items():
        rtl_val = rtl_sim_res[reg]
        assert rtl_val == exp_val, (
            f"RTL simulation result for register x{reg} does not match expected simulation result. "
            f"RTL: {hex(rtl_val)}, Expected: {hex(exp_val)}"
        )


def spike_sim_elf(elf_file, isa, dtb_file, start_pc, log) -> dict:
    "Simulates the elf file using spike and returns the final register state."
    # Setup simulator
    sim_cfg = cfg_t(
        isa=isa,
        priv="m",
        mem_layout=[mem_cfg_t(0x8000_0000, 0x1000_0000)],
        start_pc=start_pc
    )
    spike = sim_t(
        cfg = sim_cfg,
        halted = False,
        dtb_discovery = True,
        plugin_device_factories = [],
        args = [str(elf_file),],
        dtb_file = dtb_file,
        dm_config = debug_module_config_t()
    )
    hart0 = spike.get_core(0)
    spike.start() # Initialize simulation (load ELF, setup boot rom)
    hart0.reset()
    hart0.step(5) # Get out of trampoline
    assert (hart0.state.pc & 0xFFFF_FFFF) == start_pc, (
        f"After 5 steps PC should be {hex(start_pc)}, not {hex(hart0.state.pc)}."
    )
    while True:
        hart0.step(1)
        if hart0.state.XPR[31] == 1:
            log.info(f"Reached exit condition (x31 == 1), ending spike simulation.")
            break
    return hart0.state.XPR


def elf_expected_results(elf_file, log) -> dict | None:
    "Based on the elf file determines the expected results"
    with open(elf_file, 'rb') as f:
        elf = ELFFile(f)
        section = elf.get_section_by_name(".rodata")
        if section is not None:
            data = section.data()
            try:
                exp_results = ast.literal_eval(section.data().decode('ascii'))
                return exp_results
            except Exception as e:
                log.warning(f"Failed to parse expected results from .rodata section:")
                raise e
        else:
            raise ValueError(f"No expected results found in ELF file: {elf_file}")  

