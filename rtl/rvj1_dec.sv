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

/* verilator lint_off IMPORTSTAR */
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
  output logic            instr_will_retire_o,
  output logic            control_o, // signals that controls signals have been activated
  output logic            illegal_instr_o,

  `ifdef RVFI
  output logic [XLEN-1:0] instr_exec_o, // the word of the instruction currently being executed
  `endif

  // OUTGOING CONTROL SIGNALS
  output logic [RALEN-1:0] rf_addr_a_o,
  output logic [RALEN-1:0] rf_addr_b_o,
  output alu_op_e          alu_sel_o,    // Select operation ALU should perform.
  output logic             rpa_or_pc_o,
  output logic             rpb_or_imm_o,
  output logic             alu_write_rf_o,
  output logic [RALEN-1:0] regdest_o,
  output logic [XLEN-1:0]  immediate_o,  // Sign extended immediate.
  output logic             lsu_ctrl_valid_o,
  output lsu_ctrl_e        lsu_ctrl_o,
  output logic             ctrl_jump_o,
  output logic             ctrl_branch_o,
  output branch_ctrl_e     ctrl_branch_type_o,
  output logic             csr_valid_o,
  output logic [11:0]      csr_addr_o,
  output csr_cmd_t         csr_cmd_o,
  output logic             ecall_insn_o,
  output logic             mret_insn_o,
  output logic             ebreak_insn_o
);

/*************************************
* INTERNAL SIGNAL DEFINITION
*************************************/
logic update_output;
logic reset_output;
logic instr_issued;
logic instr_will_retire;
logic illegal_instr;

logic [RALEN-1:0] rf_addr_a;
logic [RALEN-1:0] rf_addr_b;
logic [RALEN-1:0] regdest2; // should be zero when regdest not present
alu_op_e          alu_sel;
logic             rpa_or_pc;
logic             rpb_or_imm;
logic             alu_write_rf;
logic [XLEN-1:0]  immediate;
logic             lsu_ctrl_valid;
lsu_ctrl_e        lsu_ctrl;
logic             ctrl_jump;
logic             ctrl_branch;
branch_ctrl_e     ctrl_branch_type;
logic             csr_valid;
csr_cmd_t         csr_cmd;
logic             ecall_insn;
logic             mret_insn;
logic             ebreak_insn;

logic ifu_fire;
logic [XLEN-1:0] instr_buff;

logic [XLEN-1:0] imm_i_type;
logic [XLEN-1:0] imm_s_type;
logic [XLEN-1:0] imm_b_type;
logic [XLEN-1:0] imm_u_type;
logic [XLEN-1:0] imm_j_type;

