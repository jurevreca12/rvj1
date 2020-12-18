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

# For randomised testing
NUM_RANDOM_CASES = 200
RANDOM_SEED = 30

# Define some usefull constants
CLK_PERIOD = 1000 # ns or 1 MHz

MINSINT32 = -2147483648 
MAXSINT32 = 2147483647
MAXUINT32 = (2**32)-1

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
	dut.alu_inst.clk_i 		 <= 0
	dut.alu_inst.rstn_i 	 <= 0
	dut.alu_inst.alu_op_sel_i <= 0
	dut.alu_inst.opa_i 		 <= 0
	dut.alu_inst.opb_i 	 	 <= 0
	dut.alu_inst.res_o 	     <= 0
	yield Timer(0)


@cocotb.coroutine
def reset_dut(dut, duration):
    dut.alu_inst.rstn_i <= 0
    yield Timer(duration)
    dut.alu_inst.rstn_i <= 1
    dut.alu_inst._log.info("Reset complete.")


@cocotb.test()
def test_alu_adder_basic(dut):
	yield set_inputs_to_zero(dut)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
	
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['ADD']

	dut.alu_inst.opa_i <= 2
	dut.alu_inst.opb_i <= 5

	yield Timer(2*CLK_PERIOD)

	res_o = Bits(bin=str(dut.alu_inst.res_o))
	if res_o.int != 7:
		raise TestFailure("Adder result is incorrect: %s != 7" % str(dut.alu_inst.res_o))

	yield Timer (5*CLK_PERIOD)

	
@cocotb.test()
def test_alu_adder_randomised_signed(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['ADD']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(MINSINT32, MAXSINT32)
		B = random.randint(MINSINT32, MAXSINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res_o = Bits(bin=str(dut.alu_inst.res_o))
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
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['ADD']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXUINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res_o = Bits(bin=str(dut.alu_inst.res_o))
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
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
	
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['SUB']

	dut.alu_inst.opa_i <= 2
	dut.alu_inst.opb_i <= 5

	yield Timer(2*CLK_PERIOD)

	res_o = Bits(bin=str(dut.alu_inst.res_o))
	if res_o.int != -3:
		raise TestFailure("Adder result is incorrect: %s != -3" % str(dut.alu_inst.res_o))

	yield Timer (5*CLK_PERIOD)


	
	
@cocotb.test()
def test_alu_sub_randomised_signed(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD)
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['SUB']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(MINSINT32, MAXSINT32)
		B = random.randint(MINSINT32, MAXSINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res_o = Bits(bin=str(dut.alu_inst.res_o))
		ref_res = simModels.sub(A, B);
		if res_o.int != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s - %s = %s. Reference result is %s." %
					(A, B, res_o.int, ref_res))

	
	yield Timer (5*CLK_PERIOD)


@cocotb.test()
def test_alu_sub_randomised_unsigned(dut):
	dut.alu_inst._log.info("Running test_alu_sub_randomised_unsigned!")
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['SUB']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXUINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res_o = Bits(bin=str(dut.alu_inst.res_o))
		ref_res = simModels.subu(A, B);
		if res_o.uint != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s - %s = %s. Reference result is %s." %
					(A, B, res_o.int, ref_res))
	
	yield Timer (5*CLK_PERIOD)



@cocotb.test()
def test_alu_sll(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['SLL']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXUINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res = Bits(bin=str(dut.alu_inst.shifter_left_res))
		ref_res = simModels.sll(A, B);
		if res.uint != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s << %s = %s. Reference result is %s." %
					(A, B, res.uint, ref_res))

	
	yield Timer (5*CLK_PERIOD)


@cocotb.test()
def test_alu_slt(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['SLT']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(MINSINT32, MAXSINT32)
		B = random.randint(MINSINT32, MAXSINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res = Bits(bin=str(dut.alu_inst.less_than_sign_res))
		ref_res = simModels.slt(A, B);
		if res.int != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s < %s = %s. Reference result is %s." %
					(A, B, res.int, ref_res))

	
	yield Timer (5*CLK_PERIOD)



@cocotb.test()
def test_alu_sltu(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['SLTU']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXUINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res = Bits(bin=str(dut.alu_inst.less_than_unsign_res))
		ref_res = simModels.sltu(A, B);
		if res.uint != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s < %s = %s. Reference result is %s." %
					(A, B, res.uint, ref_res))

	
	yield Timer (5*CLK_PERIOD)



@cocotb.test()
def test_alu_xor_randomised(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['XOR']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXUINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res = Bits(bin=str(dut.alu_inst.xor_res))
		ref_res = simModels.xor(A, B);
		if res.uint != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s ^ %s = %s. Reference result is %s." %
					(A, B, res.uint, ref_res))

	
	yield Timer (5*CLK_PERIOD)




@cocotb.test()
def test_alu_srl(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['SRL']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXUINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res = Bits(bin=str(dut.alu_inst.shifter_right_res))
		ref_res = simModels.srl(A, B);
		if res.uint != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s >> %s = %s. Reference result is %s." %
					(A, B, res.uint, ref_res))

	
	yield Timer (5*CLK_PERIOD)



@cocotb.test()
def test_alu_sra(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['SRA']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(MINSINT32, MAXSINT32)
		B = random.randint(MINSINT32, MAXSINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res = Bits(bin=str(dut.alu_inst.shifter_right_res))
		ref_res = simModels.sra(A, B);
		if res.int != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s >> %s = %s. Reference result is %s." %
					(A, B, res.int, ref_res))

	
	yield Timer (5*CLK_PERIOD)





@cocotb.test()
def test_alu_or_randomised(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['OR']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXUINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res = Bits(bin=str(dut.alu_inst.or_res))
		ref_res = simModels.orz(A, B); # We don't use the or keyword because it is a python keyword (so orz instead).
		if res.uint != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s ^ %s = %s. Reference result is %s." %
					(A, B, res.uint, ref_res))

	
	yield Timer (5*CLK_PERIOD)


@cocotb.test()
def test_alu_and_randomised(dut):
	yield set_inputs_to_zero(dut) 
	
	# Set the seed to a constant for reproducability of results
	random.seed(RANDOM_SEED)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.alu_inst.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, 2*CLK_PERIOD) 
   
	dut.alu_inst.alu_op_sel_i <= ALU_OP_DICT['AND']
	
	for i in range(NUM_RANDOM_CASES):
		A = random.randint(0, MAXUINT32)
		B = random.randint(0, MAXUINT32)

		dut.alu_inst.opa_i <= A;
		dut.alu_inst.opb_i <= B;

		yield Timer(2)

		res = Bits(bin=str(dut.alu_inst.and_res))
		ref_res = simModels.andz(A, B); # We don't use the and keyword because it is a python keyword (so andz instead).
		if res.uint != ref_res:
			raise TestFailure(
				"Randomised test failed with: %s ^ %s = %s. Reference result is %s." %
					(A, B, res.uint, ref_res))

	
	yield Timer (5*CLK_PERIOD)




