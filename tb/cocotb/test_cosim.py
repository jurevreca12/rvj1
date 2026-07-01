import os
import tempfile
import datetime
from forastero import BaseBench
from forastero.io import IORole, io_suffix_style, io_plain_style
from forastero.monitor import MonitorEvent
from cocotb.triggers import ClockCycles
from rvfi.io import RvfiIO
from rvfi.response import RvfiMonitor
from rvfi.transaction import RvfiTransaction
from rvj1.io import IrqIO, DebugIO
from rvj1.request import IrqDriver
from rvj1.sequence import irq_rand_seq
from riscv.sim import sim_t
from riscv.cfg import cfg_t, mem_cfg_t
from riscv.debug_module import debug_module_config_t
import pytest
from base import get_rtl_files, get_inc_dirs
from base import WAVES, RVFI, RVFI_TRACE, ASSERTIONS
from cocotb_tools.pytest.hdl import HDL
from elftools.elf.elffile import ELFFile
import numpy as np

class CosimTB(BaseBench):
    def __init__(self, dut):
        super().__init__(dut, clk=dut.clk, rst=dut.rstn, rst_active_high=False)
        irq_io   = IrqIO   (dut, "irq",  IORole.RESPONDER, io_style=io_suffix_style)
        self.register("irq_drv", IrqDriver(self, irq_io, self.clk, self.rst))
        # debug_io = DebugIO(dut, "ext",  IORole.INITIATOR, io_style=io_suffix_style)
        rvfi_io  = RvfiIO (dut, "rvfi", IORole.INITIATOR, io_style=io_plain_style)
        self.register("rvfi_mon", RvfiMonitor(self, rvfi_io, self.clk, self.rst), scoreboard=False)

    async def initialise(self) -> None:
        """Initialise the DUT's I/O"""
        self.rst.value = 0
        for comp in self._components.values():
            comp.io.initialise(IORole.opposite(comp.io.role))

    async def reset(self, init=True, wait_during=10, wait_after=1) -> None:
        """
        Reset the DUT.

        :param init:        Initialise the DUT's I/O
        :param wait_during: Clock cycles to hold reset active for (defaults to 20)
        :param wait_after:  Clock cycles to wait after lowering reset (defaults to 1)
        """
        # Drive reset high
        self.rst.value = 0
        # Initialise I/O
        if init:
            await self.initialise()
        # Wait before dropping reset
        if wait_during > 0:
            await ClockCycles(self.clk, wait_during)
        # Drop reset
        self.rst.value = 1
        # Wait for a bit
        if wait_after > 0:
            self.info(f"Waiting for {wait_after} cycles")
            await ClockCycles(self.clk, wait_after)
 



@CosimTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=1000000,
    shutdown_delay=1,
    shutdown_loops=1,
)
@CosimTB.parameter("dtb_file", str, "/foss/designs/rvj1/tb/cocotb/new.dtb")
@CosimTB.parameter("start_pc", int, 0x8000_0000)
@CosimTB.parameter("generate_irqs", bool, [False,])
async def test_cosim(
    tb: CosimTB, 
    log, 
    generate_irqs, 
    dtb_file,
    start_pc,
):
    elf_file  = os.environ.get("ELF_FILE")
    exit_addr = int(os.environ.get("EXIT_ADDR"))
    # Setup simulator
    sim_cfg = cfg_t(
        isa="rv32i_zicsr_zifencei",
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
    spike.run() # Needed to initialize debug rom
    hart0.reset()
    hart0.step(5) # Get out of trampoline
    assert (hart0.state.pc & 0xFFFF_FFFF) == start_pc, (
        f"After 5 steps PC should be {hex(start_pc)}, not {hex(hart0.state.pc)}."
    )
    if generate_irqs:
        tb.schedule(irq_rand_seq(irq_drv=tb.irq_drv))
    #if generate_dbg:
    #    tb.schedule(dbg_seq(dmi_drv=tb.dmi_drv))
    while True:
        rvfi_msg = await tb.rvfi_mon.wait_for(MonitorEvent.CAPTURE)
        hart0.step(1)
        if (hart0.state.pc & 0xFFFF_FFFF) == exit_addr:
            log.info(f"Reached exit address {hex(exit_addr)}, ending simulation.")
            break
        try:
            compare(hart0.state, rvfi_msg, log)
        except AssertionError as e:
            log.error(f"Step and compare error at spike address: {hex(hart0.state.pc)}. Error message: {e}.")
            log.info("Running 10 clock cycles and then ending simulation.")
            await ClockCycles(tb.clk, 10)
            raise AssertionError(e)

    #while True:
    #    if state == NORM:
    #        rvfi_msg = await tb.rvfi_mon.wait_for(MonitorEvent.CAPTURE)
    #        compare()
    #    elif state == DBG:
    #        await tb.dmi_mon()?


def compare(state, rvfi_msg, log) -> bool:
    assert (state.pc & 0xFFFF_FFFF) == rvfi_msg.pc_wdata, (
        f"PC mismatch: {hex(state.pc & 0xFFFF_FFFF)} != {hex(rvfi_msg.pc_wdata)}."
    )
    if rvfi_msg.rd_addr > 0:
        assert (state.XPR[rvfi_msg.rd_addr] & 0xFFFF_FFFF) == rvfi_msg.rd_wdata, (
             f"Register {rvfi_msg.rd_addr} mismatch:" + 
             f"{hex(state.XPR[rvfi_msg.rd_addr] & 0xFFFF_FFFF)} != {hex(rvfi_msg.rd_wdata)}."
        )

@pytest.fixture
def cosim_fixture(hdl: HDL) -> HDL:
    build_args = ["-Wno-fatal", "--no-stop-fail", "-Wno-REDEFMACRO", "--timing"]
    if WAVES:
        build_args += ["--trace-fst", "--trace-structs"]
    if RVFI:
        build_args += ["-DRVFI"]
    if RVFI_TRACE:
        build_args += ["-DRVFI_TRACE"]
    if ASSERTIONS:
        build_args += ["-DASSERTIONS"]
    hdl.toplevel="rvj1_cosim_top"
    hdl.build(
        sources    = get_rtl_files(),
        includes   = get_inc_dirs(),
        build_args = build_args,
        waves      = False
    )
    return hdl

@pytest.mark.parametrize("elf_file", ('/foss/designs/rvj1/tb/cosim/dut.elf',))
def test_cosim_runner(cosim_fixture, elf_file):
    elf_name = elf_file.split("/")[-1].split('.')[0]
    now = datetime.datetime.now()
    now = now.strftime("%Y_%b_%d_%A_%I_%M_%S")
    hex_str = elf2hex(elf_file)
    exit_symbol = 'write_tohost'
    exit_addr = get_exit_addr(elf_file, exit_symbol)
    print(f"Using symbol {exit_symbol} address as an exit address: {hex(exit_addr)}")
    with tempfile.NamedTemporaryFile(
      prefix=f"{elf_name}_{now}", 
      suffix=".hex", 
      dir=tempfile.gettempdir(), 
      delete=False) as hex_file:
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
        print(f"Writting HEX to file: {hex_file.name}.")
        print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
        hex_file.write(hex_str)

    cosim_fixture.test(
        toplevel=cosim_fixture.toplevel,
        test_module="test_cosim",
        plusargs=[f"+MEM_INIT_FILE={hex_file.name}"],
        env={"ELF_FILE": elf_file, "EXIT_ADDR": str(exit_addr)}
    )

def elf2hex(elf_file) -> str:
    "Transforms .elf file to hex and writes it to hex_file"
    hex_str=""
    with open(elf_file, 'rb') as f:
        elf = ELFFile(f)
        for segment in elf.iter_segments():
            if segment['p_type'] == 'PT_LOAD':
                addr = segment['p_paddr']
                assert addr >= 0x8000_0000
                rel_addr = addr - 0x8000_0000
                hex_str += f"@{rel_addr:08x}\n"
                data = list(map(lambda d: f"{d:02x}", segment.data()))
                arr = np.array(data)
                narr = arr.reshape(-1, 4)
                for word in narr:
                    hex_str += word[3] + word[2] + word[1] + word[0] + "\n"
    return bytes(hex_str, 'utf-8')

def get_exit_addr(elf_file, exit_symbol='write_tohost') -> int:
    "Based on the elf file determines the exit address"
    with open(elf_file, 'rb') as f:
        elf = ELFFile(f)
        for section in elf.iter_sections():
            if section.name == ".symtab":
                symbol = section.get_symbol_by_name(exit_symbol)
                if symbol:
                    exit_addr = symbol[0]["st_value"]
                    return exit_addr

    raise KeyError(f"Symbol '{exit_symbol}' not found")

