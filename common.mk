SHELL = /bin/bash
MAKEFLAGS += --warn-undefined-variables

# Tools
RISCOF    ?= riscof
PYTEST    ?= pytest
PYTHON    ?= python
BENDER    ?= bender
VERILATOR ?= verilator
RVGEN     ?= rvgen
DTC       ?= dtc

# Sources
MKFILE_PATH         := $(abspath $(lastword $(MAKEFILE_LIST)))
ROOT_DIR            := $(dir $(MKFILE_PATH))
TEST_DIR            := $(abspath $(ROOT_DIR)/tests)
TB_DIR              := $(abspath $(ROOT_DIR)/tb)
SCRIPTS_DIR         := $(abspath $(ROOT_DIR)/scripts)
CONFIG_DIR          := $(abspath $(ROOT_DIR)/config)
TEST_RVTESTS_DIR    := $(abspath $(TEST_DIR)/riscv-tests)
TEST_RISCOF_DIR     := $(abspath $(TEST_DIR)/riscof)
TEST_RVGEN_DIR 	    := $(abspath $(TEST_DIR)/rvgen)
TEST_RISCV_ARCH_DIR := $(abspath $(TEST_DIR)/riscv-arch-test)
TEST_BRINGUP_DIR    := $(abspath $(TEST_DIR)/bringup)
TEST_COCOTB_DIR     := $(abspath $(TEST_DIR)/cocotb)
BENDER_YAML_FILE    := $(abspath $(ROOT_DIR)/Bender.yml)

# Configuration
CONFIG ?= rv32i
CONFIG_MK := $(CONFIG_DIR)/$(CONFIG).mk
include $(CONFIG_MK)

# Build directories and files
BUILD_DIR              := $(abspath $(ROOT_DIR)/build/$(CONFIG))
BUILD_TEST_DIR         := $(abspath $(BUILD_DIR)/tests)
BUILD_TEST_RVTESTS_DIR := $(abspath $(BUILD_TEST_DIR)/riscv-tests)
BUILD_TEST_RISCOF_DIR  := $(abspath $(BUILD_TEST_DIR)/riscof)
BUILD_TEST_RVGEN_DIR   := $(abspath $(BUILD_TEST_DIR)/rvgen)
BUILD_TEST_COCOTB_DIR  := $(abspath $(BUILD_TEST_DIR)/cocotb)
BUILD_TEST_BRINGUP_DIR := $(abspath $(BUILD_TEST_DIR)/bringup)
BUILD_CONFIG_DIR       := $(abspath $(BUILD_DIR)/config)
BUILD_CONFIG_SIM_FLIST := $(abspath $(BUILD_CONFIG_DIR)/sim_sources.flist)
BUILD_CONFIG_DTB       := $(abspath $(BUILD_CONFIG_DIR)/sim.dtb)

BUILD_IFU_DIR          := $(abspath $(ROOT_DIR)/build/rvj1_ifu)
BUILD_IFU_RVC_DIR      := $(abspath $(ROOT_DIR)/build/rvj1_ifu_rvc)
BUILD_IFU_SIM_FLIST    := $(abspath $(BUILD_IFU_DIR)/sim_sources.flist)
BUILD_IFU_RVC_SIM_FLIST:= $(abspath $(BUILD_IFU_RVC_DIR)/sim_sources.flist)

SCRIPTS_DTS            := $(abspath $(SCRIPTS_DIR)/$(CONFIG).dts)

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
