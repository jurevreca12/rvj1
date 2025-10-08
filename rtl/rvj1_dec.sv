////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_dec                                                   //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    Decoder for the RV32I instructions.                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import rvj1_defines::*;

module rvj1_dec
(
  input logic clk_i,
  input logic rstn_i,

  input  logic [XLEN-1:0] ifu_instr_i,        // Instructions coming in from memory/cache
  input  logic            ifu_valid_i,
  output logic            ifu_ready_o,       // Ready for instructions.

  input  logic            stall_i,
  output logic            instr_issued_o,

  // OUTGOING CONTROL SIGNALS
  output logic [RALEN-1:0] rf_addr_a_o,
  output logic [RALEN-1:0] rf_addr_b_o,
  output alu_op_e          alu_sel_o,    // Select operation ALU should perform.
  output logic             rpa_or_pc_o,
  output logic             rpb_or_imm_o,
  output logic             alu_write_rf_o,
  output logic [RALEN-1:0] alu_regdest_o,
  output logic [XLEN-1:0]  immediate_o,  // Sign extended immediate.
  output logic             lsu_ctrl_valid_o,
  output lsu_ctrl_e        lsu_ctrl_o,
  output logic [RALEN-1:0] lsu_regdest_o
);

/*************************************
* INTERNAL SIGNAL DEFINITION
*************************************/
logic [RALEN-1:0] rf_addr_a;
logic [RALEN-1:0] rf_addr_b;
alu_op_e          alu_sel;
logic             rpa_or_pc;
logic             rpb_or_imm;
logic             alu_write_rf;
logic [RALEN-1:0] alu_regdest;
logic [XLEN-1:0]  immediate;
logic             lsu_ctrl_valid;
lsu_ctrl_e        lsu_ctrl;
logic [RALEN-1:0] lsu_regdest;

logic ifu_fire;

logic [XLEN-1:0] imm_i_type;
logic [XLEN-1:0] imm_is_type;
logic [XLEN-1:0] imm_s_type;
logic [XLEN-1:0] imm_b_type;
logic [XLEN-1:0] imm_u_type;
logic [XLEN-1:0] imm_j_type;


// Helpfull shorthands for sections of the instruction (see riscv specifications)
logic [31:0]  instr;
logic [6:0]   opcode;
logic [11:7]  regdest;
logic [11:7]  imm4_0;
logic [31:25] imm11_5;
logic [31:12] imm31_12; // U-type immediate
logic [31:20] imm11_0; // I-type immediate
logic [14:12] funct3;
logic [19:15] regs1;
logic [24:20] regs2;
logic [31:25] funct7;

/*************************************
* INSN PARTS and IMMEDIATES
*************************************/
assign instr    = ifu_instr_i; // shorthand
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

assign imm_i_type  = {{20{imm11_0[31]}}, imm11_0};
assign imm_s_type  = {{20{imm11_5[31]}}, imm11_5, imm4_0};
assign imm_b_type  = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
assign imm_u_type  = {imm31_12, 12'b0};
assign imm_j_type  = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};

/*************************************
* Helper functions
*************************************/
function automatic logic is_shift(input f3_imm_e funct3);
    begin
        return (funct3 == F3_SRLI_SRAI) || (funct3 == F3_SRLI_SRAI);
    end
endfunction

function automatic alu_op_e f3_7_to_alu_op(input f3_imm_e funct3, input f7_shift_imm_e funct7);
    begin
        alu_op_e op = ALU_OP_ADD;
        unique case (funct3)
          F3_ADDI: begin
            case (funct7)
               F7_SLLI_SRLI_ADDI: op = ALU_OP_ADD;
               F7_SRAI_SUB:       op = ALU_OP_SUB;
            endcase
          end
          F3_SLTI:  op = ALU_OP_SLT;
          F3_SLTIU: op = ALU_OP_SLTU;
          F3_XORI:  op = ALU_OP_XOR;
          F3_ORI:   op = ALU_OP_OR;
          F3_ANDI:  op = ALU_OP_AND;
          F3_SLLI: begin
            case (funct7)
              F7_SLLI_SRLI_ADDI: op = ALU_OP_SLL;
            endcase
          end
          F3_SRLI_SRAI: begin
            case (funct7)
              F7_SLLI_SRLI_ADDI: op = ALU_OP_SRL;
              F7_SRAI_SUB:       op = ALU_OP_SRA; // TODO add error for invalid encodings
            endcase
          end
        endcase
        return op;
    end
endfunction

function automatic lsu_ctrl_e f3_to_lsu_ctrl(input logic [2:0] funct3, input logic is_write);
begin
  return lsu_ctrl_e'({is_write, funct3});
