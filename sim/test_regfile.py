import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
from cocotb.result import ReturnValue, TestFailure

CLK_PERIOD = 1000 # ns or 1 MHz

@cocotb.coroutine
def reset_dut(rstn, duration):
	rstn <= 0
	yield Timer(duration)
	rstn <= 1
	cocotb.log.info("Reset complete.")

@cocotb.coroutine
def read_reg(dut, addr):
	dut.addr_i <= addr
	yield RisingEdge(dut.clk_i)
	raise ReturnValue(dut.data_o.value)	
	
@cocotb.coroutine
def write_reg(dut, addr, val):
	dut.addr_i <= addr
	dut.we_i   <= 1
	dut.data_i <= val
	yield RisingEdge(dut.clk_i)

@cocotb.test()
def basic_write_read(dut):
	dut._log.info("Running basic_write_read test!")
	
	# Set inputs to zero
	dut.clk_i  <= 0
	dut.rstn_i <= 0
	dut.addr_i <= 0
	dut.data_i <= 0
	dut.we_i   <= 0

	# Start the clock pin wiggling
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD).start()) 
	
	# First reset the block
	yield reset_dut(dut.rstn_i, 2000) 

	# Check all registers are set to zero at first
	for i in range (0, 31):
		reg_val = yield read_reg(dut, i)
		if reg_val != 0:
			raise TestFailure("ERROR: Register x"+ str(i) + " is non-zero after reset! Its value is " + str(reg_val.value) + ".")
	
	yield Timer (5000)	

	# Basic write check
	for i in range (1,31):
		dut._log.debug("BeFoRe" + str(i))
		yield FallingEdge(dut.clk_i)
		dut.addr_i <= 2
		dut.data_i <= 2
		dut.we_i   <= 1
		yield RisingEdge(dut.clk_i)
		yield Timer(2000)
		dut.we_i  <=  0
		yield RisingEdge(dut.clk_i)
		yield FallingEdge(dut.clk_i)
		reg_val = yield read_reg(dut, 2)
		yield Timer(4000)
		if reg_val != 2:
			raise TestFailure("ERROR: Register x" + str(i) + " has wrong value " + str(reg_val) + ". It should be " + str(i)) 

	dut._log.debug("Test basic_write_read finnished.")	
	
	

