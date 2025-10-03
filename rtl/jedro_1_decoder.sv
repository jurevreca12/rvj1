////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_decoder                                            //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    Decoder for the RV32I instructions.                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import jedro_1_defines::*;

module jedro_1_decoder
(
  input logic clk_i,
  input logic rstn_i,

  // IFU INTERFACE
  input  logic [DATA_WIDTH-1:0] ifu_instr_i,        // Instructions coming in from memory/cache
  input  logic [DATA_WIDTH-1:0] ifu_addr_i,
  input  logic                  ifu_valid_i,
  output logic                  ifu_ready_o,       // Ready for instructions.


  output logic [DATA_WIDTH-1:0] instr_addr_o,
  output logic                  use_pc_o,

  output logic                  jmp_instr_o,
  output logic [DATA_WIDTH-1:0] jmp_addr_o,
  output logic                  use_alu_jmp_addr_o,

  // REGISTER FILE INTERFACE
  output logic [REG_ADDR_WIDTH-1:0] rf_addr_a_o,
  output logic [REG_ADDR_WIDTH-1:0] rf_addr_b_o,
  output logic [REG_ADDR_WIDTH-1:0] rf_dest_addr_o,
  output logic                      rf_wb_o,     // Writeback to the register?

  // ALU INTERFACE
  output alu_op_e               alu_sel_o,    // Select operation ALU should perform.

  output logic                  mux1_use_pc_o,
  output logic                  mux2_use_imm_o,
  output logic                  mux3_alu_or_lsu_o,

  output logic [DATA_WIDTH-1:0] mux2_immediate_o,  // Sign extended immediate.

  // LSU INTERFACE
  output logic                      lsu_ctrl_valid_o,
  output logic [LSU_CTRL_WIDTH-1:0] lsu_ctrl_o,
  output logic [REG_ADDR_WIDTH-1:0] lsu_regdest_o
);

/*************************************
* INTERNAL SIGNAL DEFINITION
*************************************/
logic                       use_alu_jmp_addr;
logic                       use_pc;
logic                       is_imm;

logic                       alu_is_write;
alu_op_e                    alu_sel;
logic [REG_ADDR_WIDTH-1:0]  alu_dest_addr;
logic                       alu_wb;

logic                       illegal_instr;
logic                       ecall;
logic                       ebreak;

logic [REG_ADDR_WIDTH-1:0]  rf_addr_a;
logic [REG_ADDR_WIDTH-1:0]  rf_addr_b;

logic [DATA_WIDTH-1:0]      imm_ext;

logic                       lsu_ctrl_valid;
logic [3:0]                 lsu_ctrl;
logic [REG_ADDR_WIDTH-1:0]  lsu_regdest;

logic                       ready;
logic                       jmp_instr;
logic [DATA_WIDTH-1:0]      jmp_addr;

logic [CSR_ADDR_WIDTH-1:0]  csr_addr;
logic                       csr_we;
logic [DATA_WIDTH-1:0]      csr_temp_r;
logic [CSR_UIMM_WIDTH-1:0]  csr_uimm_data;
logic                       csr_uimm_we;
logic [CSR_WMODE_WIDTH-1:0] csr_wmode;
logic                       csr_mret;

logic [DATA_WIDTH-1:0]      jmp_addr_save_r;

logic [DATA_WIDTH-1:0] imm_i_type;
logic [DATA_WIDTH-1:0] imm_s_type;
logic [DATA_WIDTH-1:0] imm_b_type;
logic [DATA_WIDTH-1:0] imm_u_type;
logic [DATA_WIDTH-1:0] imm_j_type;

// For generating stalling logic
logic [REG_ADDR_WIDTH-1:0] prev_dest_addr;

// Helpfull shorthands for sections of the instruction (see riscv specifications)
logic [6:0]   opcode;
logic [11:7]  regdest;
logic [11:7]  imm4_0;
logic [31:12] imm31_12; // U-type immediate
logic [31:20] imm11_0; // I-type immediate
logic [14:12] funct3;
logic [19:15] regs1;
logic [24:20] regs2;
logic [31:25] funct7;


/*************************************
* INSN PARTS and IMMEDIATES
*************************************/
assign instr = ifu_instr_i; // shorthand
assign opcode   = instr[6:0];
assign regdest  = instr[11:7];
assign imm11_0  = instr[31:20]; // I-type immediate
assign imm4_0   = instr[11:7];  // S-type part 1
assign imm11_5  = instr[31:25]; // S-type part 2
assign imm31_12 = instr[31:12]; // U-type immediate
assign funct3   = instr[14:12];
assign regs1    = instr[19:15];
assign regs2    = instr[24:20];
assign funct7   = instr[31:25];

assign imm_i_type = {{20{imm11_0[31]}}, imm11_0};
assign imm_s_type = {{20{imm11_5[31]}}, imm11_5, imm4_0};
assign imm_b_type = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
assign imm_u_type = {imm31_12, 12'b0};
assign imm_j_type = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};

/*************************************
* Helper functions
*************************************/
function automatic logic is_shift(input f3_imm_e funct3);
    begin
        return (funct3 == f3_imm_e.F3_SRLI_SRAI) || (funct3 == f3_imm_e.F3_SRLI_SRAI);
    end
endfunction

