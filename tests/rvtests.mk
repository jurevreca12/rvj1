include ../common.mk

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

.PHONY: all
all: $(BUILD_BINS)

$(BINS): 
	cd $(BENCH_DIR) && $(MAKE) $(patsubst $(BENCH_DIR)/%,%,$@)

$(BUILD_TEST_RVTESTS_DIR)/%.elf: $(BENCH_DIR)/%.riscv
	mkdir -p $(BUILD_TEST_RVTESTS_DIR)
	mv $< $@
