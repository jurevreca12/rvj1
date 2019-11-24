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
	dut.instr_next_avail_i <= 0
	dut.reg_a_data_i <= 0
	dut.reg_b_data_i <= 0
	yield Timer(0)

@cocotb.coroutine
def reset_dut(dut, duration):
    dut.rstn_i <= 0
    yield Timer(duration)
    dut.rstn_i <= 1
    dut._log.info("Reset complete.")

# Simulate register file interface (read only)
@cocotb.coroutine
def reg_file_interface(dut):
	REG_FILE = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31]
	var = 1;
	#  Reading is performed using a combinatorial decoder circuit (no delay)!
	while var == 1:
		yield [Edge(dut.reg_a_addr_o) , Edge(dut.reg_b_addr_o)]
		if (dut.rstn_i == 1):
			dut.reg_a_data_i <= REG_FILE[dut.reg_a_addr_o.value.integer]
			dut.reg_b_data_i <= REG_FILE[dut.reg_b_addr_o.value.integer]


@cocotb.test()
def test_instr_op_add(dut):
	dut._log.info("Running test for instruction add!")
	yield set_inputs_to_zero(dut)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 

	cocotb.fork(reg_file_interface(dut))	
	
	# Feed instruction add r3,r1,r2
	dut.instr_rdata_i <= 0b000000000001000001000000110110011
	dut.instr_next_avail_i <= 1

	
	
	yield Timer (20*CLK_PERIOD)
	dut._log.info("Test basic_read finnished.")	


	
	

