from forastero import BaseBench
from forastero.io import IORole, io_suffix_style, io_plain_style
from rvfi.response import RvfiMonitor
from rvj1.io import IrqIO
from rvj1.request import IrqDriver

class CpuTB(BaseBench):
    def __init__(self, dut):
        super().__init__(dut, clk=dut.clk, rst=dut.rstn, rst_active_high=False)
        irq_io   = IrqIO(dut, "irq",  IORole.RESPONDER, io_style=io_suffix_style)
        self.register("irq_drv", IrqDriver(self, irq_io, self.clk, self.rst, blocking=False), scoreboard=False)
        rvfi_io  = RvfiIO (dut, "rvfi", IORole.INITIATOR, io_style=io_plain_style)
        self.register("rvfi_mon", RvfiMonitor(self, rvfi_io, self.clk, self.rst), scoreboard=False)

    async def initialise(self) -> None:
        """Initialise the DUT's I/O"""
        self.rst.value = 1
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
        self.rst.value = 1
        # Initialise I/O
        if init:
            await self.initialise()
        # Wait before dropping reset
        if wait_during > 0:
            await ClockCycles(self.clk, wait_during)
        # Drop reset
        self.rst.value = 0
        # Wait for a bit
        if wait_after > 0:
            self.info(f"Waiting for {wait_after} cycles")
            await ClockCycles(self.clk, wait_after)
        self.rst.value = 1