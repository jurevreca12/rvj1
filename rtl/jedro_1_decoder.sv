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
  input  logic [DATA_WIDTH-1:0] instr_i,        // Instructions coming in from memory/cache
  input  logic [DATA_WIDTH-1:0] instr_addr_i,
  output logic [DATA_WIDTH-1:0] instr_addr_ro,
  input  logic                  instr_valid_i,
  output logic                  use_pc_ro,
  output logic                  ready_co,       // Ready for instructions.
  output logic                  jmp_instr_co,
  output logic [DATA_WIDTH-1:0] jmp_addr_co,
  output logic                  use_alu_jmp_addr_ro,

  // CONTROL UNIT INTERFACE
  output logic illegal_instr_ro, // Illegal instruction encountered.

  // ALU INTERFACE
  output logic                       is_alu_write_ro,    // Controls mux4-if RF WPC bellongs to ALU.
  output logic [ALU_OP_WIDTH-1:0]    alu_sel_ro,         // Select operation that ALU should perform.
  output logic                       alu_op_a_ro,        // Is operand a involved in the operation?
  output logic                       alu_op_b_ro,        // Is operand b involved in the operation?
  output logic [REG_ADDR_WIDTH-1:0]  alu_dest_addr_ro,  
  output logic                       alu_wb_ro,          // Writeback to the register?
  input  logic [DATA_WIDTH-1:0]      alu_res_i,          // Writeback used for branch instr.
  input  logic                       alu_ops_eq_i,
  
  // REGISTER FILE INTERFACE  
  output logic [REG_ADDR_WIDTH-1:0]  rf_addr_a_ro,
  output logic [REG_ADDR_WIDTH-1:0]  rf_addr_b_ro,
  
  output logic                       is_imm_ro,   // Does the operation contain a immediate value?
  output logic [DATA_WIDTH-1:0]      imm_ext_ro,  // Sign extended immediate.

  // LSU INTERFACE
  output logic                       lsu_ctrl_valid_ro, 
  output logic [LSU_CTRL_WIDTH-1:0]  lsu_ctrl_ro,
  output logic [REG_ADDR_WIDTH-1:0]  lsu_regdest_ro
);

/*************************************
* INTERNAL SIGNAL DEFINITION
*************************************/
logic                      use_alu_jmp_addr_w;
logic                      use_pc_w;
logic                      illegal_instr_w;
logic                      is_alu_write_w;
logic [ALU_OP_WIDTH-1:0]   alu_sel_w;
logic                      alu_op_a_w;
logic                      alu_op_b_w;
logic [REG_ADDR_WIDTH-1:0] alu_dest_addr_w;
logic                      alu_wb_w;

logic [REG_ADDR_WIDTH-1:0] rf_addr_a_w;
logic [REG_ADDR_WIDTH-1:0] rf_addr_b_w;

logic [DATA_WIDTH-1:0]     imm_ext_w;

