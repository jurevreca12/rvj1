// This document contains the opcode definitions of RISC-V


// General defines
`define DATA_WIDTH 		 32
`define REG_ADDR_WIDTH 	 $clog2(`DATA_WIDTH)
`define BOOT_ADDR		 8'h0000_0000

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
`define ALU_OP_SUB		4'b1000
`define ALU_OP_SLL		4'b0001
`define ALU_OP_SLT		4'b0010
`define ALU_OP_SLTU		4'b0011
`define ALU_OP_XOR		4'b0100
`define ALU_OP_SRL		4'b0101
`define ALU_OP_SRA		4'b1101
`define ALU_OP_OR		4'b0110
`define ALU_OP_AND		4'b0111






