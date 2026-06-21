parameter int XLEN = 32;

riscv_instr_group_t supported_isa[$] = '{
  RV32I,
  RV32ZICSR
};

bit support_debug_mode = 1;
bit support_umode = 0;
bit support_supervisor_mode = 0;
