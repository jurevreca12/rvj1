#!/usr/bin/python
from riscv.sim import sim_t
from riscv.cfg import cfg_t, mem_cfg_t
from riscv.debug_module import debug_module_config_t
from riscv.devices import rom_device_t

if __name__ == '__main__':
    cfg = cfg_t( #spike configuration
        isa="rv32i_zicsr_zifencei",
        priv="m",
        mem_layout=[mem_cfg_t(0x8000_0000, 0x1000_0000)],
        start_pc=0x8000_0000
    )
    spike = sim_t( #initialize instance of sim_t class
        cfg=cfg,
        halted=False,
        plugin_device_factories=[],
        args=["/foss/designs/rvj1/tb/cosim/dut.elf"],
        dm_config=debug_module_config_t()
    )
    hart0 = spike.get_core(0)
    #hart0.reset()
    #spike.proc_reset(0)
    spike.run()

    print("reseting")
    hart0.reset()
    # print("DEVICE TREE")
    # print(spike.get_dts())
    print("------------------------------------")
    print("PC after construction:", hex(hart0.state.pc))
    print("mepc   =", hex(hart0.get_csr(0x341)))
    print("mcause =", hex(hart0.get_csr(0x342)))
    print("mtval  =", hex(hart0.get_csr(0x343)))
    #hart0.state.pc = MEM_BASE 
    #print(hex(hart0.state.pc))
    hart0.step(5)
    print("")
    print("PC after step:", hex(hart0.state.pc))
    print("mepc   =", hex(hart0.get_csr(0x341)))
    print("mcause =", hex(hart0.get_csr(0x342)))
    print("mtval  =", hex(hart0.get_csr(0x343)))
    import pdb; pdb.set_trace()
