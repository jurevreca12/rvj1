import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge, Edge
from cocotb.clock 	 import Clock
from cocotb.result 	 import ReturnValue, TestFailure
from cocotb.binary 	 import BinaryRepresentation, BinaryValue

# We use bitstring to get around cocotbs akward BinaryValue
import bitstring  
from bitstring import Bits

# For random stimuli generation
import random

# Custom made models made with c functions
import simModels

# Define some usefull constants
CLK_PERIOD = 1000 # ns or 1 MHz

MINSINT32 = -2147483648 
MAXSINT32 = 2147483647
MAXUINT32 = (2**32)-1;

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
def test_alu_adder_basic(dut):
	yield set_inputs_to_zero(dut)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
	
	dut.alu_op_sel_i <= ALU_OP_DICT['ADD']

	dut.opa_i <= 2
	dut.opb_i <= 5

	yield Timer(2*CLK_PERIOD)

	res_o = Bits(bin=str(dut.res_o))
	if res_o.int != 7:
		raise TestFailure("Adder result is incorrect: %s != 7" % str(dut.res_o))

	yield Timer (5*CLK_PERIOD)


	
	
@cocotb.test()
def test_alu_adder_randomised_signed(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(30)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_op_sel_i <= ALU_OP_DICT['ADD']
	
	for i in range(200):
		A = random.randint(MINSINT32, MAXSINT32)
		B = random.randint(MINSINT32, MAXSINT32)

		dut.opa_i <= A;
		dut.opb_i <= B;

		yield Timer(2)

		res_o = Bits(bin=str(dut.res_o))
		ref_res = simModels.add(A, B);
		if res_o.int != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s + %s = %s. Reference result is %s." %
					(A, B, res_o.int, ref_res))

	
	yield Timer (5*CLK_PERIOD)


@cocotb.test()
def test_alu_adder_randomised_unsigned(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(30)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_op_sel_i <= ALU_OP_DICT['ADD']
	
	for i in range(200):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXSINT32)

		dut.opa_i <= A;
		dut.opb_i <= B;

		yield Timer(2)

		res_o = Bits(bin=str(dut.res_o))
		ref_res = simModels.addu(A, B);
		if res_o.uint != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s + %s = %s. Reference result is %s." %
					(A, B, res_o.int, ref_res))

	
	yield Timer (5*CLK_PERIOD)


@cocotb.test()
def test_alu_sub_basic(dut):
	yield set_inputs_to_zero(dut)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
	
	dut.alu_op_sel_i <= ALU_OP_DICT['SUB']

	dut.opa_i <= 2
	dut.opb_i <= 5

	yield Timer(2*CLK_PERIOD)

	res_o = Bits(bin=str(dut.res_o))
	if res_o.int != -3:
		raise TestFailure("Adder result is incorrect: %s != -3" % str(dut.res_o))

	yield Timer (5*CLK_PERIOD)


	
	
@cocotb.test()
def test_alu_sub_randomised_signed(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(30)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_op_sel_i <= ALU_OP_DICT['SUB']
	
	for i in range(200):
		A = random.randint(MINSINT32, MAXSINT32)
		B = random.randint(MINSINT32, MAXSINT32)

		dut.opa_i <= A;
		dut.opb_i <= B;

		yield Timer(2)

		res_o = Bits(bin=str(dut.res_o))
		ref_res = simModels.sub(A, B);
		if res_o.int != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s + %s = %s. Reference result is %s." %
					(A, B, res_o.int, ref_res))

	
	yield Timer (5*CLK_PERIOD)


@cocotb.test()
def test_alu_sub_randomised_unsigned(dut):
   	dut._log.info("Running test_alu_sub_randomised_unsigned!")
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(30)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_op_sel_i <= ALU_OP_DICT['SUB']
	
	for i in range(200):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXSINT32)

		dut.opa_i <= A;
		dut.opb_i <= B;

		yield Timer(2)

		res_o = Bits(bin=str(dut.res_o))
		ref_res = simModels.subu(A, B);
		if res_o.uint != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s + %s = %s. Reference result is %s." %
					(A, B, res_o.int, ref_res))
	
	yield Timer (5*CLK_PERIOD)



@cocotb.test()
def test_alu_sll(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(30)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_op_sel_i <= ALU_OP_DICT['SLL']
	
	for i in range(200):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXSINT32)

		dut.opa_i <= A;
		dut.opb_i <= B;

		yield Timer(2)

		res_o = Bits(bin=str(dut.res_o))
		ref_res = simModels.sll(A, B);
		if res_o.uint != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s + %s = %s. Reference result is %s." %
					(A, B, res_o.int, ref_res))

	
	yield Timer (5*CLK_PERIOD)


