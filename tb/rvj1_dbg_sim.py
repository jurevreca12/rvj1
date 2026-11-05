import targets
from verilator_sim import VerilatorSim

class RVJ1Hart(targets.Hart):
    xlen = 32
    ram = 0x8000_0000
    ram_size = 200000000 * 4
    instruction_hardware_breakpoint_count = 0
    link_script_path = "rvj1.lds"


class RVJ1Sim(targets.Target):
    timeout_sec = 6000
    openocd_config_path = "rvj1_ocd.cfg"
    harts = [RVJ1Hart()]

    def create(self):
        print(f"RVJ1Sim self.sim_cmd: {self.sim_cmd}")
        return VerilatorSim(sim_cmd=self.sim_cmd)