end
endfunction
/*************************************
* Instruction issued logic
*************************************/
assign ifu_fire = ifu_ready_o && ifu_valid_i;
always_ff @(posedge clk_i) begin
  if (~rstn_i)
    instr_issued_o <= 1'b0;
  else
    instr_issued_o <= ifu_fire;
end

/*************************************
* DECODER - SYNCHRONOUS LOGIC
*************************************/
always_ff @(posedge clk_i) begin
  if (~rstn_i) begin
    rf_addr_a_o      <= 5'b00000;
    rf_addr_b_o      <= 5'b00000;
    alu_sel_o        <= ALU_OP_ADD;
    rpa_or_pc_o      <= 1'b0;
    rpb_or_imm_o     <= 1'b0;
    alu_write_rf_o   <= 1'b0;
    alu_regdest_o    <= 5'b00000;
    immediate_o      <= 32'h0000_0000;
    lsu_ctrl_valid_o <= 1'b0;
    lsu_ctrl_o       <= LSU_NO_CMD;
    lsu_regdest_o    <= 5'b00000;
  end
  else if (ifu_fire) begin
    rf_addr_a_o      <= rf_addr_a;
    rf_addr_b_o      <= rf_addr_b;
    alu_sel_o        <= alu_sel;
    rpa_or_pc_o      <= rpa_or_pc;
    rpb_or_imm_o     <= rpb_or_imm;
    alu_write_rf_o   <= alu_write_rf;
    alu_regdest_o    <= alu_regdest;
    immediate_o      <= immediate;
    lsu_ctrl_valid_o <= lsu_ctrl_valid;
    lsu_ctrl_o       <= lsu_ctrl;
    lsu_regdest_o    <= lsu_regdest;
  end
  else if (~stall_i) begin
    rf_addr_a_o      <= 5'b00000;
    rf_addr_b_o      <= 5'b00000;
    alu_sel_o        <= ALU_OP_ADD;
    rpa_or_pc_o      <= 1'b0;
    rpb_or_imm_o     <= 1'b0;
    alu_write_rf_o   <= 1'b0;
    alu_regdest_o    <= 5'b00000;
    immediate_o      <= 32'h0000_0000;
    lsu_ctrl_valid_o <= 1'b0;
    lsu_ctrl_o       <= LSU_NO_CMD;
    lsu_regdest_o    <= 5'b00000;
  end
end

assign ifu_ready_o = ~stall_i;

/*************************************
* DECODER - COMBINATIONAL LOGIC
*************************************/
always_comb
begin
  rf_addr_a      = 5'b00000;
  rf_addr_b      = 5'b00000;
  alu_sel        = ALU_OP_ADD;
  rpa_or_pc      = 1'b0;
  rpb_or_imm     = 1'b0;
  alu_write_rf   = 1'b0;
  alu_regdest    = 5'b00000;
  immediate      = 32'h0000_0000;
  lsu_ctrl_valid = 1'b0;
  lsu_ctrl       = LSU_NO_CMD;
  lsu_regdest    = 5'b00000;
  case (opcode)
    OPCODE_OPIMM: begin
      rf_addr_a    = regs1;
      alu_sel      = f3_7_to_alu_op(f3_imm_e'(funct3), f7_shift_imm_e'(funct7));
      rpb_or_imm   = 1'b1;
      alu_write_rf = 1'b1;
      alu_regdest  = regdest;
      immediate    = imm_i_type;
    end

    OPCODE_OP: begin
      rf_addr_a    = regs1;
      rf_addr_b    = regs2;
      alu_sel      = f3_7_to_alu_op(f3_imm_e'(funct3), f7_shift_imm_e'(funct7));
      alu_write_rf = 1'b1;
      alu_regdest  = regdest;
    end

    OPCODE_LUI: begin
      rpb_or_imm   = 1'b1;
      alu_write_rf = 1'b1;
      alu_regdest  = regdest;
      immediate    = imm_u_type;
    end

    OPCODE_AUIPC: begin
      rpa_or_pc    = 1'b1;
      rpb_or_imm   = 1'b1;
      alu_write_rf = 1'b1;
      alu_regdest  = regdest;
      immediate    = imm_u_type;
    end

    OPCODE_STORE: begin
      rpb_or_imm     = 1'b1;
      immediate      = imm_s_type;
      rf_addr_a      = regs1;
      lsu_ctrl_valid = 1'b1;
      lsu_ctrl       = f3_to_lsu_ctrl(funct3, 1'b1);
      lsu_regdest    = regs2;
    end

    OPCODE_LOAD: begin
      rpb_or_imm     = 1'b1;
      immediate      = imm_i_type;
      lsu_ctrl_valid = 1'b1;
      lsu_ctrl       = f3_to_lsu_ctrl(funct3, 1'b0);
      lsu_regdest    = regdest;
    end
  endcase
end

endmodule
