# Verilog source files
CDIR = $(shell pwd)
SOURCE_DIR = $(CDIR)/../source

VERILOG_SOURCES =  $(SOURCE_DIR)/jedro_1_regfile.v				\
				   $(SOURCE_DIR)/jedro_1_alu.v     				\
				   $(SOURCE_DIR)/jedro_1_decoder.v				\
				   $(SOURCE_DIR)/alu/adder/full_adder_1b.v		\
				   $(SOURCE_DIR)/alu/adder/ripple_carry_adder_Nb.v

# Simulation stuff
SIM = icarus
TOPLEVEL = jedro_1_decoder # TOPLEVEL is the name of the top level module
MODULE = test_decoder # MODULE is the name of the Python test file:
COMPILE_ARGS = -I $(SOURCE_DIR)/inc/


# Simulation stuff
include $(shell cocotb-config --makefiles)/Makefile.inc
include $(shell cocotb-config --makefiles)/Makefile.sim

