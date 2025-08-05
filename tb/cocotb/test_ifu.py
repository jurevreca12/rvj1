
from base import get_test_runner
import cocotb
from cocotb.triggers import Timer


def test_ifu_runner():
    runner = get_test_runner('jedro_1_ifu')
    runner.test(
        hdl_toplevel='jedro_1_ifu', 
        test_module='test_ifu'
    )

@cocotb.test()
async def my_first_test(dut):
    """Try accessing the design."""

    for cycle in range(10):
        dut.clk_i.value = 0
        await Timer(1, units="ns")
        dut.clk_i.value = 1
        await Timer(1, units="ns")

    #dut._log.info("my_signal_1 is %s", dut.my_signal_1.value)
    #assert dut.my_signal_2.value[0] == 0, "my_signal_2[0] is not 0!"


if __name__ == '__main__':
    test_ifu_runner()