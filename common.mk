SHELL = /bin/bash
MAKEFLAGS = --warn-undefined-variables

# Tools
RISCOF    ?= riscof
PYTEST    ?= pytest
PYTHON    ?= python
BENDER    ?= bender
VERILATOR ?= verilator
RVGEN     ?= rvgen

# Source directories
MKFILE_PATH       := $(abspath $(lastword $(MAKEFILE_LIST)))
ROOT_DIR          := $(dir $(MKFILE_PATH))
TEST_DIR          := $(abspath $(ROOT_DIR)/tests)
TB_DIR            := $(abspath $(ROOT_DIR)/tb)
RVTESTS_DIR       := $(abspath $(TEST_DIR)/riscv-tests)
RISCOF_DIR        := $(abspath $(TEST_DIR)/riscof)
RVGEN_DIR 	      := $(abspath $(TEST_DIR)/rvgen)
RISCV_ARCH_DIR    := $(abspath $(TEST_DIR)/riscv-arch-test)

# Configuration
CONFIG ?= rv32i
CONFIG_MK := $(ROOT_DIR)/config/$(CONFIG).mk
include $(CONFIG_MK)

# Build directories
BUILD_DIR              := $(abspath $(ROOT_DIR)/build/$(CONFIG))
BUILD_TEST_DIR         := $(abspath $(BUILD_DIR)/tests)
BUILD_TEST_RVTESTS_DIR := $(abspath $(BUILD_TEST_DIR)/riscv-tests)
BUILD_TEST_RISCOF_DIR  := $(abspath $(BUILD_TEST_DIR)/riscof)
BUILD_TEST_RVGEN_DIR   := $(abspath $(BUILD_TEST_DIR)/rvgen)

# GNU
RISCV_PREFIX  ?= riscv64-unknown-elf-
RISCV_MARCH   ?= $(ISA)
RISCV_VMARCH  ?= $(ISA)
RISCV_GCC     ?= $(RISCV_PREFIX)gcc
RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump



# HELPER FUNCTIONS

# Convert GNU style arch string to rvgen style arch string
define gnu2rvgen
$(patsubst %_zicsr,%,$(1))
endef