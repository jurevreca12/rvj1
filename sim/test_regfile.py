import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock


CLK_PERIOD = 1000 # ns or 1 MHz

@cocotb.coroutine
def reset_dut(rstn, duration):
	rstn <= 0
	yield Timer(duration)
	rstn <= 1
	rstn._log.debug("Reset complete")

@cocotb.coroutine
def read_reg(addr):
	dut.addr_i <= addr
	yield RisingEdge(dut.clk_i)
	raise ReturnValue(dut.data_o)	
	

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
	yield reset_dut(dut.rstn_i, 500) 


	# Check all registers are set to zero at first
	for i in range (0, 31):
		reg_val = yield read_reg(i)
		assert reg_val == 0

	dut._log.debug("Test basic_write_read finnished.")	
	
	

