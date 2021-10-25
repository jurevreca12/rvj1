// This document contains the opcode definitions of RISC-V
`timescale 1ns/1ps
package jedro_1_defines;

// General defines
parameter DATA_WIDTH     =  32;
parameter REG_ADDR_WIDTH =  $clog2(DATA_WIDTH);
parameter BOOT_ADDR      =  32'h0000_0000;

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

endpackage
