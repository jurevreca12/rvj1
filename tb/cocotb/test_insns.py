import os
import tempfile
import datetime
from riscvmodel.program import Program
from riscvmodel.model import Model, State
from riscvmodel.variant import RV32I
from rvtests import RV32I_TESTS
from sdexttests import SDEXT_TESTS
import pytest
from cocotb.triggers import ClockCycles, RisingEdge
from cocotb.clock import Clock

TIMEOUT_CLOCKS = 1000

async def run_rvj1(dut):
    # Get expected result
    expects = {0: 0}
    for regnum in range(1, 31):
        exp_val = os.environ.get(f"TEST_EXP_REG{regnum}")
        if exp_val is not None:
            expects[regnum] = int(exp_val)
    assert len(expects.items()) > 1
    debug_req_clock = int(os.environ.get(f"TEST_DEBUG_REQ", -1))

    # Start clock
    clock = Clock(dut.clk, 10, unit="us")
    clock.start(start_high=False) 

    # reset circuit
    dut.rstn.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rstn.value = 1

    # wait for the test to finish
    for clk_cnt in range(TIMEOUT_CLOCKS):
        await RisingEdge(dut.clk)
        if clk_cnt == debug_req_clock:
            dut.ext_dbg_req_i.value = 1
        if clk_cnt == (debug_req_clock + 1):
            dut.ext_dbg_req_i.value = 0
        if dut.dut.regfile_inst.regfile[31].value == 1:
            break

    # Check the expected results
    assert len(expects) > 0, "At least one register should be set."
    assert sum(expects.values()) != 0, "A test resulting in all zero registers is invalid."
    for regnum, regval in expects.items():
        assert dut.dut.regfile_inst.regfile[regnum].value == regval, (
            f"Register {regnum} should contain the value {regval}, not {dut.dut.regfile_inst.regfile[regnum].value}."
        )

@pytest.mark.parametrize("asm_test_name", list(RV32I_TESTS.keys()) + list(SDEXT_TESTS.keys()))
def test_simple_runner(top_test_fixture, asm_test_name):
    if asm_test_name[0:5] == "sdext":
        asm_test = SDEXT_TESTS[asm_test_name]
    else:
        asm_test = RV32I_TESTS[asm_test_name]
    print(f"Running test {asm_test_name} with the following instructions:")
    for insn in asm_test.insns:
        print(insn)
    hex_str = gen_hex(asm_test)
    now = datetime.datetime.now()
    now = now.strftime("%Y_%b_%d_%A_%I_%M_%S")
    with tempfile.NamedTemporaryFile(prefix=f"{asm_test_name}_{now}_", delete=False) as hex_file_fp:
        print(f"Generating HEX file for the test to location: {hex_file_fp.name}.")
        hex_file_fp.write(hex_str)
    expects = get_expected_results(asm_test)
    extraenv = {}
    for regnum, regval in expects.items():
        extraenv[f"TEST_EXP_REG{regnum}"] = str(regval)
    if hasattr(asm_test, 'extra_env'):
        for key, val in asm_test.extra_env().items():
            extraenv[key] = str(val)
    top_test_fixture.test(
        toplevel=top_test_fixture.toplevel, 
        test_module="test_insns",
        plusargs=[f"+MEM_INIT_FILE0={hex_file_fp.name}"],
        env=extraenv
    )

def gen_hex(program: Program) -> str:
    hex_str = ""
    for insn in program.insns:
        hex_str += format(insn.encode(), '08X') + "\n"
    return bytes(hex_str, 'utf-8')

def get_expected_results(program: Program) -> dict:
    expects = program.expects()
    if expects is None:
        expects = {}
        state = State(RV32I, bootaddr=0x80000000)
        m = Model(state=state)
        m.execute(program)
        for regnum in range(1, 32):
            regval = m.state.intreg.regs[regnum].value
            expects[regnum] = regval
    return expects

