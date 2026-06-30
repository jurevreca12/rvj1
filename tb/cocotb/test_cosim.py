import os
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

from base import get_rtl_files, get_inc_dirs
from base import WAVES, RVFI, RVFI_TRACE, ASSERTIONS
from cocotb_tools.runner import get_runner

class CosimTB(BaseBench):
    def __init__(self, dut):
        super().__init__(dut, clk=dut.clk, rst=dut.rstn, rst_active_high=False)
        irq_io   = IrqIO   (dut, "irq",  IORole.RESPONDER, io_style=io_suffix_style)
        self.register("irq_drv", IrqDriver(self, irq_io, self.clk, self.rst))
        # debug_io = DebugIO(dut, "ext",  IORole.INITIATOR, io_style=io_suffix_style)
        rvfi_io  = RvfiIO (dut, "rvfi", IORole.INITIATOR, io_style=io_plain_style)
        self.register("rvfi_mon", RvfiMonitor(self, rvfi_io, self.clk, self.rst))

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
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,
)
@CosimTB.parameter("elf_file", str, "/foss/designs/rvj1/tb/cosim/dut.elf")
@CosimTB.parameter("dtb_file", str, "/foss/designs/rvj1/tb/cocotb/new.dtb")
@CosimTB.parameter("start_pc", int, 0x8000_0000)
@CosimTB.parameter("generate_irqs", bool, [False, True])
async def test_cosim(
    tb: CosimTB, 
    log, 
    generate_irqs, 
    elf_file, 
    dtb_file,
    start_pc,
):
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
        args = [elf_file],
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
    for i in range(500):
        rvfi_msg = await tb.rvfi_mon.wait_for(MonitorEvent.CAPTURE)
        hart0.step(1)
        print(rvfi_msg)

    #while True:
    #    if state == NORM:
    #        rvfi_msg = await tb.rvfi_mon.wait_for(MonitorEvent.CAPTURE)
    #        compare()
    #    elif state == DBG:
    #        await tb.dmi_mon()?

if __name__ == "__main__":
    sim = os.getenv("SIM", default="verilator")
    build_args = ["-Wno-fatal", "--no-stop-fail", "-Wno-REDEFMACRO", "--timing"]
    if WAVES:
        build_args += ["--trace-fst"]
    if RVFI:
        build_args += ["-DRVFI"]
    if RVFI_TRACE:
        build_args += [f"-DRVFI_TRACE"]
    if ASSERTIONS:
        build_args += [f"-DASSERTIONS"]
    runner = get_runner(sim)
    runner.build(
        sources=get_rtl_files(),
        includes=get_inc_dirs(),
        build_args=build_args,
        hdl_toplevel="rvj1_cosim_top",
        parameters={},
        always=True,
        waves=False,
    )
    runner.test(
        hdl_toplevel="rvj1_cosim_top", 
        test_module="test_cosim",
        plusargs=[]
    )
