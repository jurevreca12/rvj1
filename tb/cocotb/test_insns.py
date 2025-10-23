from base import get_test_runner, WAVES
from mapped.io import MappedRequestIO, MappedResponseIO
from mapped.request import MappedRequestMonitor, MappedRequestResponder
from mapped.response import MappedResponseInitiator
from forastero.io import IORole, io_suffix_style
from forastero import BaseBench
from forastero.monitor import MonitorEvent
from cocotb.triggers import ClockCycles
from memory import RandomAccessMemory

from rvtests import RV32I_TESTS
from riscvmodel.program import Program
from riscvmodel.model import Model, State
from riscvmodel.variant import RV32I


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
    timeout=120,
    shutdown_delay=1,
    shutdown_loops=1,
)
@InsnsTB.parameter("insn", Program, [*RV32I_TESTS])
@InsnsTB.parameter("delay", int, [0, 1, 2, 3])
async def test_insn(tb: InsnsTB, log, insn, delay):
    prog = RV32I_TESTS[insn]
    test_mem = prog_to_mem(prog)
    tb.instr_memory.flash(test_mem)
    tb.instr_memory.set_delay(lambda _: delay)
    tb.data_memory.set_delay(lambda _: delay)
    log.info(
        f"Testing instruction {insn} with instr memory content:\n{str(tb.instr_memory)}."
    )
    for _ in prog.insns:
        await tb.instr_req_mon.wait_for(MonitorEvent.CAPTURE)
    await ClockCycles(tb.clk, num_cycles=50)  # make sure everything is coputed
    state = State(RV32I, bootaddr=0x80000000)
    m = Model(state=state)
    m.execute(prog)
    # The model does not work properly for some instructions, this is a workaround.
    if prog.expects() is not None:
        for regnum, regval in prog.expects().items():
            modval = format(regval, "032b")
            dutint = int(tb.dut.regfile_inst.regfile[regnum].value)
            dutval = format(dutint, "032b")
            assert (
                dutval == modval
            ), f"Expected value of {modval}=0x{regval:08x} in register {regnum}. Instead got {dutval}=0x{dutint:08x}."
    else:
        for regnum in range(0, 32):
            regval = m.state.intreg.regs[regnum].value
            modval = str(m.state.intreg.regs[regnum])  # hex string
            modval = format(int(modval, 16), "032b")  # binary string
            dutint = int(tb.dut.regfile_inst.regfile[regnum].value)
            dutval = format(dutint, "032b")
            assert (
                dutval == modval
            ), f"Expected value of {modval}=0x{regval:08x} in register {regnum}. Instead got {dutval}=0x{dutint:08x}."


if __name__ == "__main__":
    test_insns_runner()
