////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                       //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_decoder                                            //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
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
  input  logic [DATA_WIDTH-1:0] instr_i,        // Instructions coming in from memory/cache
  input  logic                  instr_valid_i,
  output logic                  ready_co,       // Ready for instructions.

  // CONTROL UNIT INTERFACE
  output logic illegal_instr_ro, // Illegal instruction encountered.

  // ALU INTERFACE
  output logic [ALU_OP_WIDTH-1:0]    alu_sel_ro,         // Select operation that ALU should perform.
  output logic                       alu_op_a_ro,        // Is operand a involved in the operation?
  output logic                       alu_op_b_ro,        // Is operand b involved in the operation?
  output logic [REG_ADDR_WIDTH-1:0]  alu_dest_addr_ro,  
  output logic                       alu_wb_ro,          // Writeback to the register?
  
  // REGISTER FILE INTERFACE  
  output logic [REG_ADDR_WIDTH-1:0]  rf_addr_a_ro,
  output logic [REG_ADDR_WIDTH-1:0]  rf_addr_b_ro,
  
  output logic                       is_imm_ro,   // Does the operation contain a immediate value?
  output logic [DATA_WIDTH-1:0]      imm_ext_ro,  // Sign extended immediate.

  // LSU INTERFACE
  output logic                       lsu_new_ctrl_ro, 
  output logic [3:0]                 lsu_ctrl_ro,
  output logic [REG_ADDR_WIDTH-1:0]  lsu_regdest_ro
);

/*************************************
* INTERNAL SIGNAL DEFINITION
*************************************/
logic                    illegal_instr_w;
logic [ALU_OP_WIDTH-1:0] alu_sel_w;
logic                    alu_op_a_w;
logic                    alu_op_b_w;
logic [REG_ADDR_WIDTH-1:0] alu_dest_addr_w;
logic                      alu_wb_w;

logic [REG_ADDR_WIDTH-1:0] rf_addr_a_w;
logic [REG_ADDR_WIDTH-1:0] rf_addr_b_w;

logic [DATA_WIDTH-1:0]     imm_ext_w;

logic                      lsu_new_ctrl_w;
logic [3:0]                lsu_ctrl_w;
logic [REG_ADDR_WIDTH-1:0] lsu_regdest_w;

// Other signal definitions
logic [DATA_WIDTH-1:0] I_imm_sign_extended_w;
logic [DATA_WIDTH-1:0] I_shift_imm_sign_extended_w;
logic [DATA_WIDTH-1:0] J_imm_sign_extended_w;
logic [DATA_WIDTH-1:0] B_imm_sign_extended_w;
logic [DATA_WIDTH-1:0] S_imm_sign_extended_w;

// For generating stalling logic
logic [REG_ADDR_WIDTH-1:0] prev_dest_addr;

// FSM signals
typedef enum logic [2:0] {eOK=3'b001, eSTALL=3'b010, eERROR=3'b100} fsmState_t; 
fsmState_t curr_state;
fsmState_t prev_state;

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
* RISC-V INSTRUCTION PART SHORTHANDS
*************************************/
assign opcode   = instr_i[6:0];
assign regdest  = instr_i[11:7];
assign imm4_0   = instr_i[11:7];
assign imm31_12 = instr_i[31:12]; // U-type immediate 
assign imm11_0  = instr_i[31:20]; // I-type immediate
assign funct3   = instr_i[14:12];
assign regs1    = instr_i[19:15];
assign regs2    = instr_i[24:20];
assign funct7   = instr_i[31:25];


/*************************************
* FSM UPDATE
*************************************/
always_ff@(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        prev_state <= eOK;
    end
    else begin
        prev_state <= curr_state;
    end
end


/*************************************
* PREVIOUS DESTINATION SAVING
*************************************/
// We save the previous destination register address to see if we need to generate stalls.
always_ff@(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        prev_dest_addr <= 4'b0;
    end
    else begin
       if (opcode == OPCODE_BRANCH ||
           opcode == OPCODE_STORE) begin
            prev_dest_addr <= 4'b0;
        end
        else begin
            prev_dest_addr <= regdest;
        end 
    end
end


/*************************************
* READY SIGNAL
*************************************/
// Signal ready_co is combinational to provied imediate feedback to the IFU, if we need to stall.
always_comb begin
    if (curr_state == eOK) begin
        ready_co <= 1'b1;
    end
    else begin
        ready_co <= 1'b0;
    end
end


/*************************************
* SIGN EXTENDERS
*************************************/
// For the I instruction type immediate
sign_extender #(.N(DATA_WIDTH), .M(12)) sign_extender_I_inst (.in_i(imm11_0),
                                                              .out_o(I_imm_sign_extended_w));
// Used in shift instructions
sign_extender #(.N(DATA_WIDTH), .M(5))  sign_extender_I_shift_inst(.in_i(imm11_0[24:20]),
                                                                  .out_o(I_shift_imm_sign_extended_w));
// For the J instruction type immediate
sign_extender #(.N(DATA_WIDTH), .M(21)) sign_extender_J_inst (.in_i({instr_i[31], 
                                                                     instr_i[19:12], 
                                                                     instr_i[20], 
                                                                     instr_i[10:1], 
                                                                     1'b0}),
                                                               .out_o(J_imm_sign_extended_w)
                                                             );

