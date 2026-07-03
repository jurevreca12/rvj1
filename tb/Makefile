.PHONY: all riscof cocotb clean

SHELL = /bin/bash

# Tools
RISCOF ?= riscof
PYTEST ?= pytest
BENDER ?= bender

# GNU
XLEN         ?= 32
ABI          ?= ilp32
RISCV_PREFIX ?= riscv64-unknown-elf-
RISCV_MARCH  ?= rv32i_zicsr
RISCV_VMARCH ?= rv32i_zicsr
export XLEN ABI RISCV_PREFIX RISCV_MARCH RISCV_VMARCH


BENDER_ARGS := --keep-excluded-incdirs \
               -t rtl \
			   -t sim \
			   -t tech_cells_generic_exclude_deprecated

JOBS 		:= $(shell /foss/designs/rvj1/scripts/half_nproc.sh)
PYTEST_ARGS ?= -n $(JOBS)

# Directories
MKFILE_PATH 	     := $(abspath $(lastword $(MAKEFILE_LIST)))
TB_DIR               := $(dir $(MKFILE_PATH))
COCOTB_DIR           := $(abspath $(TB_DIR)/cocotb)
RV_TEST_DIR          := $(abspath $(TB_DIR)/riscv-tests)
RV_TEST_BENCH_DIR    := $(abspath $(RV_TEST_DIR)/benchmarks)

# RISCOF
RISCOF_CFG_DIR       := $(abspath $(TB_DIR)/riscof-plugin)
RISCOF_WORK_DIR      := $(abspath $(TB_DIR)/riscof_work)
RISCV_ARCH_TEST_DIR  := $(abspath $(TB_DIR)/riscv-arch-test)
RISCV_TEST_SUITE_DIR := $(abspath $(RISCV_ARCH_TEST_DIR)/riscv-test-suite)
RISCV_RV32I_TEST_DIR := $(abspath $(RISCV_TEST_SUITE_DIR)/rv32i_m)
RISCV_TESTS_I_DIR    := $(abspath $(RISCV_RV32I_TEST_DIR)/I/src)
RISCV_TESTS_PRIV_DIR := $(abspath $(RISCV_RV32I_TEST_DIR)/privilege/src)
RISCV_TESTS_HINT_DIR := $(abspath $(RISCV_RV32I_TEST_DIR)/hints/src)
RISCOF_ARGS  ?= -v info
RISCOF_CFG 	 := $(abspath $(RISCOF_CFG_DIR)/config.ini)
RISCOF_ENV   := $(abspath $(RISCV_TEST_SUITE_DIR)/env)

RISCOF_DB        := $(abspath $(RISCOF_WORK_DIR)/database.yml)
RISCOF_DUT_MK    := $(abspath $(RISCOF_WORK_DIR)/Makefile.DUT-rvj1)
RISCOF_REF_MK    := $(abspath $(RISCOF_WORK_DIR)/Makefile.Reference-rvj1)
RISCOF_REPORT    := $(abspath $(RISCOF_WORK_DIR)/report.html)
RISCOF_ISA_YML   := $(abspath $(RISCOF_WORK_DIR)/rvj1_isa_checked.yml)
RISCOF_PLT_YML   := $(abspath $(RISCOF_WORK_DIR)/rvj1_platform_checked.yml)
RISCOF_STYLE     := $(abspath $(RISCOF_WORK_DIR)/style.css)
RISCOF_TEST_LIST := $(abspath $(RISCOF_WORK_DIR)/test_list.yml)

