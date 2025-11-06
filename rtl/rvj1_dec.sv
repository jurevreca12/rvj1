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
  output logic            control_o, // signals that controls signals have been activated

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
  output logic [RALEN-1:0] lsu_regdest_o,
  output logic             ctrl_jump_o,
  output logic             ctrl_branch_o,
  output branch_ctrl_e     ctrl_branch_type_o,
  output logic             csr_valid_o,
  output logic [11:0]      csr_addr_o,
  output csr_cmd_t         csr_cmd_o
);

/*************************************
* INTERNAL SIGNAL DEFINITION
*************************************/
logic update_output, reset_output;
logic instr_issued;

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
logic             ctrl_jump;
logic             ctrl_branch;
branch_ctrl_e     ctrl_branch_type;

logic ifu_fire;
logic [XLEN-1:0] instr_buff;

logic [XLEN-1:0] imm_i_type;
logic [XLEN-1:0] imm_is_type;
logic [XLEN-1:0] imm_s_type;
logic [XLEN-1:0] imm_b_type;
logic [XLEN-1:0] imm_u_type;
logic [XLEN-1:0] imm_j_type;
logic [XLEN-1:0] imm_c_type; // for CSRs

typedef enum logic {
  eDEC_FIRST_CYCLE,
  eDEC_SECOND_CYCLE
} dec_fsm_e;
dec_fsm_e state, state_next;

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
* Helper functions
*************************************/
function automatic logic is_shift(input f3_imm_e funct3);
    begin
        return (funct3 == F3_SRLI_SRAI) || (funct3 == F3_SRLI_SRAI);
    end
endfunction

function automatic alu_op_e f3_7_to_alu_imm_op(input f3_imm_e funct3, input f7_shift_imm_e funct7);
    begin
        alu_op_e op = ALU_OP_ADD;
        unique case (funct3)
          F3_ADDI:  op = ALU_OP_ADD;
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

function automatic alu_op_e f3_7_to_alu_rr_op(input f3_imm_e funct3, input f7_shift_imm_e funct7);
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

function automatic alu_op_e branch_type_to_alu_op(input branch_ctrl_e funct3);
begin
  alu_op_e op = ALU_OP_ADD;
  unique case (funct3)
    BRANCH_EQ:   op = ALU_OP_XOR;
    BRANCH_NEQ:  op = ALU_OP_XOR;
    BRANCH_LT:   op = ALU_OP_SLT;
    BRANCH_GE:   op = ALU_OP_SLT;
    BRANCH_LTU:  op = ALU_OP_SLTU;
    BRANCH_GEU:  op = ALU_OP_SLTU;
  endcase
  return op;
end
endfunction

function automatic logic is_csr_imm(input logic funct3);
begin
  return funct3[2];
end
endfunction

