import os
import tempfile
import datetime
import pytest
from forastero.monitor import MonitorEvent
from cocotb.triggers import ClockCycles, ValueChange
from rvfi.io import RvfiIO
from rvj1.sequence import irq_rand_seq
from riscv.sim import sim_t
from riscv.cfg import cfg_t, mem_cfg_t
from riscv.debug_module import debug_module_config_t
from cpu_tb import CpuTB
from conftest import elf_runner

DTB_FILE = "/workspace/rvj1/tb/cosim.dtb"
START_PC = 0x8000_0000

@CpuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=2,
    timeout=2000000,
    shutdown_delay=2000,
    shutdown_loops=1,
)
@pytest.mark.cocotb_test
async def test_regcmp(
    tb: CpuTB,
    log
):
    elf_file  = os.environ.get("ELF_FILE")
    log.info(f"Running test with ELF file: {elf_file}")

    # Get expected result from spike simulation
    spike_sim_res = spike_sim_elf(
        elf, 
        "rv32i_zicsr", 
        DTB_FILE, 
        START_PC
    )

    # See if user left expected results in ELF file.
    exp_sim_res = elf_expected_results(elf_file, log)
    if exp_sim_res is not None:
        for reg, exp_val in exp_sim_res.items():
            assert spike_sim_res[reg] == exp_val, (
                f"Spike simulation result for register x{reg} does not match expected value from ELF file. "
                f"Spike: {hex(spike_sim_res[reg])}, Expected: {hex(exp_val)}"
            )
    
    # Now run the RTL simulation on DUT and compare results with spike simulation.
    regfile_inst =  tb.dut.rvj1_inst.rvj1_inst.regfile_inst
    while True:
        await ValueChange(regfile_inst.regfile[31])
        if regfile_inst.regfile[31].value == 1:
            log.info(f"Reached exit condition (x31 == 1), ending simulation.")
            break

    # Compare RTL simulation results with spike simulation results.
    rtl_sim_res = {i: regfile_inst.regfile[i].value for i in range(32)}
    for reg, rtl_val in rtl_sim_res.items():
        assert rtl_val == spike_sim_res[reg], (
            f"RTL simulation result for register x{reg} does not match spike simulation result. "
            f"RTL: {hex(rtl_val)}, Spike: {hex(spike_sim_res[reg])}"
        )


def spike_sim_elf(elf_file, isa, dtb_file, start_pc) -> dict:
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
        args = [elf_file,],
        dtb_file = dtb_file,
        dm_config = debug_module_config_t()
    )
    hart0 = spike.get_core(0)
    spike.start() # Initialize simulation (load ELF, setup boot rom)
    hart0.reset()
    assert (hart0.state.pc & 0xFFFF_FFFF) == start_pc, (
        f"After 5 steps PC should be {hex(start_pc)}, not {hex(hart0.state.pc)}."
    )
    while True:
        hart0.step(1)
        if hart0.state.XPR[31] == 1:
            log.info(f"Reached exit condition (x31 == 1), ending simulation.")
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
            exp_results = ast.literal_eval(section.data())
            return exp_results
        except Exception as e:
            log.warning(f"Failed to parse expected results from .rodata section: {e}")
    else:
        log.warning(f"No expected results found in ELF file: {elf_file}")  
    return None


@pytest.mark.cocotb_runner
@pytest.mark.elf_group("regcmp")
def regcmp_runner(cpu_fixture, elf):
    elf_runner(cpu_fixture, elf, "test_regcmp")