import os
import pytest
import tempfile
import datetime
from forastero.monitor import MonitorEvent
from cocotb.triggers import ClockCycles
from rvj1.sequence import irq_rand_seq
from riscv.sim import sim_t
from riscv.cfg import cfg_t, mem_cfg_t
from riscv.debug_module import debug_module_config_t
from elftools.elf.elffile import ELFFile
from cpu_tb import CpuTB

START_PC = 0x8000_0000

MCYCLE   = 0xB00
MINSTRET = 0xB02
MIP      = 0x344
CSRS = [
    ("mstatus", 0x300),
    ("mie",     0x304),
    ("mtvec",   0x305),
    ("mepc",    0x341),
    ("mcause",  0x342),
    ("mtval",   0x343),
    ("mip",     0x344) 
]

@CpuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=2,
    timeout=2000000,
    shutdown_delay=2000,
    shutdown_loops=1,
    fixture="cpu_fixture"
)
@pytest.mark.cocotb
@pytest.mark.elf_group("cosim")
async def test_cosim(
    tb: CpuTB,
    cpu_fixture,
    elf,
    log
):
    generate_irqs = False
    log.info(f"Running test with ELF file: {elf}")
    exit_addr = int(os.environ.get("EXIT_ADDR"))
    # Setup simulator
    sim_cfg = cfg_t(
        priv="m",
        mem_layout=[mem_cfg_t(0x8000_0000, 0x1000_0000)],
        start_pc=START_PC
    )
    spike = sim_t(
        cfg = sim_cfg,
        halted = False,
        dtb_discovery = True,
        plugin_device_factories = [],
        args = [str(elf),],
        dtb_file = os.environ['DTB_FILE'],
        dm_config = debug_module_config_t()
    )
    hart0 = spike.get_core(0)
    spike.start() # Initialize simulation (load ELF, setup boot rom)
    hart0.reset()
    hart0.step(5) # Get out of trampoline
    assert (hart0.state.pc & 0xFFFF_FFFF) == START_PC, (
        f"After 5 steps PC should be {hex(START_PC)}, not {hex(hart0.state.pc)}."
    )
    if generate_irqs:
        tb.schedule(irq_rand_seq(irq_drv=tb.irq_drv), blocking=False)
    while True:
        rvfi_msg = await tb.rvfi_mon.wait_for(MonitorEvent.CAPTURE)
        sync_hart_state(rvfi_msg, hart0)
        hart0.step(1)
        if rvfi_msg.pc_rdata == exit_addr:
            log.info(f"Reached exit address {hex(exit_addr)}, ending simulation.")
            break
        try:
            compare(hart0, rvfi_msg)
        except AssertionError as e:
            tb.log.error("Step and compare failed")
            tb.log.error("PC: %s", hex(rvfi_msg.pc_rdata))
            tb.log.error("RVFI message: %s", rvfi_msg)
            tb.log.info("Running 10 additional clock cycles before terminating...")
            await ClockCycles(tb.clk, 10)
            raise


def compare(hart, rvfi_msg) -> bool:
    assert (hart.state.pc & 0xFFFF_FFFF) == rvfi_msg.pc_wdata, (
        f"PC mismatch, spike_pc != rvfi_msg.pc_wdata: {hex(hart.state.pc & 0xFFFF_FFFF)} != {hex(rvfi_msg.pc_wdata)}."
    )
    if rvfi_msg.rd_addr > 0:
        assert (hart.state.XPR[rvfi_msg.rd_addr] & 0xFFFF_FFFF) == rvfi_msg.rd_wdata, (
             f"Register {rvfi_msg.rd_addr} mismatch: " + 
             f"{hex(hart.state.XPR[rvfi_msg.rd_addr] & 0xFFFF_FFFF)} != {hex(rvfi_msg.rd_wdata)}."
        )
    for csr,addr in CSRS:
        if getattr(rvfi_msg, f'csr_{csr}_wmask') != 0:
            assert (hart.get_csr(addr) & 0xFFFF_FFFF) == getattr(rvfi_msg, f'csr_{csr}_wdata'), (
                f"CSR register {csr} mismatch: " +
                f"{hex((hart.get_csr(addr) & 0xFFFF_FFFF))} != {hex(getattr(rvfi_msg, f'csr_{csr}_wdata'))}"
            )

def sync_hart_state(rvfi_msg, hart) -> None:
    """Syncs some CSR registers so that we get consistent results
    when comparing RVFI messages with the hart state."""
    # Sync perf counters
    hart.put_csr(MCYCLE, 0)
    hart.put_csr(MINSTRET, 0)
    if rvfi_msg.intr:
        hart.state.mip.backdoor_write_with_mask(0xFFFF_FFFF, rvfi_msg.csr_mip_rdata)
        hart.step(1)
        hart.state.mip.backdoor_write_with_mask(0xFFFF_FFFF, 0x0)
