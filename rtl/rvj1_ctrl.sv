////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jure.vreca@ijs.si                             //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_ctrl                                                  //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    Controller for the rvj1 core.                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import rvj1_defines::*;

module rvj1_ctrl
(
  input logic clk_i,
  input logic rstn_i,

  input logic [RALEN-1:0] rf_addr_a_i,
  input logic [RALEN-1:0] rf_addr_b_i,
  input logic rpa_or_pc_i,
  input logic rpb_or_imm_i,
  input logic [RALEN-1:0] alu_regdest_r_i,

  output logic stall_dec_o,
  output logic stall_ex_o,
  output logic [XLEN-1:0] program_counter_o
);
  logic rf_a_hazard;
  logic rf_b_hazard;

  assign rf_a_hazard = (alu_regdest_r_i == rf_addr_a_i) && ~rpa_or_pc_i  && rf_addr_a_i != 5'b00000;
  assign rf_b_hazard = (alu_regdest_r_i == rf_addr_a_i) && ~rpb_or_imm_i && rf_addr_b_i != 5'b00000;
  assign stall_dec_o = rf_a_hazard || rf_b_hazard;
  assign stall_ex_o = 1'b0;
  assign program_counter_o = 32'h8000_0000;
endmodule
