from base import get_test_runner, WAVES
from forastero.io import IORole, io_suffix_style
from forastero import BaseBench
from cocotb.triggers import ClockCycles
from rvj1.io import IfuToDecoderIO
from rvj1.response import IfuToDecMonitor, DecoderResponder


class IfuTB(BaseBench):
    def __init__(self, dut):
        super().__init__(dut, clk=dut.clk_i, rst=dut.rstn_i, rst_active_high=False)
        dec_io = IfuToDecoderIO(dut, "dec", IORole.INITIATOR, io_style=io_suffix_style)
        self.register("dec_mon", IfuToDecMonitor(self, dec_io, self.clk, self.rst))
        self.register(
            "dec_resp_drv",
            DecoderResponder(self, dec_io, self.clk, self.rst, blocking=False),
        )

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


@IfuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,

)
async def smoke(tb: IfuTB, log):
    await ClockCycles(tb.clk, 10)



def test_ifu_runner():
    runner = get_test_runner("ifu_mem_test_top")
    runner.test(hdl_toplevel="ifu_mem_test_top", test_module="test_ifu", waves=WAVES)

if __name__ == "__main__":
    test_ifu_runner()
