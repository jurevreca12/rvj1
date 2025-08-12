
from base import get_test_runner, WAVES
from cocotb.triggers import ClockCycles
from cocotb.log import SimLog
from ifu import InstrMemIO, IfuDecIO, IfuJmpIO, InstrMemResponder, InstrMemTransaction, InstrMemMonitor
from forastero.io import IORole
from forastero import BaseBench
from forastero.driver import DriverEvent

def test_ifu_runner():
    runner = get_test_runner('jedro_1_ifu')
    runner.test(
        hdl_toplevel='jedro_1_ifu', 
        test_module= 'test_ifu',
        waves=WAVES
    )


class Testbench(BaseBench):
    def __init__(self, dut):
        super().__init__(dut, clk=dut.clk_i, rst=dut.rstn_i, rst_active_high=False)
        mem_io = InstrMemIO(dut, "instr", IORole.INITIATOR)
        #dec_io = IfuDecIO(dut, "dec", IORole.RESPONDER)
        #jmp_io = IfuJmpIO(dut, "jmp", IORole.RESPONDER)
        self.register(
            "mem_resp", 
            InstrMemResponder(
                self, 
                mem_io, 
                self.clk, 
                self.rst, 
                blocking=True
            ),
            scoreboard=False
        )
        # self.register(
        #     "mem_monitor",
        #     InstrMemMonitor(
        #         self,
        #         mem_io,
        #         self.clk,
        #         self.rst
        #     ),
        #     scoreboard=False
        # )

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



@Testbench.testcase(reset_wait_during=2, reset_wait_after=0, timeout=100, shutdown_delay=1, shutdown_loops=1)
async def smoke_test(tb : Testbench, log: SimLog):
    tb.mem_resp.enqueue(InstrMemTransaction(rdata=1234567))
    await tb.mem_resp.wait_for(DriverEvent.POST_DRIVE)

if __name__ == '__main__':
    test_ifu_runner()