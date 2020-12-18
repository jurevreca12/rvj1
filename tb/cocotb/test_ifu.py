import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge, Edge, First
from cocotb.clock import Clock
from cocotb.result import ReturnValue, TestFailure
from cocotb.utils import get_sim_time

CLK_PERIOD = 1000 # ns or 1 MHz

instr_memory = [0xAA, # 0x0
		  	    0xBB, # 0x4
		  	    0xCC, # 0x8
				0xDD, # 0xC
				0xEE, # 0x10
				0xFF, # 0x14
				0x11] # 0x18

@cocotb.coroutine
def set_inputs_to_zero(dut):
	dut.ifu_inst.clk_i  			 <= 0
	dut.ifu_inst.rstn_i 			 <= 1
	dut.ifu_inst.data_i 			 <= 0
	dut.ifu_inst.get_next_instr_i <= 0
	dut.ifu_inst.jmp_instr_i 	 <= 0
	dut.ifu_inst.jmp_address_i 	 <= 0
	yield Timer(0)

@cocotb.coroutine
def reset_dut(dut, rstn, duration):
	rstn <= 0
	yield Timer(duration, units='ns')
	rstn <= 1
	dut.ifu_inst._log.info("Reset complete.")


# The memory SPROM has a READ latency of 1 clock cycle.
async def memory(dut):
	while True:
		await First(Edge(dut.ifu_inst.addr_o), Edge(dut.ifu_inst.rstn_i))
		dut.ifu_inst._log.info(f"Memory triggered at time {get_sim_time(units='ns')} ns, reset is {dut.ifu_inst.rstn_i}")
		await Timer(CLK_PERIOD, units='ns')
		if dut.ifu_inst.rstn_i == 1:
			dut.ifu_inst._log.info(f"Memory read at address {int(dut.ifu_inst.addr_o)}.")
			dut.ifu_inst.data_i <= instr_memory[int(int(dut.ifu_inst.addr_o) / 4)]
		else:
			dut.ifu_inst.data_i <= 0


@cocotb.test()
def ifu_read_basic(dut):
	dut.ifu_inst._log.info("Running a basic test of the instruction interface!")
	
	yield set_inputs_to_zero(dut)
	
	cocotb.fork(Clock(dut.ifu_inst.clk_i, CLK_PERIOD, units='ns').start())
	cocotb.fork(memory(dut))
	
	# First reset the block
	yield reset_dut(dut, dut.ifu_inst.rstn_i, 2*CLK_PERIOD) 

	yield FallingEdge(dut.ifu_inst.clk_i)
	yield RisingEdge(dut.ifu_inst.clk_i)	
	dut.ifu_inst.get_next_instr_i <= 1

	if dut.ifu_inst.cinstr_o == 0xAA:
		raise TestFailure("ERROR 0: Looks like cinstr register is infered as a latch, not a flipflop. \
	 	                   It shouldn't change before the positive clock edge.")

	yield RisingEdge(dut.ifu_inst.clk_i)

	yield RisingEdge(dut.ifu_inst.clk_i)

	if dut.ifu_inst.cinstr_o != 0xAA:
		raise TestFailure(f"ERROR 1: The current instruction register cinstr should contain the 0xAA instruction.\
							Instead it is the {dut.ifu_inst.cinstr_o} instruction")

	if dut.ifu_inst.pc_r != 0x04:
		raise TestFailure(f"ERROR 2: The current program counter should be 4, not {dut.ifu_inst.pc_r}.")


	if dut.ifu_inst.cinstr_o == 0xBB:
		raise TestFailure("ERROR 0: Looks like cinstr register is infered as a latch, not a flipflop. \
						   It shouldn't change before the positive clock edge.")

	yield RisingEdge(dut.ifu_inst.clk_i)

	if dut.ifu_inst.pc_r != 0x08:
		raise TestFailure(f"ERROR 2: The current program counter should be 8, not {dut.ifu_inst.pc_r}.")

	if dut.ifu_inst.cinstr_o != 0xBB:
		raise TestFailure("ERROR 1: The current instruction register cinstr should contian the 0xAA instruction.")
	
	yield Timer (5*CLK_PERIOD, units='ns')
	dut.ifu_inst._log.info("Test ifu_read_basic finnished.")

	
@cocotb.test()
def ifu_read_with_jmp_instr(dut):
	dut.ifu_inst._log.info("Running a basic test of the instruction interface!")
	
	yield set_inputs_to_zero(dut)
	
	cocotb.fork(Clock(dut.ifu_inst.clk_i, CLK_PERIOD, units='ns').start())
	cocotb.fork(memory(dut))
	
	# First reset the block
	yield reset_dut(dut, dut.ifu_inst.rstn_i, 2*CLK_PERIOD) 

	yield FallingEdge(dut.ifu_inst.clk_i)
	yield RisingEdge(dut.ifu_inst.clk_i)	
	dut.ifu_inst.get_next_instr_i <= 1

	if dut.ifu_inst.cinstr_o == 0xAA:
		raise TestFailure("ERROR 0: Looks like cinstr register is infered as a latch, not a flipflop. \
	 	                   It shouldn't change before the positive clock edge.")

	yield RisingEdge(dut.ifu_inst.clk_i)
	yield RisingEdge(dut.ifu_inst.clk_i)

	if dut.ifu_inst.cinstr_o != 0xAA:
		raise TestFailure(f"ERROR 1: The current instruction register cinstr should contain the 0xAA instruction.\
							Instead it is the {dut.ifu_inst.cinstr_o} instruction")

	if dut.ifu_inst.pc_r != 0x04:
		raise TestFailure(f"ERROR 2: The current program counter should be 4, not {dut.ifu_inst.pc_r}.")


	if dut.ifu_inst.cinstr_o == 0xBB:
		raise TestFailure("ERROR 0: Looks like cinstr register is infered as a latch, not a flipflop. \
						   It shouldn't change before the positive clock edge.")

	dut.ifu_inst.jmp_instr_i <= 1
	dut.ifu_inst.jmp_address_i <= 0x14
	yield RisingEdge(dut.ifu_inst.clk_i)
	yield RisingEdge(dut.ifu_inst.clk_i)
	yield RisingEdge(dut.ifu_inst.clk_i)

	if dut.ifu_inst.pc_r != 0x14:
		raise TestFailure(f"ERROR 2: The current program counter should be 8, not {dut.ifu_inst.pc_r}.")

	if dut.ifu_inst.cinstr_o != 0xFF:
		raise TestFailure("ERROR 1: The current instruction register cinstr should contian the 0xFF instruction.")
	
	yield Timer (5*CLK_PERIOD, units='ns')
	dut.ifu_inst._log.info("Test ifu_read_with_jmp_instr finnished.")	
