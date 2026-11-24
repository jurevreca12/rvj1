THIS_MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
include $(THIS_MAKEFILE_DIR)/../common.mk

RV_TESTS ?= median \
            qsort \
            rsort \
            towers \
            vvadd \
            memcpy \
            multiply 

BENCH_DIR         := $(abspath $(TEST_RVTESTS_DIR)/benchmarks)

BIN_NAMES         := $(addsuffix .riscv, $(RV_TESTS))
BIN_NAMES_ELF     := $(addsuffix .elf, $(RV_TESTS))
BINS              := $(addprefix $(BENCH_DIR)/, $(BIN_NAMES))
BUILD_BINS        := $(addprefix $(BUILD_TEST_RVTESTS_DIR)/, $(BIN_NAMES_ELF))

export RISCV_PREFIX RISCV_GCC RISCV_MARCH RISCV_VMARCH XLEN
export ABI = $(MABI)

.PHONY: all
all: $(BUILD_BINS)

$(BINS): 
	cd $(BENCH_DIR) && $(MAKE) $(patsubst $(BENCH_DIR)/%,%,$@)

$(BUILD_TEST_RVTESTS_DIR)/%.elf: $(BENCH_DIR)/%.riscv
	mkdir -p $(BUILD_TEST_RVTESTS_DIR)
	mv $< $@
