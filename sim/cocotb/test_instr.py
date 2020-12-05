import cocotb
from cocotb.triggers import Timer, RisingEdge, FallingEdge
from cocotb.clock import Clock
from cocotb.result import ReturnValue, TestFailure

CLK_PERIOD = 1000 # ns or 1 MHz

@cocotb.coroutine
def set_inputs_to_zero(dut):
	dut.clk_i  <= 0
	dut.rstn_i <= 0
	dut.data_i <= 0   
        yield Timer(0)

@cocotb.coroutine
def reset_dut(dut, rstn, duration):
	rstn <= 0
	yield Timer(duration)
	rstn <= 1
	dut._log.info("Reset complete.")

@cocotb.test()
def instr_if_read_basic(dut):
	dut._log.info("Running a basic test of the instruction interface!")
	
	yield set_inputs_to_zero(dut)
	
	cocotb.fork(Clock(dut.clk_i, CLK_PERIOD/2).start()) 
	
	# First reset the block
	yield reset_dut(dut, dut.rstn_i, 2*CLK_PERIOD) 

        dut.data_i <= 0xAA

        if dut.cinstr == 0xAA:
            raise TestFailure("ERROR 0: Looks like cinstr register is infered as a latch, not a flipflop. \
                               It shouldn't change before the positive clock edge.")

        yield RisingEdge(dut.clk_i)

        if dut.cinstr != 0xAA:
            raise TestFailure("ERROR 1: The current instruction register cinstr should contian the 0xAA instruction.")
	
        dut.data_i <= 0xBB;

        if dut.cinstr == 0xBB:
            raise TestFailure("ERROR 0: Looks like cinstr register is infered as a latch, not a flipflop. \
                               It shouldn't change before the positive clock edge.")

        yield RisingEdge(dut.clk_i)

        if dut.cinstr != 0xBB:
            raise TestFailure("ERROR 1: The current instruction register cinstr should contian the 0xAA instruction.")
	
        yield Timer (5*CLK_PERIOD)
	dut._log.info("Test instr_if_read_basic finnished.")	
