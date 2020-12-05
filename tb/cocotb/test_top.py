import cocotb
from cocotb.triggers import Timer

@cocotb.test()
def my_first_test(dut):
    """Try accessing the design."""

    dut._log.info("Running test!")
    for cycle in range(10):
        dut.clock = 0
        yield Timer(1000)
        dut.clock = 1
        yield Timer(1000)
    dut._log.info("Running test!")
