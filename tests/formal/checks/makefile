NUM_PROC ?= $(shell nproc --ignore=2)
instrs = add addi and andi auipc beq     \
         bge bgeu blt bltu bne jal jalr  \
         lb lbu lh lhu lui lw or ori sb  \
         sh sll slli slt slti sltiu sltu \
         sra srai srl srli sub sw xor xori
instr_targets := $(foreach insn,$(instrs),insn_ch0_$(insn))
status_targets := $(foreach target,$(all_targets),$(target)/status)
all_targets= reg_ch0 causal_ch0 pc_bwd_ch0 unique_ch0 ${instr_targets}
.PHONY: reg_ch0 causal_ch0 pc_bwd_ch0 unique_ch0 ${instr_targets} clean

all: ${all_targets} 

reg_ch0: reg_ch0/status
reg_ch0/status:
	sby reg_ch0.sby

causal_ch0: causal_ch0/status
causal_ch0/status:
	sby causal_ch0.sby

pc_bwd_ch0: pc_bwd_ch0/status
pc_bwd_ch0/status:
	sby pc_bwd_ch0.sby

unique_ch0: unique_ch0/status
unique_ch0/status:
	sby unique_ch0.sby

${instr_targets}: insn_ch0.sby
	sby -j $(NUM_PROC) insn_ch0.sby



clean:
	rm -rf insn_ch0 reg_ch0 causal_ch0 pc_bwd_ch0 unique_ch0 ${instr_targets}
