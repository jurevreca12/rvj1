////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_alu                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The arithmetic logic unit is defined here.                 //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import jedro_1_defines::*;

module jedro_1_alu (
    input logic clk_i,
    input logic rstn_i,

    input alu_op_e sel_i,  // select arithmetic operation

    input  logic [XLEN-1:0]  op_a_i,
    input  logic [XLEN-1:0]  op_b_i,
    output logic [XLEN-1:0]  res_o
);

  /*******************************
  * ARITHMETIC CIRCUITS
  *******************************/
  // less-than unsigned
  function automatic logic [XLEN-1:0] ltu(input logic [XLEN-1:0] a, input logic [XLEN-1:0] b);
  begin
      logic lt;
      assign lt = a < b;
      return {{(XLEN-1){1'b0}}, lt};
  end
  endfunction
  // less-than signed
  function automatic logic [XLEN-1:0] lts(input logic [XLEN-1:0] a, input logic [XLEN-1:0] b);
  begin
      logic lt;
      logic [XLEN-2:0] res_abs;
      logic [XLEN-1:0] ret;

      assign lt = a < b;
      res_abs = {{(XLEN-2){1'b0}}, lt};
      unique case ({a[XLEN-1], b[XLEN-1]})
        2'b00:   ret = {1'b0, res_abs};
        2'b10:   ret = 32'b11111111_11111111_11111111_11111111;
        2'b01:   ret = 32'b0;
        default: ret = {1'b0, res_abs};
      endcase
      return ret;
  end
  endfunction


  /*******************************
  * RESULT MUXING
  *******************************/
  always_ff @(posedge clk_i) begin
    res_o <= 32'b0;
    unique case (sel_i)
      ALU_OP_ADD:  res_o <= op_a_i +  op_b_i;
      ALU_OP_SUB:  res_o <= op_a_i -  op_b_i;
      ALU_OP_XOR:  res_o <= op_a_i ^  op_b_i;
      ALU_OP_OR:   res_o <= op_a_i |  op_b_i;
      ALU_OP_AND:  res_o <= op_a_i &  op_b_i;
      ALU_OP_SLL:  res_o <= op_a_i << op_b_i;
      ALU_OP_SLT:  res_o <= lts(op_a_i, op_b_i);
      ALU_OP_SLTU: res_o <= ltu(op_a_i, op_b_i);
      ALU_OP_SRL:  res_o <= op_a_i >>  op_b_i;
      ALU_OP_SRA:  res_o <= op_a_i >>> op_b_i;
    endcase
  end

endmodule

