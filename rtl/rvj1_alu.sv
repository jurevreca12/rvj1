////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_alu                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The arithmetic logic unit is defined here.                 //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import rvj1_defines::*;

module rvj1_alu (
    input logic clk_i,

    input alu_op_e sel_i,  // select arithmetic operation

    input  logic [XLEN-1:0]  op_a_i,
    input  logic [XLEN-1:0]  op_b_i,
    output logic [XLEN-1:0]  res_o
);

  /*******************************
  * ARITHMETIC CIRCUITS
  *******************************/
  logic [XLEN-1:0] ltu_res;
  logic [XLEN-1:0] lts_res;
  less_than_unsign_Nb #(.N(XLEN)) ltu (.a(op_a_i), .b(op_b_i), .r(ltu_res));
  less_than_sign_Nb   #(.N(XLEN)) lts (.a(op_a_i), .b(op_b_i), .r(lts_res));

  /*******************************
  * RESULT MUXING
  *******************************/
  always_comb begin
    res_o = 32'b0;
    unique case (sel_i)
      ALU_OP_ADD:  res_o = op_a_i +  op_b_i;
      ALU_OP_SUB:  res_o = op_a_i -  op_b_i;
      ALU_OP_XOR:  res_o = op_a_i ^  op_b_i;
      ALU_OP_OR:   res_o = op_a_i |  op_b_i;
      ALU_OP_AND:  res_o = op_a_i &  op_b_i;
      ALU_OP_SLT:  res_o = lts_res; //(op_a_i, op_b_i);
      ALU_OP_SLTU: res_o = ltu_res;
      ALU_OP_SLL:  res_o = op_a_i << op_b_i[4:0];
      ALU_OP_SRL:  res_o = op_a_i >> op_b_i[4:0];
      ALU_OP_SRA:  res_o = $signed(op_a_i) >>> op_b_i[4:0];
    endcase
  end

endmodule

