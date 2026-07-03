.PHONY: all clean

SHELL         := /bin/bash
RISCV_GCC     ?= riscv64-unknown-elf-gcc
RISCV_OBJCOPY ?= riscv64-unknown-elf-objcopy
SPIKE_PATH    ?= /foss/tools/bin/
export RISCV_GCC
export RISCV_OBJCOPY
export SPIKE_PATH

MAKEFILE_DIR  := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
CFG_DIR       := $(abspath $(MAKEFILE_DIR)/../riscv-dv-cfg/)

RISCV_ISA  := rv32i_zicsr_zifencei
RISCV_PRIV := m


RISCV_DV_RUN  := PYTHONPATH=${RISCV_DV}/pygen:${PYTHONPATH} python ${RISCV_DV}/run.py
RISCV_DV_ARGS := --custom_target ${CFG_DIR} \
                 --target rv32i \
                 --mabi ilp32\
                 --seed 42 \
                 --iterations 1 \
                 --batch_size 1 \
                 --isa rv32i_zicsr_zifencei \
                 --simulator pyflow \
                 --gen_timeout 1800 \
		 --iss spike \
		 --iss_yaml ${CFG_DIR}/iss.yaml \
		 --steps gen \
		 -v \
                 --verbose

TESTS         ?= riscv_arithmetic_basic_test \
                 riscv_rand_jump_test \
                 riscv_no_fence_test \
                 riscv_illegal_instr_test \
                 riscv_ebreak_test \
                 riscv_ebreak_debug_mode_test \
                 riscv_full_interrupt_test \
                 riscv_csr_test \
                 riscv_unaligned_load_store_test
                 #riscv_loop_test \
                 #riscv_jump_stress_test \
                 #riscv_rand_instr_test \

TEST_DIRS     := $(abspath $(patsubst %,$(MAKEFILE_DIR)/%_out,$(TESTS)) )



all: $(TEST_DIRS)

$(TEST_DIRS):
	$(RISCV_DV_RUN) $(RISCV_DV_ARGS) --output $@ --test $(patsubst %_out,%,$(notdir $@)) #>$@_err.log 2>&1

clean:
	rm -rf riscv_*out/
	rm -f *err.log
