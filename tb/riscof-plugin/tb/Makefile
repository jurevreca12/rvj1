.PHONY: all compile elaborate sim clean

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

# We use find to search for all verilog and system verilog files.
INC_DIR := ${MKFILE_DIR}../../../rtl/inc
JEDRO_1_DEFINES := ${INC_DIR}/jedro_1_defines.v
RTL_DIR := ${MKFILE_DIR}../../../rtl
TB_SUPPORT_DIR := ${MKFILE_DIR}../../support/.


V_FILES := $(shell find ${RTL_DIR} ${TB_SUPPORT_DIR} -name "*.v")
SV_FILES := $(shell find ${RTL_DIR} ${TB_SUPPORT_DIR} -name "*.sv")
RTL_FILES := ${V_FILES} ${SV_FILES}


all: compile sim

compile: ./obj_dir/Vjedro_1_riscof_tb

sim: compile
	${MKFILE_DIR}/obj_dir/Vjedro_1_riscof_tb

./obj_dir/Vjedro_1_riscof_tb : ${RTL_FILES} jedro_1_riscof_tb.v
	verilator --binary ${RTL_FILES} -I${INC_DIR} -Wno-fatal jedro_1_riscof_tb.v --top jedro_1_riscof_tb


clean:
	rm -rf obj_dir/
	rm -f out.hex dut.signature
