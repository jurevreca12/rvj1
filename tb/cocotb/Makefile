# Verilog source files
CDIR = $(shell pwd)
SOURCE_DIR = $(CDIR)/../../rtl

ifeq ($(OS),Msys)
WPWD=$(shell sh -c 'pwd -W')
PYTHONPATH := $(WPWD)/../simModels;$(PYTHONPATH)
else
WPWD=$(shell pwd)
PYTHONPATH := $(WPWD)/../simModels:$(PYTHONPATH)
endif

VERILOG_SOURCES =  $(SOURCE_DIR)/jedro_1_top.v					\
				   $(SOURCE_DIR)/jedro_1_ifu.v					\
				   $(SOURCE_DIR)/jedro_1_regfile.v				\
				   $(SOURCE_DIR)/jedro_1_alu.v     				\
				   $(SOURCE_DIR)/jedro_1_decoder.v				\
				   $(SOURCE_DIR)/alu/adder/full_adder_1b.v		\
				   $(SOURCE_DIR)/alu/adder/ripple_carry_adder_Nb.v \
				   $(SOURCE_DIR)/alu/compare/equality_Nb.v \
				   $(SOURCE_DIR)/alu/compare/less_than_sign_Nb.v \
				   $(SOURCE_DIR)/alu/compare/less_than_unsign_Nb.v \
				   $(SOURCE_DIR)/alu/shift/mux2x1.v \
				   $(SOURCE_DIR)/alu/shift/barrel_shifter_left_32b.v \
				   $(SOURCE_DIR)/alu/shift/barrel_shifter_right_32b.v \
				   $(SOURCE_DIR)/sign_extender.v

TOPLEVEL = jedro_1_top # TOPLEVEL is the name of the top level module
MODULE = test_top # MODULE is the name of the Python test file

# Default simulator is icarus
ifeq ($(SIM),)
SIM = icarus
endif

ifeq ($(SIM),icarus)
COMPILE_ARGS = -I $(SOURCE_DIR)/inc/ -DICARUS=1
else ifeq ($(SIM),verilator)
COMPILE_ARGS = -I$(SOURCE_DIR)/inc/
EXTRA_ARGS += --trace --trace-structs --coverage
endif


# Simulation stuff
include $(shell cocotb-config --makefiles)/Makefile.sim

clean_other:
	rm -f  *.vcd
	rm -rf __pycache__/
	rm -f  results.xml
