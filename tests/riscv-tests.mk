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


RISCV_GCC_OPTS ?= \
    -U_FORTIFY_SOURCE -DPREALLOCATE=1 -mcmodel=medany \
    -static -std=gnu99 -O2 -ffast-math -fno-common \
    -fno-builtin-printf -fno-tree-loop-distribute-patterns \
    -Wno-implicit-int -Wno-implicit-function-declaration \
    -mabi=$(MABI)

INCLUDES := \
    -I$(BENCH_DIR)/../env \
    -I$(BENCH_DIR)/common \
    $(addprefix -I$(BENCH_DIR)/,$(RV_TESTS))

LINK_OPTS ?= \
    -static -nostdlib -nostartfiles -lm -lgcc \
    -T $(BENCH_DIR)/common/test.ld

.PHONY: all clean
all: $(BUILD_BINS)

define compile_template
$(BUILD_TEST_RVTESTS_DIR)/$(1).elf: \
    $(wildcard $(BENCH_DIR)/$(1)/*) \
    $(wildcard $(BENCH_DIR)/common/*)
	@mkdir -p $(BUILD_TEST_RVTESTS_DIR)
	$(RISCV_GCC) $(INCLUDES) $(RISCV_GCC_OPTS) -march=$(RISCV_MARCH) \
	    -o $$@ \
	    $(wildcard $(BENCH_DIR)/$(1)/*.c) \
	    $(wildcard $(BENCH_DIR)/$(1)/*.S) \
	    $(wildcard $(BENCH_DIR)/common/*.c) \
	    $(wildcard $(BENCH_DIR)/common/*.S) \
	    $(LINK_OPTS)
endef

$(foreach bmark,$(RV_TESTS),\
  $(eval $(call compile_template,$(bmark))))

clean:
	rm -f $(BUILD_BINS)
