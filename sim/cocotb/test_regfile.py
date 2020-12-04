import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
from cocotb.result import ReturnValue, TestFailure

CLK_PERIOD = 1000 # ns or 1 MHz

@cocotb.coroutine
def set_inputs_to_zero(dut):
	dut.clk_i 	   <= 0
	dut.rstn_i 	   <= 0
	dut.rpa_addr_i <= 0
	dut.rpa_data_o <= 0
	dut.rpb_addr_i <= 0
	dut.rpb_data_o <= 0
 	dut.wpc_addr_i <= 0
	dut.wpc_data_i <= 0
	dut.wpc_we_i   <= 0
	yield Timer(0)

@cocotb.coroutine
def reset_dut(dut, rstn, duration):
	rstn <= 0
	yield Timer(duration)
	rstn <= 1
	dut._log.info("Reset complete.")

@cocotb.coroutine
def read_rega(dut, addr):
	dut.rpa_addr_i <= addr
	yield RisingEdge(dut.clk_i)
	raise ReturnValue(dut.rpa_data_o.value)	

	
@cocotb.coroutine
def read_regb(dut, addr):
	dut.rpb_addr_i <= addr
	yield RisingEdge(dut.clk_i)
	raise ReturnValue(dut.rpb_data_o.value)

@cocotb.coroutine
def write_regc(dut, addr, val):
	yield FallingEdge(dut.clk_i)
	dut.wpc_addr_i <= addr
	dut.wpc_we_i   <= 1
	dut.wpc_data_i <= val
	yield RisingEdge(dut.clk_i)
	dut.wpc_we_i   <= 0

@cocotb.test()
def basic_read(dut):
	dut._log.info("Running basic_read test!")
	
	yield set_inputs_to_zero(dut)
	
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, dut.rstn_i, 2*CLK_PERIOD) 

	# Check all registers are set to zero at first
	for i in range (0, 32):
		reg_val = yield read_rega(dut, i)
		if reg_val != 0:
			raise TestFailure("ERROR 0: Register x"+ str(i) + " read on port B is non-zero after reset! Its value is " + str(reg_val.value) + ".")
	
	for i in range (0, 32):
		reg_val = yield read_regb(dut, i)
		if reg_val != 0:
			raise TestFailure("ERROR 0: Register x"+ str(i) + " read on port C is non-zero after reset! Its value is " + str(reg_val.value) + ".")

	
	yield Timer (5*CLK_PERIOD)
	dut._log.info("Test basic_read finnished.")	


@cocotb.test()
def basic_write(dut):
	dut._log.info("Running basic_write test!")

	yield set_inputs_to_zero(dut)	
    	
	# Start the clock
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD).start())

	# reset the block first
	yield reset_dut(dut, dut.rstn_i, 2*CLK_PERIOD)

	# First check the x0 register (always returns zero)
	yield write_regc(dut, 0, 12)
	reg_val = yield read_rega(dut, 0)
	if reg_val != 0:	
		raise TestFailure("ERROR 1: Register x0 has wrong value " + str(reg_val) + ". It should be 0.") 
	
	# Basic write check
	for i in range (1,31):
		yield write_regc(dut, i, i) 	
		reg_val = yield read_rega(dut, i)
		if reg_val != i:
			raise TestFailure("ERROR 1: Register x" + str(i) + " has wrong value " + str(reg_val) + ". It should be " + str(i)) 

	yield Timer (5*CLK_PERIOD)
	dut._log.info("Test basic_write finnished.")	
	
	