logic                      lsu_ctrl_valid_w;
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
typedef enum logic [21:0] {eOK                 = 22'b0000000000000000000001, 
                           eSTALL              = 22'b0000000000000000000010, 
                           eJAL                = 22'b0000000000000000000100,
                           eJAL_WAIT_1         = 22'b0000000000000000001000,
                           eJAL_WAIT_2         = 22'b0000000000000000010000,
                           eJALR_PC_CALC       = 22'b0000000000000000100000,
                           eJALR_JMP_ADDR_CALC = 22'b0000000000000001000000,
                           eJALR_JMP           = 22'b0000000000000010000000,
                           eBRANCH_CALC_COND   = 22'b0000000000000100000000,
                           eBRANCH_CALC_ADDR   = 22'b0000000000001000000000,
                           eBRANCH_STALL       = 22'b0000000000010000000000,
                           eBRANCH_JUMP        = 22'b0000000000100000000000,
                           eBRANCH_STALL_2     = 22'b0000000001000000000000,
                           eLSU_CALC_ADDR      = 22'b0000000010000000000000,
                           eLSU_STORE          = 22'b0000000100000000000000,
                           eLSU_LOAD_CALC_ADDR = 22'b0000001000000000000000,
                           eLSU_LOAD           = 22'b0000010000000000000000,
                           eLSU_LOAD_WAIT_0    = 22'b0000100000000000000000,
                           eLSU_LOAD_WAIT_1    = 22'b0001000000000000000000,
                           eLSU_LOAD_WAIT_2    = 22'b0010000000000000000000,
                           eERROR              = 22'b0100000000000000000000,
                           eINSTR_NOT_VALID    = 22'b1000000000000000000000} fsmState_t; 
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
* BUFFER INSTR ADDR
*************************************/
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        instr_addr_ro <= 32'b0;
    end
    else begin
        instr_addr_ro <= instr_addr_i;
    end
end


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

// Signal ready_co is combinational to provied imediate feedback to the IFU, if we need to stall.
always_comb begin
    ready_co     = 0;
    jmp_instr_co = 0;
    jmp_addr_co  = 0;
    unique case(curr_state)
        eOK: begin
            ready_co = 1;
        end
        
        eSTALL: begin
        end
        
        eJAL: begin
            jmp_instr_co = 1;
            jmp_addr_co  = J_imm_sign_extended_w + instr_addr_i;
        end

        eJAL_WAIT_1: begin
        end

        eJAL_WAIT_2: begin
        end
        
        eJALR_PC_CALC: begin
        end

        eJALR_JMP_ADDR_CALC: begin
        end

        eJALR_JMP: begin
            ready_co = 1;
        end

        eBRANCH_CALC_COND: begin 
        end

        eBRANCH_CALC_ADDR: begin
        end
        
        eBRANCH_STALL: begin
        end

        eBRANCH_JUMP: begin
        end 
        
        eBRANCH_STALL_2: begin
            ready_co = 1;
        end

        eLSU_CALC_ADDR: begin
        end

        eLSU_STORE: begin
            ready_co = 1;
        end

        eLSU_LOAD_CALC_ADDR: begin
        end
        
        eLSU_LOAD: begin
        end

        eLSU_LOAD_WAIT_0: begin
        end
    
        eLSU_LOAD_WAIT_1: begin
        end
    
        eLSU_LOAD_WAIT_2: begin
            ready_co = 1;
        end

        eERROR: begin
        end

        eINSTR_NOT_VALID: begin
            ready_co = 1;
        end

        default: begin
            ready_co     = 0;
            jmp_instr_co = 0;
            jmp_addr_co  = 0;
        end   
    endcase
end


/*************************************
* PREVIOUS DESTINATION SAVING
*************************************/
// We save the previous destination register address to see if we need to generate stalls.
always_ff@(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        prev_dest_addr <= 5'b00000;
    end
    else begin
       if (opcode == OPCODE_BRANCH) begin
            prev_dest_addr <= 5'b00000;
        end
        else begin
            prev_dest_addr <= regdest;
        end 
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
                                                                     instr_i[30:21], 
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
sign_extender #(.N(DATA_WIDTH), .M(12)) sign_extender_S_inst (.in_i({instr_i[31:25], 
                                                                     instr_i[11:7]}),
                                                              .out_o(S_imm_sign_extended_w));


