// This document contains the opcode definitions of RISC-V
package rvj1_defines;

    // General defines
    parameter int XLEN   = 32;  // width of an integer register (either 32 or 64)
    parameter int NREG   = 32;  // number of integer registers
    parameter int RALEN  = $clog2(NREG); // register address length
    parameter int NBYTES = XLEN / 8;
    parameter int IALIGN = 32;  // instr addr alignment constraint (32 for RV32I, 16 for RV32IC)
    parameter int ILEN   = 32;  // the max instr length supported (multiple of IALIGN, 32 for RV32I)

    parameter logic [XLEN-:0] BOOT_ADDR = 32'h8000_0000;


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
        F7_SLLI_SRLI_ADDI = 7'b0000_000,
        F7_SRAI_SUB       = 7'b0100_000
    } f7_shift_imm_e;

    // Load-Store Unit
    typedef enum logic [3:0] {
        LSU_NO_CMD            = 4'b1111,
        LSU_LOAD_BYTE         = 4'b0000,
        LSU_LOAD_HALF_WORD    = 4'b0001,
        LSU_LOAD_WORD         = 4'b0010,
        LSU_LOAD_BYTE_U       = 4'b0100,
        LSU_LOAD_HALF_WORD_U  = 4'b0101,
        LSU_STORE_BYTE        = 4'b1000,
        LSU_STORE_HALF_WORD   = 4'b1001,
        LSU_STORE_WORD        = 4'b1010
    } lsu_ctrl_e;

    // Branching defines
    typedef enum logic [2:0] {
        BRANCH_EQ   = 3'b000,
        BRANCH_NEQ  = 3'b001,
        BRANCH_LT   = 3'b100,
        BRANCH_GE   = 3'b101,
        BRANCH_LTU  = 3'b110,
        BRANCH_GEU  = 3'b111
    } branch_ctrl_e;


    // CONTROL AND STATUS REGISTERS
    typedef enum logic [1:0] {
        CSRRW  = 2'b01,
        CSRRS  = 2'b10,
        CSRRC  = 2'b11
    } csr_cmd_t;

    parameter logic [11:0] CSR_MVENDORID_ADDR  = 12'hF11;
    parameter logic [11:0] CSR_MARCHID_ADDR    = 12'hF12;
    parameter logic [11:0] CSR_MIMPID_ADDR     = 12'hF13;
    parameter logic [11:0] CSR_MHARTID_ADDR    = 12'hF14;
    parameter logic [11:0] CSR_MCONFIGPTR_ADDR = 12'hF15;

    parameter logic [11:0] CSR_MSTATUS_ADDR    = 12'h300;
    parameter logic [11:0] CSR_MISA_ADDR       = 12'h301;
    parameter logic [11:0] CSR_MEDELEG_ADDR    = 12'h302;
    parameter logic [11:0] CSR_MIDELEG_ADDR    = 12'h303;
    parameter logic [11:0] CSR_MIE_ADDR        = 12'h304;
    parameter logic [11:0] CSR_MTVEC_ADDR      = 12'h305;
    parameter logic [11:0] CSR_MCOUNTEREN_ADDR = 12'h306;
    parameter logic [11:0] CSR_MSTATUSH_ADDR   = 12'h310;
    parameter logic [11:0] CSR_MEDELEG_ADDR    = 12'h312;

    parameter logic [11:0] CSR_MSCRATCH_ADDR   = 12'h340;
    parameter logic [11:0] CSR_MEPC_ADDR       = 12'h341;
    parameter logic [11:0] CSR_MCAUSE_ADDR     = 12'h342;
    parameter logic [11:0] CSR_MTVAL_ADDR      = 12'h343;
    parameter logic [11:0] CSR_MIP_ADDR        = 12'h344;
    parameter logic [11:0] CSR_MTINST_ADDR     = 12'h34A;
    parameter logic [11:0] CSR_MTVAL2_ADDR     = 12'h34B;

    parameter logic [11:0] CSR_MENVCFG_ADDR    = 12'h30A;
    parameter logic [11:0] CSR_MENVCFGH_ADDR   = 12'h31A;
    parameter logic [11:0] CSR_SECCFG_ADDR     = 12'h747;
    parameter logic [11:0] CSR_SECCFGH_ADDR    = 12'h757;

    parameter logic CSR_MISA_MXLEN = 2'b01; // XLEN == 32
    parameter logic [XLEN-1:0] CSR_MISA_VALUE = (
          (0 << 0)   // A - Atomic extension
        | (0 << 1)   // B - Bit Manipulation
        | (0 << 2)   // C - Compressed extension
        | (0 << 3)   // D - Double precison floats
        | (0 << 4)   // E - RV32E/64E base
        | (0 << 5)   // F - Single precision floats
        | (0 << 7)   // H - Hypervison extension
        | (1 << 8)   // I - RV32I/64I base ISA
        | (0 << 12)  // M - Integer Multiply/Divide extension
        | (0 << 16)  // Q - Quad-precison floats
        | (0 << 18)  // S - Supervison mode implemented
        | (0 << 20)  // U - User mode implemented
        | (0 << 23)  // X - Non-standard extensions present
        | (CSR_MISA_MXLEN << 30)
    );
    parameter logic [XLEN-1:0] CSR_MVENDORID_VALUE = '0;
    parameter logic [XLEN-1:0] CSR_MARCHID_VALUE   = '0;
    parameter logic [XLEN-1:0] CSR_MIMPID_VALUE    = '0;
    parameter logic [XLEN-1:0] CSR_MHARTID_VALUE   = '0;
    parameter logic [XLEN-1:0] CSR_MSTATUSH_VALUE  = '0;

    parameter int unsigned CSR_MSTATUS_MIE_BIT     = 3;
    parameter int unsigned CSR_MSTATUS_MPIE_BIT    = 7;

    parameter int unsigned CSR_MIE_MSI_BIT         = 3;
    parameter int unsigned CSR_MIE_MTI_BIT = 00;
endpackage