// For the B instruction type immediate
sign_extender #(.N(DATA_WIDTH), .M(13)) sign_extender_B_inst (.in_i({instr_i[31], 
                                                                     instr_i[7], 
                                                                     instr_i[30:25], 
                                                                     instr_i[11:8], 
                                                                     1'b0}),
                                                              .out_o(B_imm_sign_extended_w));

// For the S instruction type immediate
sign_extender #(.N(DATA_WIDTH), .M(13)) sign_extender_S_inst (.in_i({instr_i[31:25], 
                                                                     instr_i[11:7], 
                                                                     1'b0}),
                                                              .out_o(S_imm_sign_extended_w));


/*************************************
* DECODER - SYNCHRONOUS LOGIC
*************************************/
always_ff@(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    illegal_instr_ro <= 0;
    alu_sel_ro <= 0;
    alu_op_a_ro <= 0;
    alu_op_b_ro <= 0;
    alu_dest_addr_ro <= 0;
    alu_wb_ro <= 0;
    rf_addr_a_ro <= 0;
    rf_addr_b_ro <= 0;
    is_imm_ro <= 0;
    imm_ext_ro <= 0;
    lsu_new_ctrl_ro <= 0;
    lsu_ctrl_ro <= 0;
    lsu_regdest_ro <= 0;
  end
  else begin
    if (instr_valid_i == 1'b1) begin
        illegal_instr_ro <= illegal_instr_w;
        alu_sel_ro <= alu_sel_w;
        alu_op_a_ro <= alu_op_a_w;
        alu_op_b_ro <= alu_op_b_w;
        alu_dest_addr_ro <= alu_dest_addr_w;
        alu_wb_ro <= alu_wb_w;
        rf_addr_a_ro <= rf_addr_a_w;
        rf_addr_b_ro <= rf_addr_b_w;
        is_imm_ro <= ~(alu_op_a_w & alu_op_b_w);
        imm_ext_ro <= imm_ext_w;
        lsu_new_ctrl_ro <= lsu_new_ctrl_w;
        lsu_ctrl_ro <= lsu_ctrl_w;
        lsu_regdest_ro <= lsu_regdest_w;
    end
    else begin
        illegal_instr_ro <= illegal_instr_ro;
        alu_sel_ro <= alu_sel_ro;
        alu_op_a_ro <= alu_op_a_ro;
        alu_op_b_ro <= alu_op_b_ro;
        alu_dest_addr_ro <= alu_dest_addr_ro;
        alu_wb_ro <= alu_wb_ro;
        rf_addr_a_ro <= rf_addr_a_ro;
        rf_addr_b_ro <= rf_addr_b_ro;
        is_imm_ro <= is_imm_ro;
        imm_ext_ro <= imm_ext_ro;
        lsu_new_ctrl_ro <= lsu_new_ctrl_ro;
        lsu_ctrl_ro <= lsu_ctrl_ro;
        lsu_regdest_ro <= lsu_regdest_ro;
    end
  end
end


/*************************************
* DECODER - COMBINATIONAL LOGIC
*************************************/
always_comb
begin
  case (opcode)
    OPCODE_LOAD: begin
        illegal_instr_w = 1'b0;
        alu_sel_w       = 1'b0;
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b0;
        alu_dest_addr_w = 4'b0;
        alu_wb_w        = 1'b0; 
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = 4'b0;
        imm_ext_w       = I_imm_sign_extended_w;
        lsu_new_ctrl_w  = 1'b1;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (regs1 == prev_dest_addr && regs1 != 0 && prev_state != eSTALL) begin
            curr_state = eSTALL;
        end
        else begin
            curr_state = eOK;
        end
    end

    OPCODE_MISCMEM: begin 
        illegal_instr_w = 1'b0;
        alu_sel_w       = 1'b0;
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b0;
        alu_dest_addr_w = 4'b0;
        alu_wb_w        = 1'b0; 
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = 4'b0;
        imm_ext_w       = I_imm_sign_extended_w;
        lsu_new_ctrl_w  = 1'b1;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (regs1 == prev_dest_addr && regs1 != 0 && prev_state != eSTALL) begin
            curr_state = eSTALL;
        end
        else begin
            curr_state = eOK;
        end
    end

    OPCODE_OPIMM: begin
        illegal_instr_w = 1'b0;
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b0;
        alu_dest_addr_w = regdest;
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = 4'b0;
        if (funct3 == FUNCT3_SHIFT_INSTR && 
           (imm11_0[31:25] == 0 || imm11_0[31:25] == 7'b0100000)) begin
            imm_ext_w = I_shift_imm_sign_extended_w;
            alu_sel_w  = {instr_i[30], funct3};
        end
        else begin
            imm_ext_w = I_imm_sign_extended_w;
            alu_sel_w  = {1'b0, funct3};
        end
        lsu_new_ctrl_w  = 1'b0;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (regs1 == prev_dest_addr && regs1 != 0 && prev_state != eSTALL) begin
            curr_state = eSTALL;
            alu_wb_w   = 1'b0; 
        end
        else begin
            curr_state = eOK;
            alu_wb_w   = 1'b1; 
        end
    end

    OPCODE_AUIPC: begin
        illegal_instr_w = 1'b0;
        alu_sel_w       = {instr_i[30], funct3};
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b0;
        alu_dest_addr_w = regdest;
        alu_wb_w        = 1'b1; 
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = 4'b0;
        imm_ext_w       = {imm31_12, 12'b0};
        lsu_new_ctrl_w  = 1'b1;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (regs1 == prev_dest_addr && regs1 != 0 && prev_state != eSTALL) begin
            curr_state = eSTALL;
        end
        else begin
            curr_state = eOK;
        end
    end

    OPCODE_STORE: begin
        illegal_instr_w = 1'b0;
        alu_sel_w       = {instr_i[30], funct3};
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b0;
        alu_dest_addr_w = regdest;
        alu_wb_w        = 1'b0; 
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = 4'b0;
        imm_ext_w       = S_imm_sign_extended_w;
        lsu_new_ctrl_w  = 1'b1;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (regs1 == prev_dest_addr && regs1 != 0 && prev_state != eSTALL) begin
            curr_state = eSTALL;
        end
        else begin
            curr_state = eOK;
        end
    end
    
    OPCODE_OP: begin
        illegal_instr_w = 1'b0;
        alu_sel_w       = {instr_i[30], funct3};
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b1;
        alu_dest_addr_w = regdest;
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = regs2;
        imm_ext_w       = 32'b0;
        lsu_new_ctrl_w  = 1'b0;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (((regs1 == prev_dest_addr && regs1 != 0 ) || 
            (regs2 == prev_dest_addr && regs2 != 0 )) &&
             prev_state != eSTALL) begin
            curr_state = eSTALL;
            alu_wb_w   = 1'b0; 
        end
        else begin
            curr_state = eOK;
            alu_wb_w   = 1'b1; 
        end
    end

    OPCODE_LUI: begin
        illegal_instr_w = 1'b0;
        alu_sel_w       = {instr_i[30], funct3};
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b1;
        alu_dest_addr_w = 4'b0;
        alu_wb_w        = 1'b0; 
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = regs2;
        imm_ext_w       = {imm31_12, 12'b0};
        lsu_new_ctrl_w  = 1'b1;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (((regs1 == prev_dest_addr && regs1 != 0 ) || 
            (regs2 == prev_dest_addr && regs2 != 0 )) &&
             prev_state != eSTALL) begin
            curr_state = eSTALL;
        end
        else begin
            curr_state = eOK;
        end
    end

    OPCODE_BRANCH: begin
        illegal_instr_w = 1'b0;
        alu_sel_w       = {instr_i[30], funct3};
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b1;
        alu_dest_addr_w = 4'b0;
        alu_wb_w        = 1'b0; 
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = regs2;
        imm_ext_w       = B_imm_sign_extended_w;   
        lsu_new_ctrl_w  = 1'b1;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (((regs1 == prev_dest_addr && regs1 != 0 ) || 
            (regs2 == prev_dest_addr && regs2 != 0 )) &&
             prev_state != eSTALL) begin
            curr_state = eSTALL;
        end
        else begin
            curr_state = eOK;
        end
    end

    OPCODE_JALR: begin
        illegal_instr_w = 1'b0;
        alu_sel_w       = {instr_i[30], funct3};
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b1;
        alu_dest_addr_w = 4'b0;
        alu_wb_w        = 1'b0; 
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = regs2;
        imm_ext_w   = I_imm_sign_extended_w;   
        lsu_new_ctrl_w  = 1'b1;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (((regs1 == prev_dest_addr && regs1 != 0 ) || 
            (regs2 == prev_dest_addr && regs2 != 0 )) &&
             prev_state != eSTALL) begin
            curr_state = eSTALL;
        end
        else begin
            curr_state = eOK;
        end
    end

    OPCODE_JAL: begin
        illegal_instr_w = 1'b0;
        alu_sel_w       = {instr_i[30], funct3};
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b1;
        alu_dest_addr_w = 4'b0;
        alu_wb_w        = 1'b0; 
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = regs2;
        imm_ext_w       = J_imm_sign_extended_w;   
        lsu_new_ctrl_w  = 1'b1;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (((regs1 == prev_dest_addr && regs1 != 0 ) || 
            (regs2 == prev_dest_addr && regs2 != 0 )) &&
             prev_state != eSTALL) begin
            curr_state = eSTALL;
        end
        else begin
            curr_state = eOK;
        end
    end

    OPCODE_SYSTEM: begin
        illegal_instr_w = 1'b0;
        alu_sel_w       = {instr_i[30], funct3};
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b1;
        alu_dest_addr_w = 4'b0;
        alu_wb_w        = 1'b0; 
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = regs2;
        imm_ext_w       = J_imm_sign_extended_w;   
        lsu_new_ctrl_w  = 1'b1;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        if (((regs1 == prev_dest_addr && regs1 != 0 ) || 
            (regs2 == prev_dest_addr && regs2 != 0 )) &&
             prev_state != eSTALL) begin
            curr_state = eSTALL;
        end
        else begin
            curr_state = eOK;
        end
    end

    default: begin
        illegal_instr_w = 1'b1;
        alu_sel_w       = {instr_i[30], funct3};
        alu_op_a_w      = 1'b1;
        alu_op_b_w      = 1'b1;
        alu_dest_addr_w = 4'b0;
        alu_wb_w        = 1'b0; 
        rf_addr_a_w     = regs1;
        rf_addr_b_w     = regs2;
        imm_ext_w       = J_imm_sign_extended_w;   
        lsu_new_ctrl_w  = 1'b1;
        lsu_ctrl_w      = {opcode[6], funct3};
        lsu_regdest_w   = regdest;
        curr_state      = eERROR;
    end
  endcase
end

endmodule // jedro_1_decoder