function automatic logic is_priv_non_csr_instr(
  input logic [4:0]  regs1,
  input logic [4:0]  regdest,
  input logic [2:0]  funct3,
  input logic [11:0] funct12);
  return ((regs1 == 5'b0) &&
          (regdest == 5'b0) &&
          (funct3 == 3'b0) &&
          ((funct12 == 12'b0) || funct12 == 12'b0000_0000_0001));
endfunction

/*************************************
* INSN PARTS and IMMEDIATES
*************************************/
assign instr    = (state == eDEC_FIRST_CYCLE) ? ifu_instr_i : instr_buff;
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
assign imm_c_type  = {27'b0, regs1};

/*************************************
* Instruction issuing
*************************************/
assign ifu_fire      = ifu_ready_o && ifu_valid_i;
assign ifu_ready_o   = ~stall_i && ~(state != eDEC_FIRST_CYCLE);
assign update_output = ifu_fire ||  (state != eDEC_FIRST_CYCLE && ~stall_i);
assign reset_output  = ~rstn_i  || (~update_output && ~stall_i);
always_ff @(posedge clk_i) begin
  if (~rstn_i)
    instr_buff <= 32'h0000_0000;
  else if (ifu_fire)
    instr_buff <= ifu_instr_i;
end

/*************************************
* DECODER - SYNCHRONOUS LOGIC
*************************************/
always_ff @(posedge clk_i) begin
  if (reset_output) begin
    rf_addr_a_o        <= 5'b00000;
    rf_addr_b_o        <= 5'b00000;
    alu_sel_o          <= ALU_OP_ADD;
    rpa_or_pc_o        <= 1'b0;
    rpb_or_imm_o       <= 1'b0;
    alu_write_rf_o     <= 1'b0;
    alu_regdest_o      <= 5'b00000;
    immediate_o        <= 32'h0000_0000;
    lsu_ctrl_valid_o   <= 1'b0;
    lsu_ctrl_o         <= LSU_NO_CMD;
    lsu_regdest_o      <= 5'b00000;
    ctrl_jump_o        <= 1'b0;
    ctrl_branch_o      <= 1'b0;
    ctrl_branch_type_o <= BRANCH_EQ;
    state              <= eDEC_FIRST_CYCLE;
    instr_issued_o     <= 1'b0;
    control_o          <= 1'b0;
  end
  else if (update_output) begin
    rf_addr_a_o        <= rf_addr_a;
    rf_addr_b_o        <= rf_addr_b;
    alu_sel_o          <= alu_sel;
    rpa_or_pc_o        <= rpa_or_pc;
    rpb_or_imm_o       <= rpb_or_imm;
    alu_write_rf_o     <= alu_write_rf;
    alu_regdest_o      <= alu_regdest;
    immediate_o        <= immediate;
    lsu_ctrl_valid_o   <= lsu_ctrl_valid;
    lsu_ctrl_o         <= lsu_ctrl;
    lsu_regdest_o      <= lsu_regdest;
    ctrl_jump_o        <= ctrl_jump;
    ctrl_branch_o      <= ctrl_branch;
    ctrl_branch_type_o <= ctrl_branch_type;
    state              <= state_next;
    instr_issued_o     <= instr_issued;
    control_o          <= 1'b1;
  end
end


/*************************************
* DECODER - COMBINATIONAL LOGIC
*************************************/
always_comb
begin
  rf_addr_a        = 5'b00000;
  rf_addr_b        = 5'b00000;
  alu_sel          = ALU_OP_ADD;
  rpa_or_pc        = 1'b0;
  rpb_or_imm       = 1'b0;
  alu_write_rf     = 1'b0;
  alu_regdest      = 5'b00000;
  immediate        = 32'h0000_0000;
  lsu_ctrl_valid   = 1'b0;
  lsu_ctrl         = LSU_NO_CMD;
  lsu_regdest      = 5'b00000;
  ctrl_jump        = 1'b0;
  ctrl_branch      = 1'b0;
  ctrl_branch_type = BRANCH_EQ;
  state_next       = eDEC_FIRST_CYCLE;
  instr_issued     = 1'b1; // Most instructions are single-cycle
  case (opcode)
    OPCODE_OPIMM: begin
      rf_addr_a    = regs1;
      alu_sel      = f3_7_to_alu_imm_op(f3_imm_e'(funct3), f7_shift_imm_e'(funct7));
      rpb_or_imm   = 1'b1;
      alu_write_rf = 1'b1;
      alu_regdest  = regdest;
      immediate    = imm_i_type;
    end

    OPCODE_OP: begin
      rf_addr_a    = regs1;
      rf_addr_b    = regs2;
      alu_sel      = f3_7_to_alu_rr_op(f3_imm_e'(funct3), f7_shift_imm_e'(funct7));
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
      rf_addr_b      = regs2;
      lsu_ctrl_valid = 1'b1;
      lsu_ctrl       = f3_to_lsu_ctrl(funct3, 1'b1);
    end

    OPCODE_LOAD: begin
      rpb_or_imm     = 1'b1;
      immediate      = imm_i_type;
      rf_addr_a      = regs1;
      lsu_ctrl_valid = 1'b1;
      lsu_ctrl       = f3_to_lsu_ctrl(funct3, 1'b0);
      lsu_regdest    = regdest;
    end

    OPCODE_JAL: begin
      rpa_or_pc    = 1'b1;
      rpb_or_imm   = 1'b1;
      immediate    = imm_j_type;
      alu_regdest  = regdest;
      ctrl_jump    = 1'b1;
    end

    OPCODE_JALR: begin
      rpb_or_imm   = 1'b1;
      immediate    = imm_i_type;
      alu_regdest  = regdest;
      rf_addr_a    = regs1;
      ctrl_jump    = 1'b1;
    end

    OPCODE_BRANCH: begin
      unique case (state)
        // First cycle calculates condition
        eDEC_FIRST_CYCLE: begin
          rf_addr_a        = regs1;
          rf_addr_b        = regs2;
          alu_sel          = branch_type_to_alu_op( branch_ctrl_e'(funct3));
          ctrl_branch      = 1'b1;
          ctrl_branch_type = branch_ctrl_e'(funct3);
          state_next       = eDEC_SECOND_CYCLE;
          instr_issued     = 1'b0;
        end
        // Jump if condition is met
        eDEC_SECOND_CYCLE: begin
          rpa_or_pc    = 1'b1;
          rpb_or_imm   = 1'b1;
          immediate    = imm_b_type;
        end
      endcase
    end

    OPCODE_SYSTEM: begin
      csr_valid_o = 1'b1;
      csr_addr_o  = funct12;
      csr_cmd_o   = csr_cmd_t'(funct3[1:0]);
      alu_regdest = regdest;
      // if (is_priv_non_csr_instr(regs1, regdest, funct3, funct12)) begin
      //   if (funct12 == '0) begin

      //   end
      //   else if (funct12 == 12'b0000_0000_0001) begin

      //   end // TODO: add else decode error
      // end
      // else
      if (is_csr_imm(funct3)) begin
        rpb_or_imm = 1'b1;
        immediate  = imm_c_type;
      end
      else begin
        rf_addr_a = regs1;
      end
    end
  endcase
end

endmodule
