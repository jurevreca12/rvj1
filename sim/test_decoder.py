import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
from cocotb.result import ReturnValue, TestFailure

CLK_PERIOD = 1000 # ns or 1 MHz

@cocotb.coroutine
def reset_dut(dut, rstn, duration):
	rstn <= 0
	yield Timer(duration)
	rstn <= 1
	dut._log.info("Reset complete.")

@cocotb.coroutine
def read_reg(dut, addr):
	dut.addr_i <= addr
	yield RisingEdge(dut.clk_i)
	raise ReturnValue(dut.data_o.value)	
	
@cocotb.coroutine
def write_reg(dut, addr, val):
	yield FallingEdge(dut.clk_i)
	dut.addr_i <= addr
	dut.we_i   <= 1
	dut.data_i <= val
	yield RisingEdge(dut.clk_i)
	yield RisingEdge(dut.clk_i) # It takes 2 clock cycles to write a value
	dut.we_i   <= 0

@cocotb.test()
def test_instr_add(dut):
	dut._log.info("Running test for instruction add!")
	
	# Set inputs to zero
	dut.clk_i  <= 0
	dut.rstn_i <= 0
	dut.instr_rdata_i <= 0
	dut.instr_next_avail_i <= 0
	dut.reg_data_i <= 0

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, dut.rstn_i, 2*CLK_PERIOD) 
	
	dut.instr_rdata_i <= 32311
	dut.instr_next_avail_i <= 1
	
	yield Timer (50*CLK_PERIOD)
	dut._log.info("Test basic_read finnished.")	


	
	

