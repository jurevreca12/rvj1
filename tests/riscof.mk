include ../common.mk

RISCV_TEST_SUITE_DIR 	 := $(abspath $(TEST_RISCV_ARCH_DIR)/riscv-test-suite)
RISCV_TEST_SUITE_ENV_DIR := $(abspath $(TEST_RISCV_ARCH_DIR)/riscv-test-suite/env/)
RISCOF_CONFIG_FILE       := $(abspath $(TEST_RISCOF_DIR)/$(RISCOF_CONFIG))

DUT_MK       := $(abspath $(BUILD_TEST_RISCOF_DIR)/Makefile.DUT-rvj1)
REF_MK       := $(abspath $(BUILD_TEST_RISCOF_DIR)/Makefile.Reference-rvj1)
REPORT_MK    := $(abspath $(BUILD_TEST_RISCOF_DIR)/report.html)
TEST_LIST_MK := $(abspath $(BUILD_TEST_RISCOF_DIR)/test_list.yml)

RISCOF_ARGS ?= -v info

TARGETS := \
	$(DUT_MK) \
	$(REF_MK) \
	$(REPORT_MK) \
	$(TEST_LIST_MK)

$(TARGETS) &: $(RISCOF_CONFIG_FILE) $(BUILD_CONFIG_SIM_FLIST)
	mkdir -p $(BUILD_TEST_RISCOF_DIR)
	SOURCES_FILE=$(BUILD_CONFIG_SIM_FLIST) SCRIPTS_DIR=$(SCRIPTS_DIR) $(RISCOF) $(RISCOF_ARGS) run \
	--no-browser \
	--config=$(RISCOF_CONFIG_FILE) \
	--suite=$(RISCV_TEST_SUITE_DIR) \
	--env=$(RISCV_TEST_SUITE_ENV_DIR) \
	--work-dir=$(BUILD_TEST_RISCOF_DIR)

.PHONY: all
all: $(TARGETS)
