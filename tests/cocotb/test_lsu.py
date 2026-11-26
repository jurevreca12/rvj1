import pytest
from forastero.io import IORole, io_suffix_style
from forastero import BaseBench
from forastero.monitor import MonitorEvent
from cocotb.triggers import ClockCycles
from rvj1.io import LsuIO, LsuRfIO, LsuExcIO
from rvj1.request import LsuInitiator
from rvj1.response import LsuRfMonitor, LsuExcMonitor
from rvj1.sequence import lsu_drive_seq
from rvj1.transaction import LsuRequest, LsuCmd, LsuRfResponse, LsuExcResponse

str2cmd = {
    "STORE": LsuCmd.STORE_WORD,
    "LOAD": LsuCmd.LOAD_WORD
}

class LsuTB(BaseBench):
    def __init__(self, dut):
        super().__init__(dut, clk=dut.clk_i, rst=dut.rstn_i, rst_active_high=False)
        lsu_io = LsuIO(dut, "lsu", IORole.INITIATOR, io_style=io_suffix_style)
        self.register("lsu_drv", LsuInitiator(self, lsu_io, self.clk, self.rst))
        lsu_rf_io = LsuRfIO(dut, "rf", IORole.RESPONDER, io_style=io_suffix_style)
        self.register("lsu_rf_mon", LsuRfMonitor(self, lsu_rf_io, self.clk, self.rst))
        lsu_exc_io = LsuExcIO(dut, "exc", IORole.RESPONDER, io_style=io_suffix_style)
        self.register("lsu_exc_mon", LsuExcMonitor(self, lsu_exc_io, self.clk, self.rst))

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
    fixture="lsu_fixture"
)
async def smoke(lsu_fixture, tb: LsuTB, log):
    await ClockCycles(tb.clk, 10)


@LsuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,
    fixture="lsu_fixture"
)
async def basic_write_read_word(lsu_fixture, tb: LsuTB, log):
    tb.schedule(
        lsu_drive_seq(
            lsu_drv=tb.lsu_drv, 
            requests=[
                LsuRequest(
                    cmd = LsuCmd.STORE_WORD,
                    addr = 0x8000_0000,
                    data = 0xDEAD_BEEF,
                ),
                LsuRequest(
                    cmd = LsuCmd.LOAD_WORD,
                    addr = 0x8000_0000,
                    regdest = 1,
                )]
        )
    )
    tb.scoreboard.channels['lsu_rf_mon'].push_reference(
        LsuRfResponse(data=0xDEAD_BEEF, regdest=1)
    )
    await tb.lsu_rf_mon.wait_for(MonitorEvent.CAPTURE)


@LsuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,
    fixture="lsu_fixture"
)
async def burst_write_read_word(lsu_fixture, tb: LsuTB, log, burst_len):
    burst_len = int(burst_len)
    def gen_wr_req(i: int) -> LsuRequest:
        return LsuRequest(
            cmd = LsuCmd.STORE_WORD,
            addr = 0x8000_0000 + 4 * i,
            data = i + 1,
        )
    def gen_rd_req(i: int) -> LsuRequest:
        return LsuRequest(
            cmd = LsuCmd.LOAD_WORD,
            addr = 0x8000_0000 + 4 * i,
            regdest = i + 1
        )
    wr_reqs = [gen_wr_req(i) for i in range(burst_len)]
    rd_reqs = [gen_rd_req(i) for i in range(burst_len)]
    tb.schedule(
        lsu_drive_seq(
            lsu_drv=tb.lsu_drv, 
            requests=(wr_reqs + rd_reqs)
        )
    )
    tb.scoreboard.channels['lsu_rf_mon'].push_reference(
        *[LsuRfResponse(data=(i + 1), regdest=(i+1)) for i in range(burst_len)]
    )
    for _ in range(burst_len):
        await tb.lsu_rf_mon.wait_for(MonitorEvent.CAPTURE)


@LsuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,
    fixture="lsu_fixture"
)
async def bus_error(lsu_fixture, tb: LsuTB, log, cmd):
    cmd = str2cmd[cmd]
    tb.schedule(
        lsu_drive_seq(
            lsu_drv=tb.lsu_drv,
            requests=[
                LsuRequest(
                    cmd = cmd,
                    addr = 0x8000_0100,
                    regdest = 1
                )
            ]
        )
    )
    tb.scoreboard.channels['lsu_exc_mon'].push_reference(
        LsuExcResponse(
            load_access_fault = (cmd == LsuCmd.LOAD_WORD),
            store_access_fault = (cmd == LsuCmd.STORE_WORD),
            exc_addr = 0x8000_0100
        )
    )
    await tb.lsu_exc_mon.wait_for(MonitorEvent.CAPTURE)