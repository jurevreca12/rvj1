// This document contains the opcode definitions of RISC-V
package jedro_1_defines;

    // General defines
    parameter int XLEN   = 32;  // width of an integer register (either 32 or 64)
    parameter int NREG   = 32;  // number of integer registers
    parameter int RALEN  = $clog2(NREG); // register address length
    parameter int NBYTES = XLEN / 8;
    parameter int IALIGN = 32;  // instr addr alignment constraint (32 for RV32I, 16 for RV32IC)
    parameter int ILEN   = 32;  // the max instr length supported (multiple of IALIGN, 32 for RV32I)

    parameter logic [31:0] BOOT_ADDR = 32'h8000_0000;


    // OPCODES for RV32G/RV64G (all are defined but not necessarily implemented)
    parameter int OPCODE_WIDTH = 7;
    typedef enum logic [OPCODE_WIDTH-1:0] {
        OPCODE_LOAD    = 7'b0000011,
        OPCODE_LOADFP  = 7'b0000111,
        OPCODE_CUSTOM0 = 7'b0001011,
        OPCODE_MISCMEM = 7'b0001111,
        OPCODE_OPIMM   = 7'b0010011,
        OPCODE_AUIPC   = 7'b0010111,
        OPCODE_OPIMM32 = 7'b0011011,
        OPCODE_STORE   = 7'b0100011,
        OPCODE_STOREFP = 7'b0100111,
        OPCODE_CUSTOM1 = 7'b0101011,
        OPCODE_AMO     = 7'b0101111,
        OPCODE_OP      = 7'b0110011,
        OPCODE_LUI     = 7'b0110111,
        OPCODE_OP32    = 7'b0111011,
        OPCODE_MADD    = 7'b1000011,
        OPCODE_MSUB    = 7'b1000111,
        OPCODE_NMSUB   = 7'b1001011,
        OPCODE_NMADD   = 7'b1001111,
        OPCODE_OPFP    = 7'b1010011,
        OPCODE_BRANCH  = 7'b1100011,
        OPCODE_JALR    = 7'b1100111,
        OPCODE_JAL     = 7'b1101111,
        OPCODE_SYSTEM  = 7'b1110011
    } opcode_e;

    // ALU defines
    parameter int ALU_OP_WIDTH = 4;
    typedef enum logic [ALU_OP_WIDTH-1:0] {
        ALU_OP_ADD  = 4'b0000,
        ALU_OP_SUB  = 4'b1000,
        ALU_OP_SLL  = 4'b0001,
        ALU_OP_SLT  = 4'b0010,
        ALU_OP_SLTU = 4'b0011,
        ALU_OP_XOR  = 4'b0100,
        ALU_OP_SRL  = 4'b0101,
        ALU_OP_SRA  = 4'b1101,
        ALU_OP_OR   = 4'b0110,
        ALU_OP_AND  = 4'b0111
    } alu_op_e;

    // funct3 defines
    typedef enum logic [2:0] {
        F3_ADDI       = 3'b000,
        F3_SLTI       = 3'b010,
        F3_SLTIU      = 3'b011,
        F3_XORI       = 3'b100,
        F3_ORI        = 3'b110,
        F3_ANDI       = 3'b111,
        F3_SLLI       = 3'b001,
        F3_SRLI_SRAI  = 3'b101
    } f3_imm_e;

    typedef enum logic [6:0] {
        F7_SLLI_SRLI = 7'b0000_000,
        F7_SRAI      = 7'b0100_000
    } f7_shift_imm_e;

    // Load-Store Unit
    typedef enum logic [4:0] {
        LSU_NO_CMD            = 5'b00000,
        LSU_LOAD_BYTE         = 5'b00001,
        LSU_LOAD_HALF_WORD    = 5'b00011,
        LSU_LOAD_WORD         = 5'b00111,
        LSU_LOAD_BYTE_U       = 5'b01001,
        LSU_LOAD_HALF_WORD_U  = 5'b01011,
        LSU_STORE_BYTE        = 5'b10001,
        LSU_STORE_HALF_WORD   = 5'b10011,
        LSU_STORE_WORD        = 5'b10111
    } lsu_ctrl_e;


    // CONTROL AND STATUS REGISTERS
    parameter logic [29:0] TRAP_VEC_BASE_ADDR = 30'h0010_0000;
    parameter logic [1:0] TRAP_VEC_MODE = 2'b00; // direct mode (vectored == 01)
    parameter logic [2:0] CSRRW_INSTR_FUNCT3 = 3'b001;
    parameter logic [2:0] CSRRWI_INSTR_FUNCT3 = 3'b101;
    parameter logic [2:0] CSRRS_INSTR_FUCNT3 = 3'b010;
    parameter logic [2:0] CSRRSI_INSTR_FUCNT3 = 3'b110;
    parameter int CSR_ADDR_WIDTH = 12;
    parameter int CSR_UIMM_WIDTH = 5;
    parameter int CSR_WMODE_WIDTH = 2;
    parameter logic [1:0] CSR_WMODE_NORMAL = 2'b00;
    parameter logic [1:0] CSR_WMODE_SET_BITS = 2'b01;
    parameter logic [1:0] CSR_WMODE_CLEAR_BITS = 2'b10;

    parameter int CSR_MCAUSE_INSTR_ADDR_MISALIGNED = 0;
    parameter int CSR_MCAUSE_ILLEGAL_INSTRUCTION   = 2;
    parameter int CSR_MCAUSE_EBREAK                = 3;
    parameter int CSR_MCAUSE_LOAD_ADDR_MISALIGNED  = 4;
    parameter int CSR_MCAUSE_LOAD_ACCESS_FAULT     = 5;
    parameter int CSR_MCAUSE_STORE_ADDR_MISALIGNED = 6;
    parameter int CSR_MCAUSE_ECALL_M_MODE          = 11;

    // Machine Information Registers
    parameter logic [11:0] CSR_ADDR_MVENDORID    = 12'hF11;
    parameter logic [31:0] CSR_DEF_VAL_MVENDORID = 32'b0;
    parameter logic [11:0] CSR_ADDR_MARCHID      = 12'hF12;
    parameter logic [31:0] CSR_DEF_VAL_MARCHID   = 32'b0;
    parameter logic [11:0] CSR_ADDR_MIMPID       = 12'hF13;
    parameter logic [31:0] CSR_DEF_VAL_MIMPID    = 32'b0;
    parameter logic [11:0] CSR_ADDR_MHARTID      = 12'hF14;
    parameter logic [31:0] CSR_DEF_VAL_MHARTID   = 32'b0;

    // Machine Trap Registers
    parameter logic [11:0] CSR_ADDR_MSTATUS    = 12'h300;
    parameter int CSR_MSTATUS_BIT_MIE        = 3; // machine interrupt enable
    parameter int CSR_MSTATUS_BIT_MPIE       = 7; // previous machine interrupt enable
    parameter logic [31:0] CSR_DEF_VAL_MSTATUS = 32'b00000000_0000000_0000000_00000000;
    parameter logic [11:0] CSR_ADDR_MISA       = 12'h301;
    parameter logic [31:0] CSR_DEF_VAL_MISA    = 32'b01_0000_00000000000000000100000000;

    parameter logic [11:0] CSR_ADDR_MTVEC    = 12'h305;
    parameter int CSR_MTVEC_BASE_LEN       = 30;
    parameter logic [31:0] CSR_DEF_VAL_MTVEC = {TRAP_VEC_BASE_ADDR, TRAP_VEC_MODE};

    parameter logic [11:0] CSR_ADDR_MIP    = 12'h344;
    parameter int CSR_MIP_BIT_MSIP       = 3; // machine software interrupt pending
    parameter int CSR_MIP_BIT_MTIP       = 7; // machine timer interrupt pending
    parameter int CSR_MIP_BIT_MEIP       = 11; // machine external interrupt pending
    parameter logic [31:0] CSR_DEF_VAL_MIP = 32'b00000000_00000000_00000000_00000000;

    parameter logic [11:0] CSR_ADDR_MIE    = 12'h304;
    parameter int CSR_MIE_BIT_MSIE       = 3; // machine software interrupt enabled
    parameter int CSR_MIE_BIT_MTIE       = 7; // machine timer interrupt enabled
    parameter int CSR_MIE_BIT_MEIE       = 11; // machine external interrupt enabled
    parameter logic [31:0] CSR_DEF_VAL_MIE = 32'b00000000_00000000_00000000_00000000;

    parameter logic [11:0] CSR_ADDR_MSCRATCH    = 12'h340;
    parameter logic [31:0] CSR_DEF_VAL_MSCRATCH = 32'b00000000_00000000_00000000_00000000;

    parameter logic [11:0] CSR_ADDR_MEPC    = 12'h341;
    parameter logic [31:0] CSR_DEF_VAL_MEPC = 32'b00000000_00000000_00000000_00000000;

    parameter logic [11:0] CSR_ADDR_MCAUSE    = 12'h342;
    parameter logic [31:0] CSR_DEF_VAL_MCAUSE = 32'b00000000_00000000_00000000_00000000;

    parameter logic [11:0] CSR_ADDR_MTVAL    = 12'h343;
    parameter logic [31:0] CSR_DEF_VAL_MTVAL = 32'b00000000_00000000_00000000_00000000;

endpackage
