.PHONY: all gui elaborate sim sim_gui

all: compile elaborate sim

compile:
	xvlog -sv ../../rtl/inc/jedro_1_defines.sv \
				 ../../rtl/jedro_1_ifu.sv \
				 ../support/rams_sp_rom.v \
				 ../support/rams_sp_rom_wrap.sv \
				 ../support/jedro_1_ifu_tb_top.sv \
				 jedro_1_ifu_tb.sv \
				 jedro_1_ifu_jmp_tb.sv \
				 -i ../../rtl/inc/


elaborate: elaborate_ifu_tb elaborate_ifu_jmp_tb

elaborate_ifu_tb:
	xelab -debug typical -i ../../rtl/inc/ jedro_1_ifu_tb -s ifu_tb_sim --O0

elaborate_ifu_jmp_tb:
	xelab -debug typical -i ../../rtl/inc/ jedro_1_ifu_jmp_tb -s ifu_jmp_tb_sim --O0


sim: sim_ifu_tb sim_ifu_jmp_tb

sim_ifu_tb:
	xsim ifu_tb_sim -t simulate.tcl

sim_ifu_jmp_tb:
	xsim ifu_jmp_tb_sim -t simulate.tcl


clean:
	rm -rf xelab.* xsim.dir/ xsim* xvlog.* webtalk* *.wdb dump.vcd Xil./
