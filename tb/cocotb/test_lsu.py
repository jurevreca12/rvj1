import os
from base import get_rtl_files, WAVES, RVFI, RVFI_TRACE, ASSERTIONS, get_runner
from forastero.io import IORole, io_suffix_style
from forastero import BaseBench
from forastero.monitor import MonitorEvent
from cocotb.triggers import ClockCycles
from rvj1.io import LsuIO, LsuRfIO, LsuExcIO
from rvj1.request import LsuInitiator
from rvj1.response import LsuRfMonitor, LsuExcMonitor
from rvj1.sequence import lsu_drive_seq
from rvj1.transaction import LsuRequest, LsuCmd, LsuRfResponse, LsuExcResponse


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
)
async def smoke(tb: LsuTB, log):
    await ClockCycles(tb.clk, 10)


@LsuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,
)
async def basic_write_read_word(tb: LsuTB, log):
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
)
@LsuTB.parameter("cmd", bool, [LsuCmd.STORE_WORD, LsuCmd.LOAD_WORD])
async def bus_error(tb: LsuTB, log, cmd):
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




if __name__ == "__main__":
    sim = os.getenv("SIM", default="verilator")
    build_args = ["-Wno-fatal", "--no-stop-fail"]
    if WAVES:
        build_args += ["--trace-fst"]
    if RVFI:
        build_args += [f"-DRVFI"]
    if RVFI_TRACE:
        build_args += [f"-DRVFI_TRACE"]
    if ASSERTIONS:
        build_args += [f"-DASSERTIONS"]
    runner = get_runner(sim)
    runner.build(
        sources=get_rtl_files("verilog"),
        includes=["/rvj1/rtl/inc"],
        build_args=build_args,
        hdl_toplevel="lsu_mem_test_top",
        parameters={"BASE_ADDR": 0x8000_0000, "MEM_SIZE_WORDS":64},
        always=True,
        waves=False,
    )
    runner.test(
        hdl_toplevel="lsu_mem_test_top", 
        test_module="test_lsu"
    )
