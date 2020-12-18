import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge, Edge, First
from cocotb.clock import Clock
from cocotb.result import ReturnValue, TestFailure
from cocotb.utils import get_sim_time
from cocotb.binary import BinaryValue

CLK_PERIOD = 1000 # ns or 1 MHz
PIPELINE_DEPTH = 4

instr_memory_content = [0b00000001_00110000_00000000_10010011, # ADDI x1, x0, 13
		  	    		0b00000000_00000000_00000000_00000000, # 0x4
		  	    		0b00000000_00000000_00000000_00000000, # 0x8
						0b00000000_00000000_00000000_00000000, # 0xC
						0b00000000_00000000_00000000_00000000, # 0x10
						0b00000000_00000000_00000000_00000000, # 0x14
						0b00000000_00000000_00000000_00000000] # 0x18

@cocotb.coroutine
def set_inputs_to_zero(dut):
	dut.clk_i			<= 0
	dut.rstn_i			<= 0
	dut.ifu_data_i		<= 0			
	dut.data_gnt_i		<= 0
	dut.data_rvalid_i	<= 0
	dut.data_rdata_i	<= 0
	dut.data_err_i		<= 0
	yield Timer(0)

@cocotb.coroutine
def reset_dut(dut, rstn, duration):
	rstn <= 0
	yield Timer(duration, units='ns')
	rstn <= 1
	dut._log.info("Reset complete.")


# The memory SPROM has a READ latency of 1 clock cycle.
async def instr_memory(dut):
	while True:
		await First(Edge(dut.ifu_addr_o), Edge(dut.rstn_i))
		dut._log.info(f"Memory triggered at time {get_sim_time(units='ns')} ns, reset is {str(dut.rstn_i)}")
		await Timer(CLK_PERIOD, units='ns')
		if dut.rstn_i == 1:
			dut._log.info(f"Memory read at address {int(dut.ifu_addr_o)}.")
			dut.ifu_data_i <= instr_memory_content[int(int(dut.ifu_addr_o) / 4)]
		else:
			dut.ifu_data_i <= 0


@cocotb.test()
def top_addi_instr_basic(dut):
	dut._log.info("Testing the addi instruction!")
	
	yield set_inputs_to_zero(dut)
	
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD, units='ns').start())
	cocotb.fork(instr_memory(dut))
	
	# First reset the block
	yield reset_dut(dut, dut.rstn_i, 2*CLK_PERIOD) 
	yield RisingEdge(dut.clk_i)
	yield RisingEdge(dut.clk_i)

	if dut.regfile_inst.regfile.value[1] != 0:
		raise TestFailure(f"ERROR 0: Register x1 should've been reset to 0. Instead its value is {dut.regfile_inst.regfile.value[1].integer}")
	
	for i in range(PIPELINE_DEPTH):
		yield RisingEdge(dut.clk_i)
	
	if dut.regfile_inst.regfile.value[1] != 13:
		raise TestFailure(f"ERROR 1: Register x1 should've been set to 13 by the addi instruction. Instead its value is {dut.regfile_inst.regfile.value[1].integer}")
		
	yield Timer (5*CLK_PERIOD, units='ns')
	dut._log.info("Test top_addi_instr_basic finnished.")

	
