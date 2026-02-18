from base import get_rtl_files
from forastero.io import IORole, io_suffix_style
from forastero import BaseBench
from forastero.monitor import MonitorEvent
from forastero.driver import DriverEvent
from cocotb.triggers import ClockCycles
from rvj1.io import IfuToDecoderIO, IfuJmpIO, IfuErrorIO
from rvj1.request import IfuJmpInitiator
from rvj1.response import IfuToDecMonitor, DecoderResponder, IfuErrorMonitor
from rvj1.sequence import ifu_jmp_to_addr, dec_backpressure_seq
from rvj1.transaction import InstrAddrResponse, IfuErrorResponse
import os

from base import WAVES, RVFI, RVFI_TRACE, ASSERTIONS

import pytest
from cocotb_tools.pytest.hdl import HDL
from cocotb_tools.runner import get_runner

@pytest.fixture
def ifu_test_fixture(hdl: HDL) -> HDL:
    hdl.toplevel = "ifu_mem_test_top"
    hdl.sources = get_rtl_files("verilog")
    hdl.build()
    return hdl


def test_simple_runner(ifu_test_fixture):
    ifu_test_fixture.test(
        toplevel=ifu_test_fixture.toplevel, 
        test_module="test_ifu",
        parameters={"BASE_ADDR": 0x8000_0000, "MEM_SIZE_WORDS":64},
        plusargs=["+MEM_INIT_FILE0=/foss/designs/rvj1/tb/cocotb/ifu_test_mem.hex"]
    )


class IfuTB(BaseBench):
    def __init__(self, dut):
        super().__init__(dut, clk=dut.clk_i, rst=dut.rstn_i, rst_active_high=False)
        dec_io = IfuToDecoderIO(dut, "dec", IORole.INITIATOR, io_style=io_suffix_style)
        ifu_jmp_io = IfuJmpIO(dut, "jmp", IORole.RESPONDER, io_style=io_suffix_style)
        ifu_err_io = IfuErrorIO(dut, "error", IORole.INITIATOR, io_style=io_suffix_style)
        self.register("dec_mon", IfuToDecMonitor(self, dec_io, self.clk, self.rst))
        self.register(
            "dec_resp_drv",
            DecoderResponder(self, dec_io, self.clk, self.rst, blocking=False),
        )
        self.register(
            "ifu_jmp_drv",
            IfuJmpInitiator(self, ifu_jmp_io, self.clk, self.rst)
        )
        self.register("err_mon", IfuErrorMonitor(self, ifu_err_io, self.clk, self.rst))
        self.dec_mon.subscribe(MonitorEvent.CAPTURE, self.push_reference)
        self.counter = 1


    def push_reference(self, monitor, event, obj) -> None:
        self.scoreboard.channels["dec_mon"].push_reference(InstrAddrResponse(instr=self.counter))
        self.counter += 1
        if self.dut.jmp_addr_valid_i.value == 1:
            addr = int(self.dut.jmp_addr_i.value)
            self.counter = int(((addr - 0x8000_0000) / 4) + 1)

        
		

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
    shutdown_loops=2,

)
async def smoke(tb: IfuTB, log):
    await ClockCycles(tb.clk, 10)


@IfuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=1000,
    shutdown_delay=1,
    shutdown_loops=2,

)
async def linear_run(tb: IfuTB, log):
    log.info("Scheduling random backpressure on the decoder interface.")
    tb.schedule(dec_backpressure_seq(dec=tb.dec_resp_drv), blocking=False)
    log.info("Using the jump interface to set the IFU (boot) address.")
    tb.schedule(ifu_jmp_to_addr(ifu_jmp_drv=tb.ifu_jmp_drv, addr=0x8000_0000))
    await ClockCycles(tb.clk, 100)

@IfuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=1000,
    shutdown_delay=1,
    shutdown_loops=2,

)
async def run_and_jump(tb: IfuTB, log):
    log.info("Scheduling random backpressure on the decoder interface.")
    tb.schedule(dec_backpressure_seq(dec=tb.dec_resp_drv), blocking=False)
    log.info("Using the jump interface to set the IFU (boot) address.")
    tb.schedule(ifu_jmp_to_addr(ifu_jmp_drv=tb.ifu_jmp_drv, addr=0x8000_0000))
    await ClockCycles(tb.clk, 50)
    tb.schedule(ifu_jmp_to_addr(ifu_jmp_drv=tb.ifu_jmp_drv, addr=0x8000_006c))
    await ClockCycles(tb.clk, 50)


@IfuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=1000,
    shutdown_delay=0,
    shutdown_loops=0
)
async def response_error(tb: IfuTB, log):
    log.info("Scheduling random backpressure on the decoder interface.")
    tb.schedule(dec_backpressure_seq(dec=tb.dec_resp_drv), blocking=False)
    log.info("Using the jump interface to set the IFU (boot) address.")
    tb.schedule(ifu_jmp_to_addr(ifu_jmp_drv=tb.ifu_jmp_drv, addr=0x8000_0000))
    tb.scoreboard.channels['err_mon'].push_reference(IfuErrorResponse(addr=0x8000_0100))
    await tb.err_mon.wait_for(MonitorEvent.CAPTURE)

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
        hdl_toplevel="ifu_mem_test_top",
        parameters={"BASE_ADDR": 0x8000_0000, "MEM_SIZE_WORDS":64},
        always=True,
        waves=False,
    )
    runner.test(
        hdl_toplevel="ifu_mem_test_top", 
        test_module="test_ifu",
        plusargs=["+MEM_INIT_FILE0=/foss/designs/rvj1/tb/cocotb/ifu_test_mem.hex"]
    )
  
