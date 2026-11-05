include ../common.mk

# See https://docs.cocotb.org/en/v2.0.0/building.html

SIM           ?= verilator
TOPLEVEL_LANG ?= verilog
COMPILE_ARGS  ?= -f $(BUILD_CONFIG_SIM_FLIST) 
SIM_ARGS      ?=
TOPLEVEL      ?=
MODULE        ?=

SIM_BUILD     := $(abspath $(BUILD_TEST_COCOTB_DIR)/sim_build)

include $(shell cocotb-config --makefiles)/Makefile.sim
