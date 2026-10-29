.PHONY: all rv32i rv32ic clean

SHELL = /bin/bash

# Tools
RISCOF    ?= riscof
PYTHON    ?= python
VERILATOR ?= verilator

# Directories
MAKE_FILE                := $(abspath $(lastword $(MAKEFILE_LIST)))
RISCOF_DIR               := $(dir $(MAKE_FILE))
RISCOF_PLUGIN_DIR        := $(dir $(RISCOF_DIR)/plugin/)
TB_DIR                   := $(dir $(RISCOF_DIR)/../)
RISCV_TEST_SUITE_DIR     := $(dir $(RISCOF_DIR)/../riscv-arch-test/riscv-test-suite/)
RISCV_TEST_SUITE_ENV_DIR := $(dir $(RISCV_TEST_SUITE_DIR)/env/)
RV32I_WORK_DIR           := $(dir $(RISCOF_DIR)/rv32i_work/)
RV32IC_WORK_DIR          := $(dir $(RISCOF_DIR)/rv32ic_work/)

SOURCES_FILE := $(abspath $(TB_DIR)/sources.f)

# RISCOF
CFG_RV32I   := $(abspath $(RISCOF_PLUGIN_DIR)/config_rv32i.ini)
CFG_RV32IC  := $(abspath $(RISCOF_PLUGIN_DIR)/config_rv32ic.ini)

RISCOF_ARGS ?= -v info

DUT_MK_RV32I    := $(abspath $(RV32I_WORK_DIR)/Makefile.DUT-rvj1)
REF_MK_RV32I    := $(abspath $(RV32I_WORK_DIR)/Makefile.Reference-rvj1)
REPORT_RV32I    := $(abspath $(RV32I_WORK_DIR)/report.html)
TEST_LIST_RV32I := $(abspath $(RV32I_WORK_DIR)/test_list.yml)
TARGETS_RV32I   := \
	$(DUT_MK_RV32I) \
	$(REF_MK_RV32I) \
	$(REPORT_RV32I) \
	$(TEST_LIST_RV32I)

DUT_MK_RV32IC    := $(abspath $(RV32IC_WORK_DIR)/Makefile.DUT-rvj1)
REF_MK_RV32IC    := $(abspath $(RV32IC_WORK_DIR)/Makefile.Reference-rvj1)
REPORT_RV32IC    := $(abspath $(RV32IC_WORK_DIR)/report.html)
TEST_LIST_RV32IC := $(abspath $(RV32IC_WORK_DIR)/test_list.yml)
TARGETS_RV32IC   := \
	$(DUT_MK_RV32IC) \
	$(REF_MK_RV32IC) \
	$(REPORT_RV32IC) \
	$(TEST_LIST_RV32IC)

$(TARGETS_RV32I) &: $(CFG_RV32I)
	SOURCES_FILE=$(SOURCES_FILE) $(RISCOF) $(RISCOF_ARGS) run \
	--no-browser \
	--config=$(CFG_RV32I) \
	--suite=$(RISCV_TEST_SUITE_DIR) \
	--env=$(RISCV_TEST_SUITE_ENV_DIR) \
	--work-dir=$(RV32I_WORK_DIR)

$(TARGETS_RV32IC) &: $(CFG_RV32IC)
	SOURCES_FILE=$(SOURCES_FILE) $(RISCOF) $(RISCOF_ARGS) run \
	--no-browser \
	--config=$(CFG_RV32IC) \
	--suite=$(RISCV_TEST_SUITE_DIR) \
	--env=$(RISCV_TEST_SUITE_ENV_DIR) \
	--work-dir=$(RV32IC_WORK_DIR)

rv32i: $(TARGETS_RV32I) 
rv32ic: $(TARGETS_RV32IC) 

clean:
	rm -rf riscof_work/
