import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
from cocotb.result import ReturnValue, TestFailure

CLK_PERIOD = 1000 # ns or 1 MHz

@cocotb.coroutine
def set_inputs_to_zero(dut):
	clk_i <= 0
	rstn_i <= 0
	instr_rdata_i <= 0
	instr_next_avail_i <= 0
	instr_next_en_o <= 0
	illegal_instr_o <= 0
	alu_op_sel_o <= 0
	alu_en <= 0
	alu_op_a_o <= 0   
	alu_op_b_o <= 0
	reg_a_data_i <= 0
	reg_a_addr_o <= 0
	reg_b_data_i <= 0
	reg_b_addr_o <= 0
	yield Timer(0)

@cocotb.coroutine
def reset_dut(dut, rstn, duration):
    rstn <= 0
    yield Timer(duration)
    rstn <= 1
    dut._log.info("Reset complete.")


@cocotb.test()
def test_instr_add(dut):
	dut._log.info("Running test for instruction add!")

	set_inputs_to_zero(dut)

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, dut.rstn_i, 2*CLK_PERIOD) 
	
	dut.instr_rdata_i <= 32311
	dut.instr_next_avail_i <= 1
	
	yield Timer (50*CLK_PERIOD)
	dut._log.info("Test basic_read finnished.")	


	
	

