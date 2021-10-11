////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_decoder                                          //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    Decoder for the RV32I instructions.                    //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import jedro_1_defines::*;

module jedro_1_decoder
(
  input clk_i,
  input rstn_i,

  // Interface to instruction interface 
  input [DATA_WIDTH-1:0] instr_rdata_i,   // Instructions coming in from memory/cache

  // Interface to the control unit
  output illegal_instr_o, // Illegal instruction encountered      

  // ALU interface
  output [ALU_OP_WIDTH-1:0]     alu_op_sel_o,         // Combination of funct3 + 6-th bit of funct7
  output                        alu_reg_op_a_o,
  output                        alu_reg_op_b_o,
  output [REG_ADDR_WIDTH-1:0]   alu_reg_op_a_addr_o,
  output [REG_ADDR_WIDTH-1:0]   alu_reg_op_b_addr_o,
  output [REG_ADDR_WIDTH-1:0]   alu_reg_dest_addr_o,  // So the ALU knows where to store the result after computing it.
  output [DATA_WIDTH-1:0]       alu_immediate_ext_o,  // sign extended
  output                        alu_wb_o,             // writeback to the register?

  // Interface to the load-store unit
  output                        lsu_new_ctrl_o, 
  output [3:0]                  lsu_ctrl_o,
  output [REG_ADDR_WIDTH-1:0]   lsu_regdest_o
);

logic illegal_instr_reg;
logic [ALU_OP_WIDTH-1:0] alu_op_sel_reg;
logic alu_reg_op_a_reg;
logic alu_reg_op_b_reg;
logic [REG_ADDR_WIDTH-1:0] alu_reg_op_a_addr_reg;
logic [REG_ADDR_WIDTH-1:0] alu_reg_op_b_addr_reg;
logic [REG_ADDR_WIDTH-1:0] alu_reg_dest_addr_reg;
logic [DATA_WIDTH-1:0]  alu_immediate_ext_reg;
logic alu_wb_reg;
logic lsu_new_ctrl_reg;
logic [3:0] lsu_ctrl_reg;
logic [REG_ADDR_WIDTH-1:0] lsu_regdest_reg;

logic illegal_instr_w;
logic [ALU_OP_WIDTH-1:0] alu_op_sel_w;
logic alu_reg_op_a_w;
logic alu_reg_op_b_w;
logic [REG_ADDR_WIDTH-1:0] alu_reg_op_a_addr_w;
logic [REG_ADDR_WIDTH-1:0] alu_reg_op_b_addr_w;
logic [REG_ADDR_WIDTH-1:0] alu_reg_dest_addr_w;
logic [DATA_WIDTH-1:0]  alu_immediate_ext_w;
logic alu_wb_w;
logic lsu_new_ctrl_w;
logic [3:0] lsu_ctrl_w;
logic [REG_ADDR_WIDTH-1:0] lsu_regdest_w;

assign illegal_instr_o = illegal_instr_reg;
assign alu_op_sel_o = alu_op_sel_reg;
assign alu_reg_op_a_o = alu_reg_op_a_reg;
assign alu_reg_op_b_o = alu_reg_op_b_reg;
assign alu_reg_op_a_addr_o = alu_reg_op_a_addr_reg;
assign alu_reg_op_b_addr_o = alu_reg_op_b_addr_reg;
assign alu_reg_dest_addr_o = alu_reg_dest_addr_reg;
assign alu_immediate_ext_o = alu_immediate_ext_reg;
assign alu_wb_o = alu_wb_reg;
assign lsu_new_ctrl_o = lsu_new_ctrl_reg;
assign lsu_ctrl_o = lsu_ctrl_reg;
assign lsu_regdest_o = lsu_regdest_reg;

always_ff@(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    illegal_instr_reg <= 0;
    alu_op_sel_reg <= 0;
    alu_reg_op_a_reg <= 0;
    alu_reg_op_b_reg <= 0;
    alu_reg_op_a_addr_reg <= 0;
    alu_reg_op_b_addr_reg <= 0;
    alu_reg_dest_addr_reg <= 0;
    alu_immediate_ext_reg <= 0;
    alu_wb_reg <= 0;
    lsu_new_ctrl_reg <= 0;
    lsu_ctrl_reg <= 0;
    lsu_regdest_reg <= 0;
  end
  else begin
    illegal_instr_reg <= illegal_instr_w;
    alu_op_sel_reg <= alu_op_sel_w;
    alu_reg_op_a_reg <= alu_reg_op_a_w;
    alu_reg_op_b_reg <= alu_reg_op_b_w;
    alu_reg_op_a_addr_reg <= alu_reg_op_a_addr_w;
    alu_reg_op_b_addr_reg <= alu_reg_op_b_addr_w;
    alu_reg_dest_addr_reg <= alu_reg_dest_addr_w;
    alu_immediate_ext_reg <= alu_immediate_ext_w;
    alu_wb_reg <= alu_wb_w;
    lsu_new_ctrl_reg <= lsu_new_ctrl_w;
    lsu_ctrl_reg <= lsu_ctrl_w;
    lsu_regdest_reg <= lsu_regdest_w;
  end

end

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

assign opcode   = instr_rdata_i[6:0];
assign regdest  = instr_rdata_i[11:7];
assign imm4_0   = instr_rdata_i[11:7];
assign imm31_12 = instr_rdata_i[31:12]; // U-type immediate 
assign imm11_0  = instr_rdata_i[31:20]; // I-type immediate
assign funct3   = instr_rdata_i[14:12];
assign regs1    = instr_rdata_i[19:15];
assign regs2    = instr_rdata_i[24:20];
assign funct7   = instr_rdata_i[31:25];

// Other signal definitions
logic [DATA_WIDTH-1:0] I_immediate_sign_extended_w;
logic [DATA_WIDTH-1:0] J_immediate_sign_extended_w;
logic [DATA_WIDTH-1:0] B_immediate_sign_extended_w;
logic [DATA_WIDTH-1:0] S_immediate_sign_extended_w;


// COMBINATIONAL LOGIC
// For the I instruction type immediate
sign_extender #(.N(DATA_WIDTH), .M(12)) sign_extender_inst_I (.in_i(imm11_0),
                                                               .out_o(I_immediate_sign_extended_w));

