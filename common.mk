SHELL = /bin/bash

# Tools
RISCOF    ?= riscof
PYTEST    ?= pytest
PYTHON    ?= python
BENDER    ?= bender
VERILATOR ?= verilator
RVGEN     ?= rvgen

# Directories
MKFILE_PATH       := $(abspath $(lastword $(MAKEFILE_LIST)))
ROOT_DIR          := $(dir $(MKFILE_PATH))
TEST_DIR          := $(abspath $(ROOT_DIR)/tests)
RVTESTS_DIR       := $(abspath $(TEST_DIR)/riscv-tests)
RISCOF_DIR        := $(abspath $(TEST_DIR)/riscof)
RISCV_ARCH_DIR    := $(abspath $(TEST_DIR)/riscv-arch-test)

CONFIG ?= rv32i
CONFIG_MK := $(ROOT_DIR)/config/$(CONFIG).mk
include $(CONFIG_MK)

BUILD_DIR              := $(abspath $(ROOT_DIR)/build/$(CONFIG))
BUILD_TEST_DIR         := $(abspath $(BUILD_DIR)/tests)
BUILD_TEST_RVTESTS_DIR := $(abspath $(BUILD_TEST_DIR)/riscv-tests)
BUILD_TEST_RISCOF_DIR  := $(abspath $(BUILD_TEST_DIR)/riscof)
