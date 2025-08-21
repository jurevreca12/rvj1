
from base import get_test_runner, WAVES
from cocotb.triggers import ClockCycles
from cocotb.log import SimLog
from mapped.io import MappedRequestIO, MappedResponseIO
from mapped.request import MappedRequestResponder, MappedRequestMonitor
from mapped.response import MappedResponseInitiator
from mapped.sequences import mapped_req_no_backpressure_seq, mapped_responses_seq, gen_responses_noerr
from forastero.io import IORole, io_suffix_style 
from forastero import BaseBench
from rvj1.io import IfuToDecoderIO
from rvj1.response import IfuToDecMonitor
from rvj1.transaction import InstrAddrResponse
from memory import RandomAccessMemory
import random

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
        instr_rsp_io = MappedResponseIO(
            dut, "instr_rsp", IORole.RESPONDER, io_style=io_suffix_style
        )
        self.register("instr_rsp_drv", MappedResponseInitiator(
            self, instr_rsp_io, self.clk, self.rst
        ))
        self.memory = RandomAccessMemory(
            request=self.instr_req_mon,
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

def mem_to_instr_addr_rsp(memory: dict[int,int]) -> list[InstrAddrResponse]:
    responses = []
    for addr, data in memory.items():
        responses.append(
            InstrAddrResponse(
                instr = data,
                addr = addr
            )
        )
    return responses

@Testbench.testcase(reset_wait_during=2, reset_wait_after=0, timeout=100, shutdown_delay=1, shutdown_loops=1)
async def linear_run_const_delay(tb : Testbench, log: SimLog):
    test_mem = gen_memory_data(int("8000_0000", 16), range(1, 40))
    ref_trans = mem_to_instr_addr_rsp(test_mem)
    tb.memory.flash(test_mem)
    random.seed(42)
    tb.memory.set_delay(lambda _: random.randint(0, 2))
    tb.dut.dec_ready_i.value = 1
    tb.dut.instr_req_ready_i.value = 1
    tb.scoreboard.channels["ifu_dec_mon"].push_reference(*ref_trans)
    await ClockCycles(tb.clk, 10000)
    
    
if __name__ == '__main__':
    test_ifu_runner()