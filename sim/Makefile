WAVES=1
GUI=1
# Verilog source files
SOURCE_DIR = ../source/
VERILOG_SOURCES =  $(SOURCE_DIR)/jedro_1_regfile.v
					
# Simulation stuff
SIM = icarus
TOPLEVEL = jedro_1_regfile # TOPLEVEL is the name of the top level module
MODULE = test_regfile # MODULE is the name of the Python test file:

# Simulation stuff
include $(shell cocotb-config --makefiles)/Makefile.inc
include $(shell cocotb-config --makefiles)/Makefile.sim
