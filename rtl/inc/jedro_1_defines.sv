// This document contains the opcode definitions of RISC-V
package jedro_1_defines;

// General defines
localparam int DATA_WIDTH = 32;
localparam int REG_ADDR_WIDTH = $clog2(DATA_WIDTH);

localparam bit [31:0] JEDRO_1_BOOT_ADDR = 32'h8000_0000;


localparam bit [31:0] NOP_INSTR    = 32'b000000000000_00000_000_00000_0010011;
localparam bit [31:0] MRET_INSTR   = 32'b001100000010_00000_000_00000_1110011;
localparam bit [31:0] ECALL_INSTR  = 32'b000000000000_00000_000_00000_1110011;
localparam bit [31:0] EBREAK_INSTR = 32'b000000000001_00000_000_00000_1110011;
localparam bit [31:0] WFI_INSTR    = 32'b000100000101_00000_000_00000_1110011;


// OPCODES for RV32G/RV64G (All are defined but not necessarily implemented)
localparam bit [6:0] OPCODE_LOAD    = 7'b0000011;
localparam bit [6:0] OPCODE_LOADFP  = 7'b0000111;
localparam bit [6:0] OPCODE_CUSTOM0 = 7'b0001011;
localparam bit [6:0] OPCODE_MISCMEM = 7'b0001111;
localparam bit [6:0] OPCODE_OPIMM   = 7'b0010011;
localparam bit [6:0] OPCODE_AUIPC   = 7'b0010111;
localparam bit [6:0] OPCODE_OPIMM32 = 7'b0011011;
localparam bit [6:0] OPCODE_STORE   = 7'b0100011;
localparam bit [6:0] OPCODE_STOREFP = 7'b0100111;
localparam bit [6:0] OPCODE_CUSTOM1 = 7'b0101011;
localparam bit [6:0] OPCODE_AMO     = 7'b0101111;
localparam bit [6:0] OPCODE_OP      = 7'b0110011;
localparam bit [6:0] OPCODE_LUI     = 7'b0110111;
localparam bit [6:0] OPCODE_OP32    = 7'b0111011;
localparam bit [6:0] OPCODE_MADD    = 7'b1000011;
localparam bit [6:0] OPCODE_MSUB    = 7'b1000111;
localparam bit [6:0] OPCODE_NMSUB   = 7'b1001011;
localparam bit [6:0] OPCODE_NMADD   = 7'b1001111;
localparam bit [6:0] OPCODE_OPFP    = 7'b1010011;
localparam bit [6:0] OPCODE_BRANCH  = 7'b1100011;
localparam bit [6:0] OPCODE_JALR    = 7'b1100111;
localparam bit [6:0] OPCODE_JAL     = 7'b1101111;
localparam bit [6:0] OPCODE_SYSTEM  = 7'b1110011;

// ALU defines
localparam int ALU_OP_WIDTH = 4;       // Number of bits used to encode the operator of the ALU operation
localparam bit [3:0] ALU_OP_ADD  = 4'b0000;
localparam bit [3:0] ALU_OP_SUB  = 4'b1000;
localparam bit [3:0] ALU_OP_SLL  = 4'b0001;
localparam bit [3:0] ALU_OP_SLT  = 4'b0010;
localparam bit [3:0] ALU_OP_SLTU = 4'b0011;
localparam bit [3:0] ALU_OP_XOR  = 4'b0100;
localparam bit [3:0] ALU_OP_SRL  = 4'b0101;
localparam bit [3:0] ALU_OP_SRA  = 4'b1101;
localparam bit [3:0] ALU_OP_OR   = 4'b0110;
localparam bit [3:0] ALU_OP_AND  = 4'b0111;

// funct3 defines
localparam bit [2:0] FUNCT3_SHIFT_INSTR = 3'b101;

// Load-Store Unit
// localparam int LSU_CTRL_WIDTH = 4; // we need to encode 8 states 
// localparam bit [3:0] LSU_LOAD_BYTE        = 4'b0000;
// localparam bit [3:0] LSU_LOAD_HALF_WORD   = 4'b0001;
// localparam bit [3:0] LSU_LOAD_WORD        = 4'b0010;
// localparam bit [3:0] LSU_LOAD_BYTE_U      = 4'b0100;
// localparam bit [3:0] LSU_LOAD_HALF_WORD_U = 4'b0101;
// localparam bit [3:0] LSU_STORE_BYTE       = 4'b1000;
// localparam bit [3:0] LSU_STORE_HALF_WORD  = 4'b1001;
// localparam bit [3:0] LSU_STORE_WORD       = 4'b1010;

typedef enum logic [3:0] {
    LSU_LOAD_BYTE,
    LSU_LOAD_HALF_WORD,
    LSU_LOAD_WORD,
    LSU_LOAD_BYTE_U,
    LSU_LOAD_HALF_WORD_U,
    LSU_STORE_BYTE,
    LSU_STORE_HALF_WORD,
    LSU_STORE_WORD
} lsu_ctrl_e;


