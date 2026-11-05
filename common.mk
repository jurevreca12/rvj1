SHELL = /bin/bash
MAKEFLAGS += --warn-undefined-variables

# Tools
RISCOF    ?= riscof
PYTEST    ?= pytest
PYTHON    ?= python
BENDER    ?= bender
VERILATOR ?= verilator
RVGEN     ?= rvgen

# Sources
MKFILE_PATH         := $(abspath $(lastword $(MAKEFILE_LIST)))
ROOT_DIR            := $(dir $(MKFILE_PATH))
TEST_DIR            := $(abspath $(ROOT_DIR)/tests)
TB_DIR              := $(abspath $(ROOT_DIR)/tb)
SCRIPTS_DIR         := $(abspath $(ROOT_DIR)/scripts)
TEST_RVTESTS_DIR    := $(abspath $(TEST_DIR)/riscv-tests)
TEST_RISCOF_DIR     := $(abspath $(TEST_DIR)/riscof)
TEST_RVGEN_DIR 	    := $(abspath $(TEST_DIR)/rvgen)
TEST_RISCV_ARCH_DIR := $(abspath $(TEST_DIR)/riscv-arch-test)
BENDER_YAML_FILE    := $(abspath $(ROOT_DIR)/Bender.yml)

# Configuration
CONFIG ?= rv32i
CONFIG_MK := $(ROOT_DIR)/config/$(CONFIG).mk
include $(CONFIG_MK)

# Build directories and files
BUILD_DIR              := $(abspath $(ROOT_DIR)/build/$(CONFIG))
BUILD_TEST_DIR         := $(abspath $(BUILD_DIR)/tests)
BUILD_TEST_RVTESTS_DIR := $(abspath $(BUILD_TEST_DIR)/riscv-tests)
BUILD_TEST_RISCOF_DIR  := $(abspath $(BUILD_TEST_DIR)/riscof)
BUILD_TEST_RVGEN_DIR   := $(abspath $(BUILD_TEST_DIR)/rvgen)
BUILD_CONFIG_DIR       := $(abspath $(BUILD_DIR)/config)
BUILD_CONFIG_SIM_FLIST := $(abspath $(BUILD_CONFIG_DIR)/sim_sources.flist)
# GNU
RISCV_PREFIX  ?= riscv64-unknown-elf-
RISCV_MARCH   ?= $(ISA)
RISCV_VMARCH  ?= $(ISA)
RISCV_GCC     ?= $(RISCV_PREFIX)gcc
RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump

# Filelists

BENDER_SIM_ARGS := \
	--keep-excluded-incdirs \
	-t rtl \
	-t sim \
	-t tech_cells_generic_exclude_deprecated

$(BUILD_CONFIG_SIM_FLIST): $(BENDER_YAML_FILE)
	mkdir -p $(BUILD_CONFIG_DIR)
	$(BENDER) script flist-plus $(BENDER_SIM_ARGS) > $(BUILD_CONFIG_SIM_FLIST)

# HELPER FUNCTIONS

# Convert GNU style arch string to rvgen style arch string
define gnu2rvgen
$(patsubst %_zicsr,%,$(1))
endef
