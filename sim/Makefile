# Verilog source files
GUI=1
WAVES=1
SOURCE_DIR = ../source/
VERILOG_SOURCES =  $(SOURCE_DIR)/jedro_1_regfile.v
					
# Simulation stuff
SIM = icarus
COCOTB_RESULTS_FILE = log/results.xml
COMPILE_ARGS=
SIM_ARGS=
SIM_BUILD=log/.
TOPLEVEL = jedro_1_regfile # TOPLEVEL is the name of the top level module
MODULE = test_regfile # MODULE is the name of the Python test file:

# Simulation stuff
include $(shell cocotb-config --makefiles)/Makefile.inc
include $(shell cocotb-config --makefiles)/Makefile.sim

