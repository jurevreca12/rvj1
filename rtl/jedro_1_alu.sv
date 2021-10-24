////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_alu                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The arithmetic logic unit is defined here.                 //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import jedro_1_defines::*;

module jedro_1_alu
(
  input logic clk_i,
  input logic rstn_i,

  input logic [ALU_OP_WIDTH-1:0]   sel_i, // select arithmetic operation

  input logic [DATA_WIDTH-1:0]     op_a_i,
  input logic [DATA_WIDTH-1:0]     op_b_i,
  output logic [DATA_WIDTH-1:0]    res_ro,
  output logic                     overflow_ro,

  input logic [REG_ADDR_WIDTH-1:0]  dest_addr_i,
  output logic [REG_ADDR_WIDTH-1:0] dest_addr_ro,
  
  input  logic wb_i,
  output logic wb_ro
);

/*******************************
* SIGNAL DECLARATION
*******************************/
logic [DATA_WIDTH-1:0] adder_res;
logic [DATA_WIDTH-1:0] and_res;
logic [DATA_WIDTH-1:0] or_res;
logic [DATA_WIDTH-1:0] xor_res;
logic [DATA_WIDTH-1:0] less_than_sign_res;
logic [DATA_WIDTH-1:0] less_than_unsign_res;
logic [DATA_WIDTH-1:0] shifter_right_res;
logic [DATA_WIDTH-1:0] shifter_left_res;
logic adder_overflow;

logic [DATA_WIDTH-1:0] res_mux;


/*******************************
* RESULT BUFFERING
*******************************/
always_ff@(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    overflow_ro <= 0;
    res_ro <= 0;
  end
  else begin
    overflow_ro <= adder_overflow;
    res_ro <= res_mux;
  end
end


/*******************************
* GO-THROUGH SIGNAL BUFFERING
*******************************/
always_ff@(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    wb_ro <= 0;
    dest_addr_ro <= 0; 
  end
  else begin
    wb_ro <= wb_i; 
    dest_addr_ro <= dest_addr_i; 
  end
end


/*******************************
* ARITHMETIC CIRCUITS
*******************************/
// ripple-carry adder
ripple_carry_adder_Nb #(.N(DATA_WIDTH)) ripple_carry_adder_32b_inst (
  .carry_i (1'b0),
  .opa_i   (op_a_i),
  .opb_i   (op_b_i),
  .inv_b_i (sel_i[3]),
  .res_o  (adder_res),
  .carry_o (adder_overflow)
);

assign and_res = op_a_i & op_b_i; // and
assign or_res = op_a_i | op_b_i;  // or
assign xor_res = op_a_i ^ op_b_i; // xor

// compare modules
less_than_sign_Nb #(.N(DATA_WIDTH)) less_than_sign_32b_inst
(
  .a (op_a_i),
  .b (op_b_i),
  .r (less_than_sign_res)
);
less_than_unsign_Nb #(.N(DATA_WIDTH)) less_than_unsign_32b_inst
(
  .a (op_a_i),
  .b (op_b_i),
  .r (less_than_unsign_res)
);

// shifters
barrel_shifter_left_32b shifter_left_32b_inst
(
  .in    (op_a_i),
  .cntrl (op_b_i[5-1:0]),
  .out   (shifter_left_res)
);
barrel_shifter_right_32b shifter_right_32b_inst
(
  .in    (op_a_i),
  .cntrl (op_b_i[5-1:0]),
  .arith (sel_i[3]),   // Last bit of alu_op_sel_i selects between SRL and SRA instrucitons.
  .out   (shifter_right_res)
);


/*******************************
* RESULT MUXING
*******************************/
always_comb
begin
  case (sel_i)
    ALU_OP_ADD: begin
      res_mux <= adder_res; 
    end

    ALU_OP_SUB: begin
      res_mux <= adder_res;
    end

    ALU_OP_SLL: begin
      res_mux <= shifter_left_res; 
    end

    ALU_OP_SLT: begin
      res_mux <= less_than_sign_res;
    end

    ALU_OP_SLTU: begin
      res_mux <= less_than_unsign_res;
    end

    ALU_OP_XOR: begin
      res_mux <= xor_res;
    end

    ALU_OP_SRL: begin
      res_mux <= shifter_right_res;
    end

    ALU_OP_SRA: begin
      res_mux <= shifter_right_res;
    end

    ALU_OP_OR: begin
      res_mux <= or_res;
    end

    ALU_OP_AND: begin
      res_mux <= and_res; 
    end

    default: begin 
      res_mux <= 32'b0;
    end
  endcase
end

endmodule : jedro_1_alu

