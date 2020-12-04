import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge, Edge
from cocotb.clock import Clock
from cocotb.result import ReturnValue, TestFailure

# We use bitstring to get around cocotbs akward BinaryValue
import bitstring  
from bitstring import Bits

CLK_PERIOD = 1000 # ns or 1 MHz

@cocotb.coroutine
def set_inputs_to_zero(dut):
	dut.in_i <= 0
	yield Timer(0)

@cocotb.test()
def test_sign_extender(dut):
	yield set_inputs_to_zero(dut)

	# Feed a positive number 
	dut.in_i <= 0b000011110000
	yield Timer(2*CLK_PERIOD)

	res_o = Bits(bin=str(dut.out_o))
	if (res_o.bin != "00000000000000000000000011110000"):
		raise TestFailure("Something went wrong. Results didn't match when sign extending a positive integer. Our result was ", res_o.bin, "  and the reference result is 0b00000000000000000000000011110000")
		
	dut.in_i <= 0b100000000000 
	yield Timer(2*CLK_PERIOD)

	res_o = Bits(bin=str(dut.out_o))
	if (res_o.bin != "11111111111111111111100000000000"):
		raise TestFailure("Something went wrong. Results didn't match when sign extending a negative integer. Our result was ", res_o.bin, "  and the reference result is 0b11111111111111111111100000000000")

	yield Timer (5*CLK_PERIOD)


	
	

