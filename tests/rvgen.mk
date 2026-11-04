include ../common.mk

RVGEN_NUM_ITER   ?= 100
RVGEN_START_SEED ?= 42
INDICES := $(shell seq 0 $$(( $(RVGEN_NUM_ITER) - 1 )))
RVGEN_ASM_FILES := $(addprefix $(BUILD_TEST_RVGEN_DIR)/asm_test/riscv_rand_instr_test_,$(addsuffix .S,$(INDICES)))
RVGEN_ELF_FILES := $(addprefix $(BUILD_TEST_RVGEN_DIR)/asm_test/riscv_rand_instr_test_,$(addsuffix .elf,$(INDICES)))

RVGEN_USER_DEFINE_FILE := $(TEST_RVGEN_DIR)/user_define.h
RVGEN_USER_INIT_FILE   := $(TEST_RVGEN_DIR)/user_init.s

RVGEN_ARGS := \
	--target $(call gnu2rvgen,$(ISA)) \
	--mabi $(MABI) \
	--test riscv_rand_instr_test \
	--steps gen \
	--output $(BUILD_TEST_RVGEN_DIR) \
	--gen_opts '+enable_interrupt=1 +enable_timer_irq=1' \
	--start_seed $(RVGEN_START_SEED) \
	-i $(RVGEN_NUM_ITER)

RISCV_LINK_SCRIPT := $(TB_DIR)/support/rvgen.ld
RISCV_GCC_ARGS    := \
	-o0 \
	-I $(TEST_RVGEN_DIR) \
	-march=$(ISA) \
	-mabi=$(MABI) \
	-static \
	-mcmodel=medany \
	-fvisibility=hidden \
	-nostdlib \
	-nostartfiles \
	-T $(RISCV_LINK_SCRIPT)

.PHONY: all
all: $(RVGEN_ELF_FILES)

$(RVGEN_ASM_FILES) &:
	$(RVGEN) $(RVGEN_ARGS)

%.elf: %.S $(RVGEN_USER_DEFINE_FILE) $(RVGEN_USER_INIT_FILE)
	$(RISCV_GCC) $(RISCV_GCC_ARGS) -o $@ $<