/*************************************
* DECODER - SYNCHRONOUS LOGIC
*************************************/
always_ff@(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    use_alu_jmp_addr_ro <= 0;
    use_pc_ro <= 0;
    illegal_instr_ro <= 0;
    is_alu_write_ro <= 1'b1;
    alu_sel_ro <= 0;
    alu_op_a_ro <= 0;
    alu_op_b_ro <= 0;
    alu_dest_addr_ro <= 0;
    alu_wb_ro <= 0;
    rf_addr_a_ro <= 0;
    rf_addr_b_ro <= 0;
    is_imm_ro <= 0;
    imm_ext_ro <= 0;
    lsu_ctrl_valid_ro <= 0;
    lsu_ctrl_ro <= 0;
    lsu_regdest_ro <= 0;
  end
  else begin
    if (instr_valid_i == 1'b1) begin
        use_alu_jmp_addr_ro <= use_alu_jmp_addr_w;
        use_pc_ro <= use_pc_w;
        illegal_instr_ro <= illegal_instr_w;
        is_alu_write_ro <= is_alu_write_w;
        alu_sel_ro <= alu_sel_w;
        alu_op_a_ro <= alu_op_a_w;
        alu_op_b_ro <= alu_op_b_w;
        alu_dest_addr_ro <= alu_dest_addr_w;
        alu_wb_ro <= alu_wb_w;
        rf_addr_a_ro <= rf_addr_a_w;
        rf_addr_b_ro <= rf_addr_b_w;
        is_imm_ro <= ~(alu_op_a_w & alu_op_b_w);
        imm_ext_ro <= imm_ext_w;
        lsu_ctrl_valid_ro <= lsu_ctrl_valid_w;
        lsu_ctrl_ro <= lsu_ctrl_w;
        lsu_regdest_ro <= lsu_regdest_w;
    end
    else begin
        use_alu_jmp_addr_ro <= 1'b0;
        use_pc_ro <= 1'b0;
        illegal_instr_ro <= illegal_instr_ro;
        is_alu_write_ro <= is_alu_write_ro;
        alu_sel_ro <= alu_sel_ro;
        alu_op_a_ro <= alu_op_a_ro;
        alu_op_b_ro <= alu_op_b_ro;
        alu_dest_addr_ro <= alu_dest_addr_ro;
        alu_wb_ro <= alu_wb_ro;
        rf_addr_a_ro <= rf_addr_a_ro;
        rf_addr_b_ro <= rf_addr_b_ro;
        is_imm_ro <= is_imm_ro;
        imm_ext_ro <= imm_ext_ro;
        lsu_ctrl_valid_ro <= lsu_ctrl_valid_ro;
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
  use_alu_jmp_addr_w = 1'b0;
  use_pc_w           = 1'b0;
  illegal_instr_w    = 1'b0;
  is_alu_write_w     = 1'b0;
  alu_sel_w          = 4'b0000;
  alu_op_a_w         = 1'b0;
  alu_op_b_w         = 1'b0;
  alu_dest_addr_w    = 4'b0;
  alu_wb_w           = 1'b0; 
  rf_addr_a_w        = 5'b00000;
  rf_addr_b_w        = 5'b00000;
  imm_ext_w          = 0; 
  lsu_ctrl_valid_w   = 1'b0;
  lsu_ctrl_w         = 4'b0000;
  lsu_regdest_w      = 5'b00000;
  curr_state         = eERROR;

  unique casez ({instr_valid_i, opcode})
    {1'b1, OPCODE_LOAD}: begin
        alu_sel_w          = ALU_OP_ADD;
        rf_addr_a_w        = regs1;
        if (regs1 == prev_dest_addr && regs1 != 0 && prev_state != eSTALL) begin
            curr_state       = eSTALL;
            alu_op_a_w       = 1'b0;
            imm_ext_w        = 0;
            lsu_ctrl_valid_w = 1'b0;
            lsu_ctrl_w       = 4'b0000;
            lsu_regdest_w    = 5'b00000;
        end
        else if(prev_state != eLSU_LOAD_CALC_ADDR &&
                prev_state != eLSU_LOAD &&
                prev_state != eLSU_LOAD_WAIT_0 &&
                prev_state != eLSU_LOAD_WAIT_1) begin
            curr_state       = eLSU_LOAD_CALC_ADDR;
            alu_op_a_w       = 1'b1;
            imm_ext_w        = I_imm_sign_extended_w;
            lsu_ctrl_valid_w = 1'b0;
            lsu_ctrl_w       = 4'b0000;
            lsu_regdest_w    = 5'b00000;
        end
        else if (prev_state == eLSU_LOAD_CALC_ADDR) begin
            curr_state       = eLSU_LOAD;
            alu_op_a_w       = 1'b0;
            imm_ext_w        = 0;
            lsu_ctrl_valid_w = 1'b1;
            lsu_ctrl_w       = {opcode[5], funct3};
            lsu_regdest_w    = regdest;
        end
        else if (prev_state == eLSU_LOAD) begin
            curr_state       = eLSU_LOAD_WAIT_0;
            alu_op_a_w       = 1'b0;
            imm_ext_w        = 0;
            lsu_ctrl_valid_w = 1'b0;
            lsu_ctrl_w       = 4'b0000;
            lsu_regdest_w    = 5'b00000;

        end
        else if (prev_state == eLSU_LOAD_WAIT_0) begin
            curr_state       = eLSU_LOAD_WAIT_1;
            alu_op_a_w       = 1'b0;
            imm_ext_w        = 0;
            lsu_ctrl_valid_w = 1'b0;
            lsu_ctrl_w       = 4'b0000;
            lsu_regdest_w    = 5'b00000;
        end
        else begin
            curr_state       = eLSU_LOAD_WAIT_2;
            alu_op_a_w       = 1'b0;
            imm_ext_w        = 0;
            lsu_ctrl_valid_w = 1'b0;
            lsu_ctrl_w       = 4'b0000;
            lsu_regdest_w    = 5'b00000;
        end
    end

    {1'b1, OPCODE_MISCMEM}: begin 
        curr_state = eOK;
    end

    {1'b1, OPCODE_OPIMM}: begin
        is_alu_write_w     = 1'b1;
        alu_op_a_w         = 1'b1;
        alu_dest_addr_w    = regdest;
        rf_addr_a_w        = regs1;
        if (funct3 == FUNCT3_SHIFT_INSTR && 
           (imm11_0[31:25] == 0 || imm11_0[31:25] == 7'b0100000)) begin
            imm_ext_w = I_shift_imm_sign_extended_w;
            alu_sel_w = {instr_i[30], funct3};
        end
        else begin
            imm_ext_w = I_imm_sign_extended_w;
            alu_sel_w = {1'b0, funct3};
        end
        if (regs1 == prev_dest_addr && regs1 != 0 && prev_state != eSTALL) begin
            curr_state = eSTALL;
            alu_wb_w   = 1'b0; 
        end
        else begin
            curr_state = eOK;
            alu_wb_w   = 1'b1; 
        end
    end

    {1'b1, OPCODE_AUIPC}: begin
        use_pc_w           = 1'b1;
        is_alu_write_w     = 1'b1;
        alu_sel_w          = ALU_OP_ADD;
        alu_op_a_w         = 1'b1;
        alu_dest_addr_w    = regdest;
        alu_wb_w           = 1'b1; 
        imm_ext_w          = {imm31_12, 12'b0000_0000_0000};
        curr_state         = eOK;
    end

    {1'b1, OPCODE_STORE}: begin
        alu_sel_w          = ALU_OP_ADD;
        rf_addr_a_w        = regs1;
        rf_addr_b_w        = regs2;
        if (((regs1 == prev_dest_addr && regs1 != 0) ||
             (regs2 == prev_dest_addr && regs2 != 0)) && 
              (prev_state != eSTALL && 
              prev_state != eLSU_CALC_ADDR)) begin
            curr_state       = eSTALL;
            alu_op_a_w       = 1'b0;
            alu_op_b_w       = 1'b0;
            imm_ext_w        = 0;
            lsu_ctrl_valid_w = 1'b0;
            lsu_ctrl_w       = 4'b0000;
        end
        else if (prev_state != eLSU_CALC_ADDR) begin
            curr_state      = eLSU_CALC_ADDR;
            alu_op_a_w      = 1'b1;
            alu_op_b_w      = 1'b0;
            imm_ext_w       = S_imm_sign_extended_w;
            lsu_ctrl_valid_w = 1'b0;
            lsu_ctrl_w       = 4'b0000;
        end
        else begin
            curr_state       = eLSU_STORE;
            alu_op_a_w       = 1'b0;
            alu_op_b_w       = 1'b1;
            imm_ext_w        = 0;
            lsu_ctrl_valid_w = 1'b1;
            lsu_ctrl_w       = {opcode[5], funct3};
        end
    end
    
    {1'b1, OPCODE_OP}: begin
        is_alu_write_w     = 1'b1;
        alu_sel_w          = {instr_i[30], funct3};
        alu_op_a_w         = 1'b1;
        alu_op_b_w         = 1'b1;
        alu_dest_addr_w    = regdest;
        rf_addr_a_w        = regs1;
        rf_addr_b_w        = regs2;
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

    {1'b1, OPCODE_LUI}: begin
        is_alu_write_w     = 1'b1;
        alu_sel_w          = ALU_OP_ADD;
        alu_op_a_w         = 1'b1;
        alu_dest_addr_w    = regdest;
        alu_wb_w           = 1'b1; 
        imm_ext_w          = {imm31_12, 12'b0000_0000_0000};
        curr_state         = eOK;
    end

    {1'b1, OPCODE_BRANCH}: begin
        // First cycle of all branch instructions calcules the condition, 
        // the second cycle calculates the jump address, the third cycle
        // stalls and finally if the condition holds, the fourth cycle jumps
        // the fifth cycle is another stall.
        if (((regs1 == prev_dest_addr && regs1 != 0 ) || 
            (regs2 == prev_dest_addr && regs2 != 0 )) &&
             prev_state != eBRANCH_CALC_COND &&
             prev_state != eBRANCH_CALC_ADDR &&
             prev_state != eBRANCH_STALL &&
             prev_state != eBRANCH_JUMP &&
             prev_state != eBRANCH_STALL_2 &&
             prev_state != eSTALL) begin
            use_alu_jmp_addr_w = 1'b0;
            use_pc_w           = 1'b0;
            alu_sel_w          = 4'b0000;
            alu_op_a_w         = 1'b0;
            alu_op_b_w         = 1'b0;
            rf_addr_a_w        = 5'b00000;
            rf_addr_b_w        = 5'b00000;
            imm_ext_w          = 0;   
            curr_state         = eSTALL;
        end
        else if (prev_state != eBRANCH_CALC_COND &&
                 prev_state != eBRANCH_CALC_ADDR &&
                 prev_state != eBRANCH_STALL &&
                 prev_state != eBRANCH_JUMP &&
                 prev_state != eBRANCH_STALL_2) begin
            use_alu_jmp_addr_w = 1'b0;
            use_pc_w           = 1'b0;
            alu_sel_w          = {2'b00, funct3[14:13]};
            alu_op_a_w         = 1'b1;
            alu_op_b_w         = 1'b1;
            if (funct3[12] == 1'b0) begin 
                rf_addr_a_w = regs1;
                rf_addr_b_w = regs2;
            end
            else begin
                rf_addr_a_w = regs2;
                rf_addr_b_w = regs1;
            end
            imm_ext_w          = 0;   
            curr_state         = eBRANCH_CALC_COND;
        end
        else if (prev_state == eBRANCH_CALC_COND) begin
            use_alu_jmp_addr_w = 1'b0;
            use_pc_w           = 1'b1;
            alu_sel_w          = ALU_OP_ADD;
            alu_op_a_w         = 1'b0;
            alu_op_b_w         = 1'b0;
            rf_addr_a_w        = regs1;
            rf_addr_b_w        = regs2;
            imm_ext_w          = B_imm_sign_extended_w;   
            curr_state         = eBRANCH_CALC_ADDR;
        end
        else if (prev_state == eBRANCH_CALC_ADDR) begin
            use_alu_jmp_addr_w = 1'b0;
            use_pc_w           = 1'b1;
            alu_sel_w          = ALU_OP_ADD;
            alu_op_a_w         = 1'b0;
            alu_op_b_w         = 1'b0;
            rf_addr_a_w        = regs1;
            rf_addr_b_w        = regs2;
            imm_ext_w          = B_imm_sign_extended_w; 
            if (funct3 != 3'b000 && funct3 != 3'b001 && alu_res_i == 1 ||
               ((funct3 == 3'b101 || funct3 == 3'b111) && alu_ops_eq_i == 1'b1) ||
               (funct3 == 3'b000 && alu_ops_eq_i == 1'b1) ||
               (funct3 == 3'b001 && alu_ops_eq_i == 1'b0)) begin
                curr_state = eBRANCH_STALL;
            end
            else begin
                curr_state = eBRANCH_STALL_2;
            end
        end
        else if (prev_state == eBRANCH_STALL) begin
            use_alu_jmp_addr_w = 1'b1;
            use_pc_w           = 1'b0; 
            alu_sel_w          = 5'b00000;
            alu_op_a_w         = 1'b0;
            alu_op_b_w         = 1'b0;
            rf_addr_a_w        = 5'b00000;
            rf_addr_b_w        = 5'b00000;
            imm_ext_w          = 0;   
            curr_state         = eBRANCH_JUMP;
        end
        else begin
            use_alu_jmp_addr_w = 1'b0;
            use_pc_w           = 1'b0; 
            alu_sel_w          = 5'b00000;
            alu_op_a_w         = 1'b0;
            alu_op_b_w         = 1'b0;
            rf_addr_a_w        = 5'b00000;
            rf_addr_b_w        = 5'b00000;
            imm_ext_w          = 0;   
            curr_state         = eBRANCH_STALL_2;
        end
    end

    {1'b1, OPCODE_JALR}: begin
        // First cycle of JALR instr calculates pc+4 and stores it to rd,
        // in the next cycle the offset is calculated. This way stalls are
        // impossible, as we only use regs1 in the second cycle (instr can
        // be delayed at most 1 cycle). The third cycle takes the jump.
        is_alu_write_w     = 1'b1;
        alu_sel_w          = ALU_OP_ADD;
        if (prev_state != eJALR_PC_CALC &&
            prev_state != eJALR_JMP_ADDR_CALC &&
            prev_state != eJALR_JMP) begin
            use_alu_jmp_addr_w = 1'b0;
            use_pc_w           = 1'b1;
            alu_op_a_w         = 1'b0;
            alu_dest_addr_w    = regdest;
            alu_wb_w           = 1'b1; 
            rf_addr_a_w        = 5'b00000;
            imm_ext_w          = 32'b00000000_00000000_00000000_00000100;   
            curr_state         = eJALR_PC_CALC;
        end
        else if (prev_state == eJALR_PC_CALC) begin
            use_alu_jmp_addr_w = 1'b0;
            use_pc_w           = 1'b0; 
            alu_op_a_w         = 1'b1;
            alu_dest_addr_w    = 5'b00000;
            alu_wb_w           = 1'b0; 
            rf_addr_a_w        = regs1;
            imm_ext_w          = I_imm_sign_extended_w;   
            curr_state         = eJALR_JMP_ADDR_CALC;
        end
        else begin
            use_alu_jmp_addr_w = 1'b1;
            use_pc_w           = 1'b0; 
            alu_op_a_w         = 1'b0;
            alu_dest_addr_w    = 5'b00000;
            alu_wb_w           = 1'b0; 
            rf_addr_a_w        = 5'b00000;
            imm_ext_w          = I_imm_sign_extended_w;   
            curr_state         = eJALR_JMP;
        end

    end

    {1'b1, OPCODE_JAL}: begin
        use_pc_w           = 1'b1;
        is_alu_write_w     = 1'b1;
        alu_sel_w          = ALU_OP_ADD;
        alu_dest_addr_w    = regdest;
        alu_wb_w           = 1'b1; 
        imm_ext_w          = 32'b00000000_00000000_00000000_00000100;   
        if (prev_state != eJAL &&
            prev_state != eJAL_WAIT_1 &&
            prev_state != eJAL_WAIT_2 &&
            instr_valid_i == 1'b0) begin
            curr_state = eSTALL;
        end
        else if (prev_state != eJAL &&
                 prev_state != eJAL_WAIT_1 &&
                 prev_state != eJAL_WAIT_2) begin
            curr_state = eJAL;
        end
        else if (prev_state == eJAL) begin
            curr_state = eJAL_WAIT_1;
        end
        else begin
            curr_state = eJAL_WAIT_2;
        end
    end

    {1'b1, OPCODE_SYSTEM}: begin
        curr_state = eOK;
    end

    {1'b0, 7'b???????}: begin
        illegal_instr_w    = 1'b1;
        curr_state         = eINSTR_NOT_VALID;
    end 

    default: begin
        use_alu_jmp_addr_w = 1'b0;
        use_pc_w           = 1'b0;
        illegal_instr_w    = 1'b0;
        is_alu_write_w     = 1'b0;
        alu_sel_w          = 4'b0000;
        alu_op_a_w         = 1'b0;
        alu_op_b_w         = 1'b0;
        alu_dest_addr_w    = 4'b0;
        alu_wb_w           = 1'b0; 
        rf_addr_a_w        = 5'b00000;
        rf_addr_b_w        = 5'b00000;
        imm_ext_w          = 0;   
        lsu_ctrl_valid_w   = 1'b0;
        lsu_ctrl_w         = 4'b0000;
        lsu_regdest_w      = 5'b00000;
        curr_state         = eERROR;
    end
  endcase
end

endmodule // jedro_1_decoder
