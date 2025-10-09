from base import get_test_runner, WAVES
from mapped.io import MappedRequestIO, MappedResponseIO
from mapped.request import MappedRequestMonitor, MappedRequestResponder
from mapped.response import MappedResponseInitiator
from forastero.io import IORole, io_suffix_style
from forastero import BaseBench
from forastero.monitor import MonitorEvent
from cocotb.triggers import ClockCycles
from memory import RandomAccessMemory

from rvtests import (
    LUITest,
    AUIPCTest,
    ADDITest,
    SLTITest,
    SLTIUTest,
    XORITest,
    ORITest,
    ANDITest,
    SRLITest,
    SRAITest,
    ADDTest,
    SUBTest,
    SLLTest,
    SLTTest,
    SLTUTest,
    XORTest,
    SRLTest,
    SRATest,
    ORTest,
    ANDTest,
    SBLBTest,
)
from riscvmodel.program import Program
from riscvmodel.model import Model, State
from riscvmodel.variant import RV32I

RV32I_TESTS = {
    "lui": LUITest(),
    "auipc": AUIPCTest(),
    "addi": ADDITest(),
    "slti": SLTITest(),
    "sltiu": SLTIUTest(),
    "xori": XORITest(),
    "ori": ORITest(),
    "andi": ANDITest(),
    "srli": SRLITest(),
    "srai": SRAITest(),
    "add": ADDTest(),
    "sub": SUBTest(),
    "sll": SLLTest(),
    "slt": SLTTest(),
    "sltu": SLTUTest(),
    "xor": XORTest(),
    "srl": SRLTest(),
    "sra": SRATest(),
    "or": ORTest(),
    "and": ANDTest(),
    "sblb": SBLBTest(),
}


def test_insns_runner():
    runner = get_test_runner("rvj1_top")
    runner.test(hdl_toplevel="rvj1_top", test_module="test_insns", waves=WAVES)


class InsnsTB(BaseBench):
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
        self.instr_memory = RandomAccessMemory(
            self,
            request=self.instr_req_mon,
            req_respond=self.instr_req_drv,
            response=self.instr_rsp_drv,
        )
        data_req_io = MappedRequestIO(
            dut, "data_req", IORole.INITIATOR, io_style=io_suffix_style
        )
        self.register(
            "data_req_mon",
            MappedRequestMonitor(self, data_req_io, self.clk, self.rst),
            scoreboard=False,
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
        self.data_memory = RandomAccessMemory(
            self,
            request=self.data_req_mon,
            req_respond=self.data_req_drv,
            response=self.data_rsp_drv,
        )


def prog_to_mem(prog: Program, base_addr=int("8000_0000", 16)) -> dict:
    mem = {}
    addr = base_addr
    for insn in prog.insns:
        mem[addr] = insn.encode()
        addr += 4
    return mem


@InsnsTB.testcase(
    reset_wait_during=2,
    reset_wait_after=0,
    timeout=40,
    shutdown_delay=1,
    shutdown_loops=1,
)
@InsnsTB.parameter("insn", Program, [*RV32I_TESTS])
async def test_insn(tb: InsnsTB, log, insn):
    prog = RV32I_TESTS[insn]
    test_mem = prog_to_mem(prog)
    tb.instr_memory.flash(test_mem)
    tb.instr_memory.set_delay(lambda _: 0)
    tb.data_memory.set_delay(lambda _: 0)
    log.info(
        f"Testing instruction {insn} with instr memory content:\n{str(tb.instr_memory)}."
    )
    for _ in prog.insns:
        await tb.instr_req_mon.wait_for(MonitorEvent.CAPTURE)
    await ClockCycles(tb.clk, num_cycles=10)  # make sure everything is coputed
    state = State(RV32I, bootaddr=0x80000000)
    m = Model(state=state)
    m.execute(prog)
    for reg in range(0, 32):
        modval = str(m.state.intreg.regs[reg])  # hex string
        modval = format(int(modval, 16), "032b")  # binary string
        dutval = str(tb.dut.regfile_inst.regfile[reg].value)  # binary string
        assert (
            dutval == modval
        ), f"Expected value of {modval} in register {reg}. Instead got {dutval}."


if __name__ == "__main__":
    test_insns_runner()
