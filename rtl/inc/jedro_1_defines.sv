// This document contains the opcode definitions of RISC-V
`timescale 1ns/1ps
package jedro_1_defines;

// General defines
parameter DATA_WIDTH     = 32;
parameter REG_ADDR_WIDTH = $clog2(DATA_WIDTH);
parameter BOOT_ADDR      = 32'h0000_0000;

parameter NOP_INSTR      = 32'b000000000001_00000_000_00000_0010011;

// OPCODES for RV32G/RV64G (All are defined but not necessarily implemented)
parameter OPCODE_LOAD    = 7'b0000011;
parameter OPCODE_LOADFP  = 7'b0000111;
parameter OPCODE_CUSTOM0 = 7'b0001011;
parameter OPCODE_MISCMEM = 7'b0001111;
parameter OPCODE_OPIMM   = 7'b0010011;
parameter OPCODE_AUIPC   = 7'b0010111;
parameter OPCODE_OPIMM32 = 7'b0011011;
parameter OPCODE_STORE   = 7'b0100011;
parameter OPCODE_STOREFP = 7'b0100111;
parameter OPCODE_CUSTOM1 = 7'b0101011;
parameter OPCODE_AMO     = 7'b0101111;
parameter OPCODE_OP      = 7'b0110011;
parameter OPCODE_LUI     = 7'b0110111;
parameter OPCODE_OP32    = 7'b0111011;
parameter OPCODE_MADD    = 7'b1000011;
parameter OPCODE_MSUB    = 7'b1000111;
parameter OPCODE_NMSUB   = 7'b1001011;
parameter OPCODE_NMADD   = 7'b1001111;
parameter OPCODE_OPFP    = 7'b1010011;
parameter OPCODE_BRANCH  = 7'b1100011;
parameter OPCODE_JALR    = 7'b1100111;
parameter OPCODE_JAL     = 7'b1101111;
parameter OPCODE_SYSTEM  = 7'b1110011;

// ALU defines
parameter ALU_OP_WIDTH = 4;       // Number of bits used to encode the operator of the ALU operation
parameter ALU_OP_ADD   = 4'b0000;
parameter ALU_OP_SUB   = 4'b1000;
parameter ALU_OP_SLL   = 4'b0001;
parameter ALU_OP_SLT   = 4'b0010;
parameter ALU_OP_SLTU  = 4'b0011;
parameter ALU_OP_XOR   = 4'b0100;
parameter ALU_OP_SRL   = 4'b0101;
parameter ALU_OP_SRA   = 4'b1101;
parameter ALU_OP_OR    = 4'b0110;
parameter ALU_OP_AND   = 4'b0111;

// funct3 defines
parameter FUNCT3_SHIFT_INSTR = 3'b101;

// Load-Store Unit
parameter LSU_CTRL_WIDTH = 4; // we need to encode 8 states 
parameter LSU_LOAD_BYTE            = 4'b0000;
parameter LSU_LOAD_HALF_WORD       = 4'b0001;
parameter LSU_LOAD_WORD            = 4'b0010;
parameter LSU_LOAD_BYTE_UPPER      = 4'b0100;
parameter LSU_LOAD_HALF_WORD_UPPER = 4'b0101;
parameter LSU_STORE_BYTE           = 4'b1000;
parameter LSU_STORE_HALF_WORD      = 4'b1001;
parameter LSU_STORE_WORD           = 4'b1010;


// CONTROL AND STATUS REGISTERS
parameter TRAP_VEC_BASE_ADDR       = 30'h0010_0000;
parameter TRAP_VEC_MODE            = 2'b00; // direct mode (vectored == 01)

// Machine Information Registers 
parameter CSR_ADDR_MVENDORID       = 12'hF11;
parameter CSR_DEF_VAL_MVENDORID    = 32'b0;
parameter CSR_ADDR_MARCHID         = 12'hF12;
parameter CSR_DEF_VAL_MARCHID      = 32'b0;
parameter CSR_ADDR_MIMPID          = 12'hF13;
parameter CSR_DEF_VAL_MIMPID       = 32'b0;
parameter CSR_ADDR_MHARTID         = 12'hF14;
parameter CSR_DEF_VAL_MHARTID      = 32'b0;

// Machine Trap Registers
parameter CSR_ADDR_MSTATUS         = 12'h300;
parameter CSR_MSTATUS_BIT_MIE      = 3; // machine interrupt enable
parameter CSR_MSTATUS_BIT_MPIE     = 7; // previous machine interrupt enable
parameter CSR_DEF_VAL_MSTATUS      = 32'b00000000_0000000_0000000_0000000;
parameter CSR_ADDR_MISA            = 12'h301;
parameter CSR_DEF_VAL_MISA         = 32'b01_0000_00000000000000000100000000;

parameter CSR_ADDR_MTVEC           = 12'h305;
parameter CSR_MTVEC_BASE_LEN       = 30;
parameter CSR_DEF_VAL_MTVEC        = 32'b{TRAP_VEC_BASE_ADDR, TRAP_VEC_MODE};

parameter CSR_ADDR_MIP             = 12'h344;
parameter CSR_MIP_BIT_MSIP         = 3; // machine software interrupt pending
parameter CSR_MIP_BIT_MTIP         = 7; // machine timer interrupt pending
parameter CSR_MIP_BIT_MEIP         = 11; // machine external interrupt pending
parameter CSR_DEF_VAL_MIP          = 32'b00000000_00000000_00000000_00000000;
endpackage
