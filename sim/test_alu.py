import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge, Edge
from cocotb.clock import Clock
from cocotb.result import ReturnValue, TestFailure

CLK_PERIOD = 1000 # ns or 1 MHz

ALU_OP_DICT = {'ADD':  0b0000,
			   'SUB':  0b1000,
			   'SLL':  0b0001,
			   'SLT':  0b0010,
			   'SLTU': 0b0011,
			   'XOR':  0b0100,
			   'SRL':  0b0101,
			   'SRA':  0b1101,
			   'OR':   0b0110,
			   'AND':  0b0111}



@cocotb.coroutine
def set_inputs_to_zero(dut):
	dut.clk_i 		 <= 0
	dut.rstn_i 		 <= 0
	dut.alu_op_sel_i <= 0
	dut.opa_i 		 <= 0
	dut.opb_i 	 	 <= 0
	dut.res_o 	     <= 0
	yield Timer(0)

@cocotb.coroutine
def reset_dut(dut, duration):
    dut.rstn_i <= 0
    yield Timer(duration)
    dut.rstn_i <= 1
    dut._log.info("Reset complete.")


@cocotb.test()
def test_addder_basic(dut):
	dut._log.info("Running test for instruction add!")
	yield set_inputs_to_zero(dut)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
	
	dut.alu_op_sel_i <= ALU_OP_DICT['ADD']

	dut.opa_i <= 2
	dut.opb_i <= 5

	yield Timer(2*CLK_PERIOD)

	if (int(dut.res_o) != 7):
		raise TestFailure("Adder result is incorrect: %s != 7" % str(dut.res_o))

	yield Timer (20*CLK_PERIOD)
	dut._log.info("Test test_adder_basic finnished.")	


	
	

