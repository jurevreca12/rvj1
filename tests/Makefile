.PHONY: all bender riscof debug cocotb clean

SHELL = /bin/bash


# Tools
PYTHON    ?= python
RVGEN     ?= rvgen

# GNU
XLEN         ?= 32
ABI          ?= ilp32
RISCV_PREFIX ?= riscv64-unknown-elf-
RISCV_MARCH  ?= rv32ic_zicsr
RISCV_VMARCH ?= rv32ic_zicsr
RISCV_GCC    ?= $(RISCV_PREFIX)gcc
export XLEN ABI RISCV_PREFIX RISCV_MARCH RISCV_VMARCH

# Directories
MKFILE_PATH 	     := $(abspath $(lastword $(MAKEFILE_LIST)))
TB_DIR               := $(dir $(MKFILE_PATH))
COCOTB_DIR           := $(abspath $(TB_DIR)/cocotb)
RV_TESTS_DIR         := $(abspath $(TB_DIR)/riscv-tests)
ROOT_DIR             := $(abspath $(TB_DIR)/..)


# RISCV-TESTS
RV_TESTS_DEBUG_TARGET    := $(TB_DIR)/support/rvj1_dbg_sim.py
DEBUG_TOP                := rvj1_debug_top 
DEBUG_VERILATOR_DIR      := $(TB_DIR)/debug_sim_model/
DEBUG_VERILATOR_BIN      := $(DEBUG_VERILATOR_DIR)/V$(DEBUG_TOP)
DBG_MODULE_DIR		     := $(shell bender path riscv-dbg)
REMOTE_BITBANG_DIR       := $(DBG_MODULE_DIR)/tb/remote_bitbang/
REMOTE_BITBANG_LIB       := $(REMOTE_BITBANG_DIR)/librbs.so
VERILATOR_LDFLAGS        := -L$(REMOTE_BITBANG_DIR) -Wl,--enable-new-dtags -Wl,-rpath,remote_bitbang -lrbs
VERILATOR_ARGS           := --timescale 1ns/1ps --binary -Wno-fatal -Wno-style 
ifdef VERILATOR_DEBUG
VERILATOR_ARGS           += --trace --trace-structs --trace-params -DRVFI
endif
VERILATOR_ARGS           += --top $(DEBUG_TOP) -f $(SOURCES_FILE) --Mdir $(DEBUG_VERILATOR_DIR)
VERILATOR_ARGS           += -LDFLAGS "$(VERILATOR_LDFLAGS)" $(DBG_MODULE_DIR)/tb/SimJTAG.sv
define NL


endef
DEBUG_TARGET_TIMEOUT     ?= 200
EXCLUDE_TESTS_FILE       := $(TB_DIR)/support/rvj1_exclude_debug_tests.yaml
GDBSERVER_ARGS		     := --seed 42 \
					   	    --32 \
					   	    --hart 0 \
							--exclude-tests $(EXCLUDE_TESTS_FILE)\
					   	    --target-timeout $(DEBUG_TARGET_TIMEOUT)


RISCV_LINK_SCRIPT := $(TB_DIR)/support/rvgen.ld
RISCV_GCC_ARGS    := -o0 -march=$(RVGEN_MARCH) -static -mcmodel=medany -fvisibility=hidden \
                     -mabi=ilp32 -nostdlib -nostartfiles -T $(RISCV_LINK_SCRIPT)
# COCOTB
SIM           ?= verilator
TOPLEVEL_LANG ?= verilog
COMPILE_ARGS  += $(addprefix -D ,$(DEFINES))
COMPILE_ARGS  += -f $(SOURCES_FILE)
ELF_LIST_FILE := $(abspath $(COCOTB_DIR)/test_elf_files.list)
ELF_LIST      := $(DUT_ELFS) $(RV_TESTS_BINS) $(RVGEN_ELF_FILES)
SKIP_TESTS    := \
	$(RISCOF_WORK_DIR)/rv32i_m/privilege/src/misalign1-cjr-01.S/dut/my.elf \
	$(RISCOF_WORK_DIR)/rv32i_m/privilege/src/misalign1-cjalr-01.S/dut/my.elf
ELF_LIST      := $(filter-out $(SKIP_TESTS),$(ELF_LIST))

$(SOURCES_FILE): $(BENDER_YAML)
	$(BENDER) script flist-plus $(BENDER_ARGS) > $(SOURCES_FILE)

$(ELF_LIST_FILE):
	echo $(ELF_LIST) > $(ELF_LIST_FILE)
	sed -i -e 's/ /\n/g' $(ELF_LIST_FILE)

$(RV_TESTS_BINS):
	make -C $(RV_TESTS_BENCH_DIR) -f $(RV_TESTS_BENCH_DIR)/Makefile $(patsubst $(RV_TESTS_BENCH_DIR)/%,%,$@)

$(RVGEN_ASM_FILES) &:
	$(RVGEN) $(RVGEN_ARGS)
	touch $(RVGEN_OUT_DIR)/asm_test/user_define.h
	touch $(RVGEN_OUT_DIR)/asm_test/user_init.s


%.elf: %.S
	$(RISCV_GCC) $(RISCV_GCC_ARGS) -o $@ $<