// For the J instruction type immediate
sign_extender #(.N(DATA_WIDTH), .M(21)) sign_extender_inst_J (.in_i({instr_rdata_i[31], 
                                                                      instr_rdata_i[19:12], 
                                                                      instr_rdata_i[20], 
                                                                      instr_rdata_i[10:1], 
                                                                      1'b0}),
                                                               .out_o(J_immediate_sign_extended_w)
                                                             );

// For the B instruction type immediate
sign_extender #(.N(DATA_WIDTH), .M(13)) sign_extender_inst_B (.in_i({instr_rdata_i[31], 
                                                                      instr_rdata_i[7], 
                                                                      instr_rdata_i[30:25], 
                                                                      instr_rdata_i[11:8], 
                                                                      1'b0}),
                                                               .out_o(B_immediate_sign_extended_w));

// For the S instruction type immediate
sign_extender #(.N(DATA_WIDTH), .M(13)) sign_extender_inst_S (.in_i({instr_rdata_i[31:25], 
                                                                      instr_rdata_i[11:7], 
                                                                      1'b0}),
                                                               .out_o(S_immediate_sign_extended_w));


// Start decoding a new instruction
always_comb
begin
  case (opcode)
    OPCODE_LOAD: begin
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = 1'b0;
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b0;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = 4'b0;
        alu_reg_dest_addr_w = 4'b0;
        alu_immediate_ext_w = I_immediate_sign_extended_w;
        alu_wb_w            = 1'b0; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end

    OPCODE_MISCMEM: begin 
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = 1'b0;
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b0;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = 4'b0;
        alu_reg_dest_addr_w = 4'b0;
        alu_immediate_ext_w = I_immediate_sign_extended_w;
        alu_wb_w            = 1'b0; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end

    OPCODE_OPIMM: begin
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = {instr_rdata_i[30], funct3};
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b0;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = 4'b0;
        alu_reg_dest_addr_w = regdest;
        alu_immediate_ext_w = I_immediate_sign_extended_w;
        alu_wb_w            = 1'b1; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end

    OPCODE_AUIPC: begin
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = {instr_rdata_i[30], funct3};
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b0;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = 4'b0;
        alu_reg_dest_addr_w = regdest;
        alu_immediate_ext_w = {imm31_12, 12'b0};
        alu_wb_w            = 1'b1; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end

    OPCODE_STORE: begin
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = {instr_rdata_i[30], funct3};
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b0;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = 4'b0;
        alu_reg_dest_addr_w = regdest;
        alu_immediate_ext_w = S_immediate_sign_extended_w;
        alu_wb_w            = 1'b0; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end
    
    OPCODE_OP: begin
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = {instr_rdata_i[30], funct3};
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b1;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = regs2;
        alu_reg_dest_addr_w = 4'b0;
        alu_immediate_ext_w = 32'b0;
        alu_wb_w            = 1'b0; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end

    OPCODE_LUI: begin
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = {instr_rdata_i[30], funct3};
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b1;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = regs2;
        alu_reg_dest_addr_w = 4'b0;
        alu_immediate_ext_w = {imm31_12, 12'b0};
        alu_wb_w            = 1'b0; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end

    OPCODE_BRANCH: begin
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = {instr_rdata_i[30], funct3};
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b1;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = regs2;
        alu_reg_dest_addr_w = 4'b0;
        alu_immediate_ext_w = B_immediate_sign_extended_w;   
        alu_wb_w            = 1'b0; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end

    OPCODE_JALR: begin
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = {instr_rdata_i[30], funct3};
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b1;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = regs2;
        alu_reg_dest_addr_w = 4'b0;
        alu_immediate_ext_w = I_immediate_sign_extended_w;   
        alu_wb_w            = 1'b0; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end

    OPCODE_JAL: begin
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = {instr_rdata_i[30], funct3};
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b1;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = regs2;
        alu_reg_dest_addr_w = 4'b0;
        alu_immediate_ext_w = J_immediate_sign_extended_w;   
        alu_wb_w            = 1'b0; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end

    OPCODE_SYSTEM: begin
        illegal_instr_w     = 1'b0;
        alu_op_sel_w        = {instr_rdata_i[30], funct3};
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b1;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = regs2;
        alu_reg_dest_addr_w = 4'b0;
        alu_immediate_ext_w = J_immediate_sign_extended_w;   
        alu_wb_w            = 1'b0; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end

    default: begin
        illegal_instr_w     = 1'b1;
        alu_op_sel_w        = {instr_rdata_i[30], funct3};
        alu_reg_op_a_w      = 1'b1;
        alu_reg_op_b_w      = 1'b1;
        alu_reg_op_a_addr_w = regs1;
        alu_reg_op_b_addr_w = regs2;
        alu_reg_dest_addr_w = 4'b0;
        alu_immediate_ext_w = J_immediate_sign_extended_w;   
        alu_wb_w            = 1'b0; 
        lsu_new_ctrl_w      = 1'b1;
        lsu_ctrl_w          = {opcode[6], funct3};
        lsu_regdest_w       = regdest;
    end
  endcase
end

endmodule // jedro_1_decoder