function automatic alu_op_e f3_7_to_alu_op(input f3_imm_e funct3, input f7_shift_imm_e funct7);
    begin
        alu_op_e op = alu_op_e.ALU_OP_ADD;
        unique case ({funct3, funct7})
            {f3_imm_e.F3_ADDI,      7'b???_????}: op = alu_op_e.ALU_OP_ADD;
            {f3_imm_e.F3_SLTI,      7'b???_????}: op = alu_op_e.ALU_OP_SLT;
            {f3_imm_e.F3_SLTIU,     7'b???_????}: op = alu_op_e.ALU_OP_SLTU;
            {f3_imm_e.F3_XORI,      7'b???_????}: op = alu_op_e.ALU_OP_XOR;
            {f3_imm_e.F3_ORI,       7'b???_????}: op = alu_op_e.ALU_OP_OR;
            {f3_imm_e.F3_ANDI,      7'b???_????}: op = alu_op_e.ALU_OP_AND;
            {f3_imm_e.F3_SLLI,      7'b000_0000}: op = alu_op_e.ALU_OP_SLL;
            {f3_imm_e.F3_SRLI_SRAI, 7'b000_0000}: op = alu_op_e.ALU_OP_SRL;
            {f3_imm_e.F3_SRLI_SRAI, 7'b010_0000}: op = alu_op_e.ALU_OP_SRA;
        endcase
        return op;
    end
endfunction

/*************************************
* BUFFER INSTR ADDR
*************************************/
register#(
    .WORD_WIDTH  (DATA_WIDTH),
    .RESET_VALUE (0)
) instr_addr_buff (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (1'b1),
    .in   (ifu_addr_i),
    .out  (instr_addr_o)
);


/*************************************
* DECODER - SYNCHRONOUS LOGIC
*************************************/
always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    use_alu_jmp_addr_o <= 0;
    use_pc_o <= 0;
    illegal_instr_o <= 0;
    ecall_o <= 0;
    ebreak_o <= 0;
    alu_is_write_o <= 1'b1;
    alu_sel_o <= 0;
    alu_dest_addr_o <= 0;
    alu_wb_o <= 0;
    rf_addr_a_o <= 0;
    rf_addr_b_o <= 0;
    is_imm_o <= 0;
    imm_ext_o <= 0;
    lsu_ctrl_valid_o <= 0;
    lsu_ctrl_o <= 0;
    lsu_regdest_o <= 0;
    ready_o <= 1'b1;
    jmp_instr_o <= 1'b0;
    jmp_addr_o <= 0;
    csr_addr_o <= 0;
    csr_uimm_data_o <= 0;
    csr_we_o <= 0;
    csr_uimm_we_o <= 0;
    csr_wmode_o <= 0;
    csr_mret_o <= 0;
  end
  else if (ifu_valid_i && ifu_ready_o) begin
    use_alu_jmp_addr_o <= use_alu_jmp_addr;
    use_pc_o <= use_pc;
    illegal_instr_o <= illegal_instr;
    ecall_o <= ecall;
    ebreak_o <= ebreak;
    alu_is_write_o <= alu_is_write;
    alu_sel_o <= alu_sel;
    alu_dest_addr_o <= alu_dest_addr;
    alu_wb_o <= alu_wb;
    rf_addr_a_o <= rf_addr_a;
    rf_addr_b_o <= rf_addr_b;
    is_imm_o <= is_imm;
    imm_ext_o <= imm_ext;
    lsu_ctrl_valid_o <= lsu_ctrl_valid;
    lsu_ctrl_o <= lsu_ctrl;
    lsu_regdest_o <= lsu_regdest;
    ready_o <= ready;
    jmp_instr_o <= jmp_instr;
    jmp_addr_o <= jmp_addr;
    csr_addr_o <= csr_addr;
    csr_uimm_data_o <= csr_uimm_data;
    csr_we_o <= csr_we;
    csr_uimm_we_o <= csr_uimm_we;
    csr_wmode_o <= csr_wmode;
    csr_mret_o <= csr_mret;
  end
end


/*************************************
* DECODER - COMBINATIONAL LOGIC
*************************************/
always_comb
begin
  use_alu_jmp_addr  = 1'b0;
  use_pc            = 1'b0;
  illegal_instr     = 1'b0;
  ecall             = 1'b0;
  ebreak            = 1'b0;
  alu_is_write      = 1'b0;
  alu_sel           = 4'b0000;
  is_imm            = 1'b0;
  alu_dest_addr     = 5'b0;
  alu_wb            = 1'b0;
  rf_addr_a         = 5'b00000;
  rf_addr_b         = 5'b00000;
  imm_ext           = 0;
  lsu_ctrl_valid    = 1'b0;
  lsu_ctrl          = 4'b0000;
  lsu_regdest       = 5'b00000;
  ready             = 1'b1;
  jmp_instr         = 1'b0;
  jmp_addr          = 0;
  csr_addr          = 0;
  csr_we            = 0;
  csr_uimm_data     = 0;
  csr_uimm_we       = 0;
  csr_wmode         = CSR_WMODE_NORMAL;
  csr_mret          = 0;

  unique case (opcode)
    opcode_e.OPCODE_OPIMM: begin
        alu_is_write  = 1'b1;
        is_imm        = 1'b1;
        alu_dest_addr = regdest;
        rf_addr_a     = regs1;
        imm_ext       = is_shift(funct3) ? imm_s_type : imm_i_type;
        alu_sel       = f3_7_to_alu_op(funct3, funct7);
        alu_wb        = 1'b1;
    end
  endcase
end

endmodule // jedro_1_decoder
