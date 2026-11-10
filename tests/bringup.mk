include ../common.mk

BRINGUP_SOURCES := $(shell find $(TEST_BRINGUP_DIR) -type f -name '*.s' | sed 's|^\./||')
BRINGUP_ELFS    := $(patsubst $(TEST_BRINGUP_DIR)/%.s,$(BUILD_TEST_BRINGUP_DIR)/%.elf,$(BRINGUP_SOURCES))

RISCV_LINK_SCRIPT := $(SCRIPTS_DIR)/bringup.ld
RISCV_GCC_ARGS := \
	-O0 \
	-march=$(ISA) \
	-mabi=$(MABI) \
	-static \
	-mcmodel=medany \
	-fvisibility=hidden \
	-nostdlib \
	-nostartfiles \
	-T $(RISCV_LINK_SCRIPT)

.PHONY: all clean
all: $(BRINGUP_ELFS)

$(BUILD_TEST_BRINGUP_DIR)/%.elf: $(TEST_BRINGUP_DIR)/%.s
	mkdir -p "$(@D)"
	$(RISCV_GCC) $(RISCV_GCC_ARGS) -o $@ $<

sim: $(BRINGUP_ELFS)
	$(MAKE) -C $(TEST_BRINGUP_DIR) SIM=$(SIM) TOPLEVEL_LANG=$(TOPLEVEL_LANG) SIM_BUILD=$(SIM_BUILD) COCOTB_RESULTS_FILE=$(COCOTB_RESULTS_FILE) COMPILE_ARGS="$(COMPILE_ARGS)" SIM_ARGS="$(SIM_ARGS)" TOPLEVEL=$(TOPLEVEL) MODULE=$(MODULE)

clean:
	rm -rf $(BUILD_TEST_BRINGUP_DIR)