TESTS_I      := $(shell find $(RISCV_TESTS_I_DIR)    -name "*.S" -type f)
TESTS_HINTS  := $(shell find $(RISCV_TESTS_HINT_DIR) -name "*.S" -type f)
TESTS_PRIV   := $(shell find $(RISCV_TESTS_PRIV_DIR) -name "*.S" -type f)
TESTS        := $(TESTS_I) $(TESTS_HINTS) $(TESTS_PRIV)
TESTS_REL    := $(patsubst $(RISCV_TEST_SUITE_DIR)/%,%,$(TESTS))
TESTS_DIRS   := $(addprefix $(RISCOF_WORK_DIR)/,$(TESTS_REL))
DUT_DATA := $(addsuffix /dut/data.hex,$(TESTS_DIRS))
DUT_TEXT := $(addsuffix /dut/text.hex,$(TESTS_DIRS))
DUT_SIGS := $(addsuffix /dut/DUT-rvj1.signature,$(TESTS_DIRS))
DUT_ELFS := $(addsuffix /dut/my.elf,$(TESTS_DIRS))
REF_ELFS := $(addsuffix /ref/dut.elf,$(TESTS_DIRS))
REF_SIGS := $(addsuffix /ref/Reference-spike.signature,$(TESTS_DIRS))
REF_LOGS := $(addsuffix /ref/spike-commits.log,$(TESTS_DIRS))

RISCOF_TARGETS := $(RISCOF_WORK_DIR) \
                  $(RISCOF_DB) \
                  $(RISCOF_DUT_MK) \
                  $(RISCOF_REF_MK) \
                  $(RISCOF_REPORT) \
                  $(RISCOF_ISA_YML) \
                  $(RISCOF_PLT_YML) \
                  $(RISCOF_STYLE) \
                  $(RISCOF_TEST_LIST) \
                  $(DUT_DATA) \
                  $(DUT_TEXT) \
                  $(DUT_SIGS) \
                  $(DUT_ELFS) \
                  $(REF_ELFS) \
                  $(REF_SIGS) \
                  $(REF_LOGS)

# RISCV-TESTS
RV_TESTS := median \
            qsort \
            rsort \
            towers \
            vvadd \
            memcpy \
            multiply \
            dhrystone \
            spmv
RV_TESTS_BIN_NAMES := $(addsuffix .riscv, $(RV_TESTS))
RV_TESTS_BINS      := $(addprefix $(RV_TEST_BENCH_DIR)/, $(RV_TESTS_BIN_NAMES))

# COCOTB
SOURCES_FILE  := $(abspath $(COCOTB_DIR)/sources.f)
SIM           ?= verilator
TOPLEVEL_LANG ?= verilog
COMPILE_ARGS  += $(addprefix -D ,$(DEFINES))
COMPILE_ARGS  += -f $(SOURCES_FILE)
ELF_LIST_FILE := $(abspath $(COCOTB_DIR)/test_elf_files.list)
ELF_LIST      := $(DUT_ELFS) $(RV_TESTS_BINS)
SKIP_TESTS    := \
	$(RISCOF_WORK_DIR)/rv32i_m/privilege/src/misalign1-cjr-01.S/dut/my.elf \
	$(RISCOF_WORK_DIR)/rv32i_m/privilege/src/misalign1-cjalr-01.S/dut/my.elf
ELF_LIST      := $(filter-out $(SKIP_TESTS),$(ELF_LIST))

$(SOURCES_FILE):
	$(BENDER) script flist-plus $(BENDER_ARGS) > $(SOURCES_FILE)

$(ELF_LIST_FILE):
	echo $(ELF_LIST) > $(ELF_LIST_FILE)
	sed -i -e 's/ /\n/g' $(ELF_LIST_FILE)

$(RV_TESTS_BINS):
	make -C $(RV_TEST_BENCH_DIR) -f $(RV_TEST_BENCH_DIR)/Makefile $(patsubst $(RV_TEST_BENCH_DIR)/%,%,$@)

cocotb: $(SOURCES_FILE) $(ELF_LIST_FILE) $(ELF_LIST)
	cd $(COCOTB_DIR) && ELF_LIST_FILE=$(ELF_LIST_FILE) $(PYTEST) $(PYTEST_ARGS)

$(RISCOF_TARGETS) &:
	$(RISCOF) $(RISCOF_ARGS) run --config=$(RISCOF_CFG) --suite=$(RISCV_TEST_SUITE_DIR) --env=$(RISCOF_ENV)

riscof: $(RISCOF_TARGETS)

all: riscof cocotb

clean:
	rm -rf riscof_work/
	rm -rf cocotb/sim_build
	rm -rf cocotb/__pycache__
	rm -f cocotb/results.xml
	rm -f cocotb/test_elf_files.list
	rm -f cocotb/sources.f
