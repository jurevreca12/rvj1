from base import get_test_runner, WAVES
from mapped.io import MappedRequestIO, MappedResponseIO
from mapped.request import MappedRequestMonitor, MappedRequestResponder
from mapped.response import MappedResponseInitiator
from forastero.io import IORole, io_suffix_style
from forastero import BaseBench
from forastero.monitor import MonitorEvent
from cocotb.triggers import RisingEdge, ClockCycles
from rvj1.io import IfuToDecoderIO
from rvj1.transaction import InstrAddrResponse
from rvj1.response import IfuToDecMonitor, DecoderResponder
from rvj1.sequence import dec_backpressure_seq
from memory import RandomAccessMemory, gen_memory_data, mem_to_instr_addr_rsp


def test_ifu_runner():
    runner = get_test_runner("rvj1_ifu")
    runner.test(hdl_toplevel="rvj1_ifu", test_module="test_ifu", waves=WAVES)


class IfuTB(BaseBench):
    def __init__(self, dut):
        super().__init__(dut, clk=dut.clk_i, rst=dut.rstn_i, rst_active_high=False)
        instr_req_io = MappedRequestIO(
            dut, "instr_req", IORole.INITIATOR, io_style=io_suffix_style
        )
        self.register(
            "instr_req_mon",
            MappedRequestMonitor(self, instr_req_io, self.clk, self.rst),
            scoreboard=False,
        )
        self.register(
            "instr_req_drv",
            MappedRequestResponder(
                self, instr_req_io, self.clk, self.rst, blocking=False
            ),
            scoreboard=False,
        )
        instr_rsp_io = MappedResponseIO(
            dut, "instr_rsp", IORole.RESPONDER, io_style=io_suffix_style
        )
        self.register(
            "instr_rsp_drv",
            MappedResponseInitiator(self, instr_rsp_io, self.clk, self.rst),
            scoreboard=False,
        )
        self.memory = RandomAccessMemory(
            self,
            request=self.instr_req_mon,
            req_respond=self.instr_req_drv,
            response=self.instr_rsp_drv,
        )
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
@IfuTB.parameter("delay", int, [0, 1, 2, 3])
async def linear_run_const_delay(tb: IfuTB, log, delay):
    test_mem = gen_memory_data(int("8000_0000", 16), range(1, 10))
    tb.memory.flash(test_mem)
    tb.memory.set_delay(lambda _: delay)
    ref_trans = mem_to_instr_addr_rsp(test_mem)
    tb.scoreboard.channels["dec_mon"].push_reference(*ref_trans)
    log.info(f"Linear run with the following memory content:\n{str(tb.memory)}.")
    tb.schedule(
        dec_backpressure_seq(dec=tb.dec_resp_drv, backpressure=0.0), blocking=False
    )
    for _ in ref_trans:
        await tb.dec_mon.wait_for(MonitorEvent.CAPTURE)


@IfuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,
)
@IfuTB.parameter("delay", int, [0, 1, 2, 3])
async def linear_run_and_jump(tb: IfuTB, log, delay):
    test_mem = gen_memory_data(int("8000_0000", 16), range(0, 19))
    tb.memory.flash(test_mem)
    tb.memory.set_delay(lambda _: delay)
    ref_trans0 = mem_to_instr_addr_rsp(test_mem, list(range(0, 6)))
    tb.scoreboard.channels["dec_mon"].push_reference(*ref_trans0)
    log.info(
        f"Linear run and jump test of IFU with the following memory content:\n{str(tb.memory)}."
    )
    tb.schedule(
        dec_backpressure_seq(dec=tb.dec_resp_drv, backpressure=0.0), blocking=False
    )
    for _ in range(0, 6):
        await tb.dec_mon.wait_for(MonitorEvent.CAPTURE)
    tb.dut.jmp_addr_i.value = int("8000_0000", 16) + 4 * 11
    tb.dut.jmp_addr_valid_i.value = 1
    await RisingEdge(tb.clk)
    tb.dut.jmp_addr_valid_i.value = 0
    if len(tb.scoreboard.channels["dec_mon"]._q_mon._entries) > 0:
        # Overshoot of IFU
        tb.scoreboard.channels["dec_mon"].push_reference(
            InstrAddrResponse(instr=6, addr=int("8000_0000", 16) + 4 * 6)
        )
    ref_trans1 = mem_to_instr_addr_rsp(test_mem, list(range(11, 19)))
    tb.scoreboard.channels["dec_mon"].push_reference(*ref_trans1)
    for _ in range(11, 19):
        await tb.dec_mon.wait_for(MonitorEvent.CAPTURE)


@IfuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,
)
@IfuTB.parameter("delay", int, [0, 1, 2, 3])
async def linear_run_const_delay_backpressure(tb: IfuTB, log, delay):
    test_mem = gen_memory_data(int("8000_0000", 16), range(1, 10))
    tb.memory.flash(test_mem)
    tb.memory.set_delay(lambda _: delay)
    ref_trans = mem_to_instr_addr_rsp(test_mem)
    tb.scoreboard.channels["dec_mon"].push_reference(*ref_trans)
    log.info(f"Linear run with the following memory content:\n{str(tb.memory)}.")
    tb.dut.dec_ready_i.value = 1
    tb.schedule(dec_backpressure_seq(dec=tb.dec_resp_drv), blocking=False)
    for _ in ref_trans:
        await tb.dec_mon.wait_for(MonitorEvent.CAPTURE)


@IfuTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=100,
    shutdown_delay=1,
    shutdown_loops=1,
)
@IfuTB.parameter("delay", int, [0, 1, 2, 3])
async def linear_run_and_jump_backpressure(tb: IfuTB, log, delay):
    test_mem = gen_memory_data(int("8000_0000", 16), range(0, 19))
    tb.memory.flash(test_mem)
    tb.memory.set_delay(lambda _: delay)
    ref_trans0 = mem_to_instr_addr_rsp(test_mem, list(range(0, 6)))
    tb.scoreboard.channels["dec_mon"].push_reference(*ref_trans0)
    log.info(
        f"Linear run and jump test of IFU with the following memory content:\n{str(tb.memory)}."
    )
    tb.schedule(dec_backpressure_seq(dec=tb.dec_resp_drv), blocking=False)
    for _ in range(0, 6):
        await tb.dec_mon.wait_for(MonitorEvent.CAPTURE)
    tb.dut.jmp_addr_i.value = int("8000_0000", 16) + 4 * 11
    tb.dut.jmp_addr_valid_i.value = 1
    await RisingEdge(tb.clk)
    tb.dut.jmp_addr_valid_i.value = 0
    if len(tb.scoreboard.channels["dec_mon"]._q_mon._entries) > 0:
        # Overshoot of IFU
        tb.scoreboard.channels["dec_mon"].push_reference(
            InstrAddrResponse(instr=6, addr=int("8000_0000", 16) + 4 * 6)
        )
    ref_trans1 = mem_to_instr_addr_rsp(test_mem, list(range(11, 19)))
    tb.scoreboard.channels["dec_mon"].push_reference(*ref_trans1)
    for _ in range(11, 19):
        await tb.dec_mon.wait_for(MonitorEvent.CAPTURE)


if __name__ == "__main__":
    test_ifu_runner()
