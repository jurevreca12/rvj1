
from base import get_test_runner, WAVES
import cocotb
from cocotb.triggers import ClockCycles, RisingEdge
from mapped.io import MappedRequestIO, MappedResponseIO
from mapped.request import MappedRequestMonitor, MappedRequestResponder
from mapped.response import MappedResponseInitiator
from forastero.io import IORole, io_suffix_style 
from forastero import BaseBench
from forastero.monitor import MonitorEvent
from rvj1.io import IfuToDecoderIO
from rvj1.response import IfuToDecMonitor
from rvj1.transaction import InstrAddrResponse
from memory import RandomAccessMemory


def test_ifu_runner():
    runner = get_test_runner('jedro_1_ifu')
    runner.test(
        hdl_toplevel='jedro_1_ifu', 
        test_module='test_ifu',
        waves=WAVES
    )

class Testbench(BaseBench):
    def __init__(self, dut):
        super().__init__(dut, clk=dut.clk_i, rst=dut.rstn_i, rst_active_high=False)
        instr_req_io = MappedRequestIO(
            dut, "instr_req", IORole.INITIATOR, io_style=io_suffix_style
        )
        self.register("instr_req_mon", MappedRequestMonitor(
            self, instr_req_io, self.clk, self.rst
            ),
            scoreboard=False
        )
        self.register("instr_req_drv", MappedRequestResponder(
            self, instr_req_io, self.clk, self.rst
            ),
            scoreboard=False
        )
        instr_rsp_io = MappedResponseIO(
            dut, "instr_rsp", IORole.RESPONDER, io_style=io_suffix_style
        )
        self.register("instr_rsp_drv", MappedResponseInitiator(
            self, instr_rsp_io, self.clk, self.rst
            ),
            scoreboard=False
        )
        self.memory = RandomAccessMemory(
            self,
            request=self.instr_req_mon,
            req_respond=self.instr_req_drv,
            response=self.instr_rsp_drv,
        )
        ifu_dec_io = IfuToDecoderIO(
            dut, "dec", IORole.INITIATOR, io_style=io_suffix_style
        )
        self.register("ifu_dec_mon", IfuToDecMonitor(
            self, ifu_dec_io, self.clk, self.rst
        ))
        

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

def gen_memory_data(base_addr: int, data: list[int]) -> dict[int, int]:
    mem = {}
    assert len(data) > 0
    assert base_addr % 4 == 0
    for ind, da in enumerate(data):
        addr = base_addr + 4 * ind
        mem[addr] = da
    return mem

def mem_to_instr_addr_rsp(memory: dict[int,int], item_range="all") -> list[InstrAddrResponse]:
    responses = []
    if item_range == "all":
        item_range = range(0, len(memory))
    for index, (addr, data) in enumerate(memory.items()):
        if index in item_range:
            responses.append(
                InstrAddrResponse(
                    instr = data,
                    addr = addr
                )
            )
    return responses


@Testbench.testcase(reset_wait_during=2, reset_wait_after=0, timeout=70, shutdown_delay=1, shutdown_loops=1)
@Testbench.parameter("delay", int, [0, 1, 2, 3])
async def linear_run_const_delay(tb: Testbench, log, delay):
    test_mem = gen_memory_data(int("8000_0000", 16), range(1, 10))
    tb.memory.flash(test_mem)
    tb.memory.set_delay(lambda _: delay)
    ref_trans = mem_to_instr_addr_rsp(test_mem)
    tb.scoreboard.channels["ifu_dec_mon"].push_reference(*ref_trans)
    log.debug(f"Running a simple linear test of IFU with the following memory content:\n{str(tb.memory)}.")
    tb.dut.dec_ready_i.value = 1
    for _ in ref_trans:                                                                                                                   
        await tb.ifu_dec_mon.wait_for(MonitorEvent.CAPTURE)


@Testbench.testcase(reset_wait_during=2, reset_wait_after=0, timeout=70, shutdown_delay=1, shutdown_loops=1)
@Testbench.parameter("delay", int, [0, 1, 2, 3])
async def linear_run_and_jump(tb: Testbench, log, delay):
    "The 7th instruction is a jump instruction to 12."
    test_mem = gen_memory_data(int("8000_0000", 16), range(0, 19))
    tb.memory.flash(test_mem)
    ref_trans = mem_to_instr_addr_rsp(test_mem, list(range(0, 6 + 1)) + list(range(11, 19)))
    tb.scoreboard.channels["ifu_dec_mon"].push_reference(*ref_trans)
    tb.memory.set_delay(lambda _: delay)
    tb.dut.dec_ready_i.value = 1
    tb.dut.instr_req_ready_i.value = 1
    for _ in range(0, 6):                                                                                                                                                                                          
        await tb.ifu_dec_mon.wait_for(MonitorEvent.CAPTURE)
    tb.dut.jmp_addr_i.value = int("8000_0000", 16) + 4 * 11
    tb.dut.jmp_addr_valid_i.value = 1
    await RisingEdge(tb.clk)
    tb.dut.jmp_addr_valid_i.value = 0
    for _ in range(11, 19):                                                                                                                                                                                        
        await tb.instr_req_mon.wait_for(MonitorEvent.CAPTURE)
    tb.dut.instr_req_ready_i.value = 0
    while True:
        if tb.ifu_dec_mon.stats.captured == len(ref_trans):
            break
        await RisingEdge(tb.clk)

if __name__ == '__main__':
    test_ifu_runner()
