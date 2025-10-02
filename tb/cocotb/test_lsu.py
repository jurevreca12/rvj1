from base import get_test_runner, WAVES
from mapped.io import MappedRequestIO, MappedResponseIO
from mapped.request import MappedRequestMonitor, MappedRequestResponder
from mapped.response import MappedResponseInitiator
from mapped.transaction import MappedRequest, MappedAccess
from forastero.io import IORole, io_suffix_style
from forastero import BaseBench
from forastero.monitor import MonitorEvent
from cocotb.triggers import ClockCycles
from rvj1.io import LsuIO
from rvj1.request import LsuInitiator
from rvj1.sequence import lsu_drive_seq
from rvj1.transaction import LsuRequest, LsuCmd
from memory import RandomAccessMemory


def test_lsu_runner():
    runner = get_test_runner("jedro_1_lsu")
    runner.test(hdl_toplevel="jedro_1_lsu", test_module="test_lsu", waves=WAVES)


class LsuTB(BaseBench):
    def __init__(self, dut):
        super().__init__(dut, clk=dut.clk_i, rst=dut.rstn_i, rst_active_high=False)
        data_req_io = MappedRequestIO(
            dut, "data_req", IORole.INITIATOR, io_style=io_suffix_style
        )
        self.register(
            "data_req_mon", MappedRequestMonitor(self, data_req_io, self.clk, self.rst)
        )
        self.register(
            "data_req_drv",
            MappedRequestResponder(
                self, data_req_io, self.clk, self.rst, blocking=False
            ),
            scoreboard=False,
        )
        data_rsp_io = MappedResponseIO(
            dut, "data_rsp", IORole.RESPONDER, io_style=io_suffix_style
        )
        self.register(
            "data_rsp_drv",
            MappedResponseInitiator(self, data_rsp_io, self.clk, self.rst),
            scoreboard=False,
        )
        self.memory = RandomAccessMemory(
            self,
            request=self.data_req_mon,
            req_respond=self.data_req_drv,
            response=self.data_rsp_drv,
        )
        lsu_io = LsuIO(dut, "lsu", IORole.INITIATOR, io_style=io_suffix_style)
        self.register("lsu_drv", LsuInitiator(self, lsu_io, self.clk, self.rst))

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


@LsuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,
)
async def smoke(tb: LsuTB, log):
    await ClockCycles(tb.clk, 10)


def linear_write_words(base_addr: int, data: list[int]) -> list[LsuRequest]:
    addr = base_addr
    requests = []
    for d in data:
        requests.append(LsuRequest(cmd=LsuCmd.STORE_WORD, addr=addr, data=d, regdest=0))
        addr += 4
    return requests


def linear_write_words_ref(base_addr: int, data: list[int]) -> list[MappedRequest]:
    addr = base_addr
    requests = []
    for d in data:
        requests.append(
            MappedRequest(
                address=addr, mode=MappedAccess.WRITE, data=d, strobe=int("F", 16)
            )
        )
        addr += 4
    return requests


@LsuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,
)
@LsuTB.parameter("delay", int, [0, 1, 2, 3])
async def store_seq(tb: LsuTB, log, delay):
    tb.memory.set_delay(lambda _: delay)
    requests = linear_write_words(base_addr=int("6000_0000", 16), data=range(1, 17))
    tb.schedule(lsu_drive_seq(lsu_drv=tb.lsu_drv, requests=requests))
    ref_trans = linear_write_words_ref(
        base_addr=int("6000_0000", 16), data=range(1, 17)
    )
    tb.scoreboard.channels["data_req_mon"].push_reference(*ref_trans)
    for d in range(1, 17):
        await tb.data_req_mon.wait_for(MonitorEvent.CAPTURE)


if __name__ == "__main__":
    test_lsu_runner()
