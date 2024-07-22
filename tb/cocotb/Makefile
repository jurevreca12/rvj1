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

VERILOG_SOURCES = $(shell find ${SOURCE_DIR} -type f -iname '*.v')

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
