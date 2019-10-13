# Simulation stuff
SIM = icarus
SOURCE_DIR = ../source/
VERILOG_SOURCES = $(SOURCE_DIR)/top.v
COCOTB_RESULTS_FILE = log/results.xml
COMPILE_ARGS=
SIM_ARGS=
SIM_BUILD=log/.
TOPLEVEL = top # TOPLEVEL is the name of the top level module
MODULE = test_top # MODULE is the name of the Python test file:

# Simulation stuff
include $(shell cocotb-config --makefiles)/Makefile.inc
include $(shell cocotb-config --makefiles)/Makefile.sim

