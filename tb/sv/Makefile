.PHONY: all

all:
	xvlog -sv ../../rtl/inc/jedro_1_defines.sv \
				 ../../rtl/jedro_1_ifu.sv \
				 rams_sp_rom.v \
				 rams_sp_rom_wrap.sv \
				 jedro_1_ifu_tb_top.sv \
				 jedro_1_ifu_tb.sv \
				 -i ../../rtl/inc/
	xelab -debug typical -i ../../rtl/inc/ jedro_1_ifu_tb -s sim_snapshot --O0
	xsim sim_snapshot -t simulate.tcl

clean:
	rm -rf xelab.* xsim.dir/ xsim* xvlog.* webtalk* *.wdb dump.vcd