typedef enum logic [1:0] {
  eDEC_FIRST_CYCLE,
  eDEC_SECOND_CYCLE,
  eDEC_THIRD_CYCLE
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
logic [11:0]  csr_addr;

/*************************************
* Helper functions
*************************************/
function automatic logic is_shift(input f3_imm_e f3);
  return (f3 == F3_SRLI_SRAI) || (f3 == F3_SRLI_SRAI);
endfunction

function automatic alu_op_e f3_7_to_alu_imm_op(
  input f3_imm_e f3, input f7_shift_imm_e f7, output logic error
);
  alu_op_e op = ALU_OP_ADD;
  error = 1'b0;
  unique case (f3)
    F3_ADDI:  op = ALU_OP_ADD;
    F3_SLTI:  op = ALU_OP_SLT;
    F3_SLTIU: op = ALU_OP_SLTU;
    F3_XORI:  op = ALU_OP_XOR;
    F3_ORI:   op = ALU_OP_OR;
    F3_ANDI:  op = ALU_OP_AND;
    F3_SLLI: begin
      unique case (f7)
        F7_SLLI_SRLI_ADDI: op = ALU_OP_SLL;
        default: error = 1'b1;
      endcase
    end
    F3_SRLI_SRAI: begin
      unique case (f7)
        F7_SLLI_SRLI_ADDI: op = ALU_OP_SRL;
        F7_SRAI_SUB:       op = ALU_OP_SRA;
        default: error = 1'b1;
      endcase
    end
  endcase
  return op;
endfunction

function automatic alu_op_e f3_7_to_alu_rr_op(
  input f3_imm_e f3, input f7_shift_imm_e f7, output logic error
);
  alu_op_e op = ALU_OP_ADD;
  error = 1'b0;
  unique case (f3)
    F3_ADDI: begin
      unique case (f7)
          F7_SLLI_SRLI_ADDI: op = ALU_OP_ADD;
          F7_SRAI_SUB:       op = ALU_OP_SUB;
          default: error = 1'b1;
      endcase
    end
    F3_SLTI:  op = ALU_OP_SLT;
    F3_SLTIU: op = ALU_OP_SLTU;
    F3_XORI:  op = ALU_OP_XOR;
    F3_ORI:   op = ALU_OP_OR;
    F3_ANDI:  op = ALU_OP_AND;
    F3_SLLI: begin
      unique case (f7)
        F7_SLLI_SRLI_ADDI: op = ALU_OP_SLL;
        default: error = 1'b1;
      endcase
    end
    F3_SRLI_SRAI: begin
      unique case (f7)
        F7_SLLI_SRLI_ADDI: op = ALU_OP_SRL;
        F7_SRAI_SUB:       op = ALU_OP_SRA;
        default: error = 1'b1;
      endcase
    end
  endcase
  return op;
endfunction

function automatic lsu_ctrl_e f3_to_lsu_ctrl(input logic [2:0] f3, input logic is_write);
  return lsu_ctrl_e'({is_write, f3});
endfunction

function automatic logic f3_valid_load(input logic [2:0] f3);
  return ((f3 == 3'b000) || (f3 == 3'b001) || (f3 == 3'b010) || (f3 == 3'b100) || (f3 == 3'b101));
endfunction

function automatic logic f3_valid_store(input logic [2:0] f3);
  return ((f3 == 3'b000) || (f3 == 3'b001) || (f3 == 3'b010));
endfunction

function automatic logic f3_f7_valid_opimm(input logic [2:0] f3, input logic [6:0] f7);
  logic valid = 1'b0;
  if (f3 == 3'b001)
    valid = (f7 == 7'b000_0000);
  else if (f3 == 3'b101)
    valid = (f7 == 7'b000_0000 || f7  == 7'b010_0000);
  else
    valid = 1'b1;
  return valid;
endfunction

function automatic logic f3_f7_valid_op(input logic [2:0] f3, input logic [6:0] f7);
  logic valid = 1'b0;
  if (f3 == 3'b000 || f3 == 3'b101)
    valid = (f7 == 7'b000_0000 || f7  == 7'b010_0000);
  else
    valid = (f7 == 7'b000_0000);
  return valid;
endfunction

function automatic logic f3_branch_valid(input logic [2:0] f3);
  return ((f3 == 3'b000) ||
          (f3 == 3'b001) ||
          (f3 == 3'b100) ||
          (f3 == 3'b101) ||
          (f3 == 3'b110) ||
          (f3 == 3'b111));
endfunction

function automatic alu_op_e branch_type_to_alu_op(input branch_ctrl_e f3);
  alu_op_e op = ALU_OP_ADD;
  unique case (f3)
    BRANCH_EQ:   op = ALU_OP_XOR;
    BRANCH_NEQ:  op = ALU_OP_XOR;
    BRANCH_LT:   op = ALU_OP_SLT;
    BRANCH_GE:   op = ALU_OP_SLT;
    BRANCH_LTU:  op = ALU_OP_SLTU;
    BRANCH_GEU:  op = ALU_OP_SLTU;
  endcase
  return op;
endfunction

function automatic logic is_csr_imm(input logic [2:0] f3);
  return f3[2];
endfunction

function automatic logic is_priv_non_csr_instr(
  input logic [4:0]  rs1,
  input logic [4:0]  rd,
  input logic [2:0]  f3,
  input logic [11:0] imm12);
  return ((rs1 == 5'b0) &&
          (rd == 5'b0) &&
          (f3 == 3'b0) &&
          ((imm12 == 12'b0) || (imm12 == 12'b0000_0000_0001) || (imm12 == 12'b001100000010)));
endfunction

function automatic logic f3_is_csr_instr(input logic [2:0] f3);
  return ((f3 == 3'b001) ||
          (f3 == 3'b010) ||
          (f3 == 3'b011) ||
          (f3 == 3'b101) ||
          (f3 == 3'b110) ||
          (f3 == 3'b111));
endfunction

function automatic csr_cmd_t f3_to_csr_cmd(input logic [2:0] f3);
begin
  logic [1:0] f3x = f3[1:0];
  csr_cmd_t res = CSRNO;
  unique case (f3x) // 2 bits of funct3
    2'b00: res = CSRNO;
    2'b01: res = CSRRW;
    2'b10: res = CSRRS;
    2'b11: res = CSRRC;
  endcase
  return res;
end
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
assign csr_addr = instr[31:20];

assign imm_i_type  = {{20{imm11_0[31]}}, imm11_0};
assign imm_s_type  = {{20{imm11_5[31]}}, imm11_5, imm4_0};
assign imm_b_type  = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
assign imm_u_type  = {imm31_12, 12'b0};
assign imm_j_type  = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};

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

`ifdef RVFI
assign instr_exec_o = instr_buff;
`endif

/*************************************
* DECODER - SYNCHRONOUS LOGIC
*************************************/
always_ff @(posedge clk_i) begin
  if (reset_output) begin
    rf_addr_a_o         <= 5'b00000;
    rf_addr_b_o         <= 5'b00000;
    alu_sel_o           <= ALU_OP_ADD;
    rpa_or_pc_o         <= 1'b0;
    rpb_or_imm_o        <= 1'b0;
    alu_write_rf_o      <= 1'b0;
    regdest_o           <= 5'b00000;
    immediate_o         <= 32'h0000_0000;
    lsu_ctrl_valid_o    <= 1'b0;
    lsu_ctrl_o          <= LSU_NO_CMD;
    ctrl_jump_o         <= 1'b0;
    ctrl_branch_o       <= 1'b0;
    ctrl_branch_type_o  <= BRANCH_EQ;
    state               <= eDEC_FIRST_CYCLE;
    instr_issued_o      <= 1'b0;
    instr_will_retire_o <= 1'b0;
    control_o           <= 1'b0;
    csr_valid_o         <= 1'b0;
    csr_addr_o          <= 12'b0;
    csr_cmd_o           <= CSRNO;
    ecall_insn_o        <= 1'b0;
    mret_insn_o         <= 1'b0;
    illegal_instr_o     <= 1'b0;
    ebreak_insn_o       <= 1'b0;
  end
  else if (update_output) begin
    rf_addr_a_o         <= rf_addr_a;
    rf_addr_b_o         <= rf_addr_b;
    alu_sel_o           <= alu_sel;
    rpa_or_pc_o         <= rpa_or_pc;
    rpb_or_imm_o        <= rpb_or_imm;
    alu_write_rf_o      <= alu_write_rf;
    regdest_o           <= regdest2;
    immediate_o         <= immediate;
    lsu_ctrl_valid_o    <= lsu_ctrl_valid;
    lsu_ctrl_o          <= lsu_ctrl;
    ctrl_jump_o         <= ctrl_jump;
    ctrl_branch_o       <= ctrl_branch;
    ctrl_branch_type_o  <= ctrl_branch_type;
    state               <= state_next;
    instr_issued_o      <= instr_issued;
    instr_will_retire_o <= instr_will_retire;
    control_o           <= 1'b1;
    csr_valid_o         <= csr_valid;
    csr_addr_o          <= csr_addr;
    csr_cmd_o           <= csr_cmd;
    ecall_insn_o        <= ecall_insn;
    mret_insn_o         <= mret_insn;
    illegal_instr_o     <= illegal_instr;
    ebreak_insn_o       <= ebreak_insn;
  end
end


/*************************************
* DECODER - COMBINATIONAL LOGIC
*************************************/
always_comb
begin
  rf_addr_a         = 5'b00000;
  rf_addr_b         = 5'b00000;
  alu_sel           = ALU_OP_ADD;
  rpa_or_pc         = 1'b0;
  rpb_or_imm        = 1'b0;
  alu_write_rf      = 1'b0;
  immediate         = 32'h0000_0000;
  lsu_ctrl_valid    = 1'b0;
  lsu_ctrl          = LSU_NO_CMD;
  ctrl_jump         = 1'b0;
  ctrl_branch       = 1'b0;
  ctrl_branch_type  = BRANCH_EQ;
  state_next        = eDEC_FIRST_CYCLE;
  instr_issued      = 1'b1; // Most instructions are single-cycle
  instr_will_retire = 1'b1;
  csr_valid         = 1'b0;
  csr_cmd           = CSRNO;
  ecall_insn        = 1'b0;
  mret_insn         = 1'b0;
  ebreak_insn       = 1'b0;
  regdest2          = 5'b0;
  illegal_instr     = 1'b0;
  unique case (opcode)
    OPCODE_OPIMM: begin
      if (f3_f7_valid_opimm(funct3, funct7)) begin
        rf_addr_a    = regs1;
        alu_sel      = f3_7_to_alu_imm_op(f3_imm_e'(funct3), f7_shift_imm_e'(funct7), illegal_instr);
        rpb_or_imm   = 1'b1;
        alu_write_rf = 1'b1;
        immediate    = imm_i_type;
        regdest2     = regdest;
      end else begin
        illegal_instr = 1'b1;
      end
    end

    OPCODE_OP: begin
      if (f3_f7_valid_op(funct3, funct7)) begin
        rf_addr_a    = regs1;
        rf_addr_b    = regs2;
        alu_sel      = f3_7_to_alu_rr_op(f3_imm_e'(funct3), f7_shift_imm_e'(funct7), illegal_instr);
        alu_write_rf = 1'b1;
        regdest2     = regdest;
      end else begin
        illegal_instr = 1'b1;
      end
    end

    OPCODE_LUI: begin
      rpb_or_imm   = 1'b1;
      alu_write_rf = 1'b1;
      immediate    = imm_u_type;
      regdest2     = regdest;
    end

    OPCODE_AUIPC: begin
      rpa_or_pc    = 1'b1;
      rpb_or_imm   = 1'b1;
      alu_write_rf = 1'b1;
      immediate    = imm_u_type;
      regdest2     = regdest;
    end

    OPCODE_STORE: begin
      if (f3_valid_store(funct3)) begin
        rpb_or_imm     = 1'b1;
        immediate      = imm_s_type;
        rf_addr_a      = regs1;
        rf_addr_b      = regs2;
        lsu_ctrl_valid = 1'b1;
        lsu_ctrl       = f3_to_lsu_ctrl(funct3, 1'b1);
      end else begin
        illegal_instr = 1'b1;
      end
    end

    OPCODE_LOAD: begin
      if (f3_valid_load(funct3)) begin
        rpb_or_imm        = 1'b1;
        immediate         = imm_i_type;
        rf_addr_a         = regs1;
        lsu_ctrl_valid    = 1'b1;
        lsu_ctrl          = f3_to_lsu_ctrl(funct3, 1'b0);
        instr_will_retire = 1'b0;
        regdest2          = regdest;
      end else begin
        illegal_instr = 1'b1;
      end
    end

    OPCODE_JAL: begin
      rpa_or_pc  = 1'b1;
      rpb_or_imm = 1'b1;
      immediate  = imm_j_type;
      ctrl_jump  = 1'b1;
      regdest2   = regdest;
    end

    OPCODE_JALR: begin
      if (funct3 == 3'b000) begin
        rpb_or_imm = 1'b1;
        immediate  = imm_i_type;
        rf_addr_a  = regs1;
        ctrl_jump  = 1'b1;
        regdest2   = regdest;
      end else begin
        illegal_instr = 1'b1;
      end
    end

    OPCODE_BRANCH: begin
      if (f3_branch_valid(funct3)) begin
        unique case (state)
          // First cycle calculates condition
          eDEC_FIRST_CYCLE: begin
            rf_addr_a         = regs1;
            rf_addr_b         = regs2;
            alu_sel           = branch_type_to_alu_op( branch_ctrl_e'(funct3));
            ctrl_branch       = 1'b1;
            ctrl_branch_type  = branch_ctrl_e'(funct3);
            state_next        = eDEC_SECOND_CYCLE;
            instr_will_retire = 1'b0;
          end
          // Jump if condition is met
          eDEC_SECOND_CYCLE: begin
            rpa_or_pc    = 1'b1;
            rpb_or_imm   = 1'b1;
            immediate    = imm_b_type;
            instr_issued = 1'b0;
          end
          default:;
        endcase
      end else begin
        illegal_instr = 1'b1;
      end
    end

    OPCODE_SYSTEM: begin
      if (is_priv_non_csr_instr(regs1, regdest, funct3, csr_addr)) begin
        if (csr_addr == '0) // ECALL
          ecall_insn = 1'b1;
        else if ((funct7 == 7'b0011000) && (regs2 == 5'b00010)) // MRET
          mret_insn = 1'b1;
        else if (csr_addr == 12'b0000_0000_0001) // EBREAK
          ebreak_insn = 1'b1;
      end else if (f3_is_csr_instr(funct3)) begin
        regdest2 = regdest;
        unique case (state)
          eDEC_FIRST_CYCLE: begin
            csr_valid         = 1'b1;
            csr_cmd           = f3_to_csr_cmd(funct3);
            state_next        = eDEC_SECOND_CYCLE;
            instr_will_retire = 1'b0;
            if (is_csr_imm(funct3)) begin
              rpb_or_imm = 1'b1;
              immediate  = {27'b0, regs1};
            end
            else begin
              rf_addr_a = regs1;
            end
          end
          eDEC_SECOND_CYCLE: begin;
            instr_issued = 1'b0;
            state_next   = eDEC_THIRD_CYCLE;
            instr_will_retire = 1'b1;
          end
          eDEC_THIRD_CYCLE: begin;  // wait a cycle
            instr_issued = 1'b0;
            instr_will_retire = 1'b0;
          end
        endcase
      end else begin
        illegal_instr = 1'b1;
      end
    end
    OPCODE_MISCMEM: begin
      if (funct3 != 3'b000)
        illegal_instr = 1'b1;
    end
    default: begin
      illegal_instr = 1'b1;
    end
  endcase
end

endmodule