// CONTROL AND STATUS REGISTERS
localparam bit [29:0] TRAP_VEC_BASE_ADDR = 30'h0010_0000;
localparam bit [1:0] TRAP_VEC_MODE = 2'b00; // direct mode (vectored == 01)
localparam bit [2:0] CSRRW_INSTR_FUNCT3 = 3'b001;
localparam bit [2:0] CSRRWI_INSTR_FUNCT3 = 3'b101;
localparam bit [2:0] CSRRS_INSTR_FUCNT3 = 3'b010;
localparam bit [2:0] CSRRSI_INSTR_FUCNT3 = 3'b110;
localparam int CSR_ADDR_WIDTH = 12;
localparam int CSR_UIMM_WIDTH = 5;
localparam int CSR_WMODE_WIDTH = 2;
localparam bit [1:0] CSR_WMODE_NORMAL = 2'b00;
localparam bit [1:0] CSR_WMODE_SET_BITS = 2'b01;
localparam bit [1:0] CSR_WMODE_CLEAR_BITS = 2'b10;

localparam int CSR_MCAUSE_INSTR_ADDR_MISALIGNED = 0;
localparam int CSR_MCAUSE_ILLEGAL_INSTRUCTION   = 2;
localparam int CSR_MCAUSE_EBREAK                = 3;
localparam int CSR_MCAUSE_LOAD_ADDR_MISALIGNED  = 4;
localparam int CSR_MCAUSE_LOAD_ACCESS_FAULT     = 5;
localparam int CSR_MCAUSE_STORE_ADDR_MISALIGNED = 6;
localparam int CSR_MCAUSE_ECALL_M_MODE          = 11;

// Machine Information Registers
localparam bit [11:0] CSR_ADDR_MVENDORID    = 12'hF11;
localparam bit [31:0] CSR_DEF_VAL_MVENDORID = 32'b0;
localparam bit [11:0] CSR_ADDR_MARCHID      = 12'hF12;
localparam bit [31:0] CSR_DEF_VAL_MARCHID   = 32'b0;
localparam bit [11:0] CSR_ADDR_MIMPID       = 12'hF13;
localparam bit [31:0] CSR_DEF_VAL_MIMPID    = 32'b0;
localparam bit [11:0] CSR_ADDR_MHARTID      = 12'hF14;
localparam bit [31:0] CSR_DEF_VAL_MHARTID   = 32'b0;

// Machine Trap Registers
localparam bit [11:0] CSR_ADDR_MSTATUS    = 12'h300;
localparam int CSR_MSTATUS_BIT_MIE        = 3; // machine interrupt enable
localparam int CSR_MSTATUS_BIT_MPIE       = 7; // previous machine interrupt enable
localparam bit [31:0] CSR_DEF_VAL_MSTATUS = 32'b00000000_0000000_0000000_00000000;
localparam bit [11:0] CSR_ADDR_MISA       = 12'h301;
localparam bit [31:0] CSR_DEF_VAL_MISA    = 32'b01_0000_00000000000000000100000000;

localparam bit [11:0] CSR_ADDR_MTVEC    = 12'h305;
localparam int CSR_MTVEC_BASE_LEN       = 30;
localparam bit [31:0] CSR_DEF_VAL_MTVEC = {TRAP_VEC_BASE_ADDR, TRAP_VEC_MODE};

localparam bit [11:0] CSR_ADDR_MIP    = 12'h344;
localparam int CSR_MIP_BIT_MSIP       = 3; // machine software interrupt pending
localparam int CSR_MIP_BIT_MTIP       = 7; // machine timer interrupt pending
localparam int CSR_MIP_BIT_MEIP       = 11; // machine external interrupt pending
localparam bit [31:0] CSR_DEF_VAL_MIP = 32'b00000000_00000000_00000000_00000000;

localparam bit [11:0] CSR_ADDR_MIE    = 12'h304;
localparam int CSR_MIE_BIT_MSIE       = 3; // machine software interrupt enabled
localparam int CSR_MIE_BIT_MTIE       = 7; // machine timer interrupt enabled
localparam int CSR_MIE_BIT_MEIE       = 11; // machine external interrupt enabled
localparam bit [31:0] CSR_DEF_VAL_MIE = 32'b00000000_00000000_00000000_00000000;

localparam bit [11:0] CSR_ADDR_MSCRATCH    = 12'h340;
localparam bit [31:0] CSR_DEF_VAL_MSCRATCH = 32'b00000000_00000000_00000000_00000000;

localparam bit [11:0] CSR_ADDR_MEPC    = 12'h341;
localparam bit [31:0] CSR_DEF_VAL_MEPC = 32'b00000000_00000000_00000000_00000000;

localparam bit [11:0] CSR_ADDR_MCAUSE    = 12'h342;
localparam bit [31:0] CSR_DEF_VAL_MCAUSE = 32'b00000000_00000000_00000000_00000000;

localparam bit [11:0] CSR_ADDR_MTVAL    = 12'h343;
localparam bit [31:0] CSR_DEF_VAL_MTVAL = 32'b00000000_00000000_00000000_00000000;

endpackage
