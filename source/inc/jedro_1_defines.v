// This document contains the opcode definitions of RISC-V


// General defines
`define DATA_WIDTH 		 32
`define ADDR_WIDTH 		 $clog2(`DATA_WIDTH)

// OPCODES for RV32G/RV64G (All are defined but not necessarily implemented)

`define OPCODE_LOAD     7'b0000011
`define OPCODE_LOADFP	7'b0000111
`define OPCODE_CUSTOM0	7'b0001011
`define OPCODE_MISCMEM	7'b0001111
`define OPCODE_OPIMM	7'b0010011
`define OPCODE_AUIPC	7'b0010111
`define OPCODE_OPIMM32	7'b0011011
`define OPCODE_STORE	7'b0100011
`define OPCODE_STOREFP	7'b0100111
`define OPCODE_CUSTOM1	7'b0101011
`define OPCODE_AMO		7'b0101111
`define OPCODE_OP		7'b0110011
`define OPCODE_LUI		7'b0110111
`define OPCODE_OP32		7'b0111011
`define OPCODE_MADD		7'b1000011
`define OPCODE_MSUB		7'b1000111
`define OPCODE_NMSUB	7'b1001011
`define OPCODE_NMADD	7'b1001111
`define OPCODE_OPFP		7'b1010011
`define OPCODE_BRANCH	7'b1100011
`define OPCODE_JALR		7'b1100111
`define OPCODE_JAL		7'b1101111
`define OPCODE_SYSTEM	7'b1110011



// ALU defines
`define ALU_OP_WIDTH  	4	// Number of bits used to encode the operator of the ALU operation
`define ALU_OP_ADD		4'b0000







