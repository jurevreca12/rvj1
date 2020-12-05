import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge, Edge
from cocotb.clock import Clock
from cocotb.result import ReturnValue, TestFailure

CLK_PERIOD = 1000 # ns or 1 MHz

@cocotb.coroutine
def set_inputs_to_zero(dut):
	dut.clk_i <= 0
	dut.rstn_i <= 0
	dut.instr_rdata_i <= 0
	yield Timer(0)

@cocotb.coroutine
def reset_dut(dut, duration):
    dut.rstn_i <= 0
    yield Timer(duration)
    dut.rstn_i <= 1
    dut._log.info("Reset complete.")


@cocotb.test()
def test_instr_op_add(dut):
	dut._log.info("Running test for instruction add!")
	yield set_inputs_to_zero(dut)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 

	# Feed instruction add r3,r1,r2
	dut.instr_rdata_i <= 0b000000000001000001000000110110011
	
	
	yield Timer (20*CLK_PERIOD)
	dut._log.info("Test basic_read finnished.")	


	
	

