# Verilog source files
CDIR = $(shell pwd)
SOURCE_DIR = $(CDIR)/../source

ifeq ($(OS),Msys)
WPWD=$(shell sh -c 'pwd -W')
PYTHONPATH := $(WPWD)/simModels;$(PYTHONPATH)
else
WPWD=$(shell pwd)
PYTHONPATH := $(WPWD)/simModels:$(PYTHONPATH)
endif


VERILOG_SOURCES =  $(SOURCE_DIR)/jedro_1_regfile.v				\
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

# Simulation stuff
SIM = icarus
TOPLEVEL = sign_extender # TOPLEVEL is the name of the top level module
MODULE = test_sign_extender # MODULE is the name of the Python test file
COMPILE_ARGS = -I $(SOURCE_DIR)/inc/


# Simulation stuff
include $(shell cocotb-config --makefiles)/Makefile.inc
include $(shell cocotb-config --makefiles)/Makefile.sim

