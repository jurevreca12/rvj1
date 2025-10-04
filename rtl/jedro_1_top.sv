////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_top                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The top file of the jedro_1 riscv core.                    //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import jedro_1_defines::*;

module jedro_1_top
(
  input logic clk_i,
  input logic rstn_i,

  // Interface to instr memory
  output logic [XLEN-1:0]   instr_req_addr_o,
  output logic [XLEN-1:0]   instr_req_data_o,
  output logic [NBYTES-1:0] instr_req_strobe_o,
  output logic              instr_req_write_o,
  output logic              instr_req_valid_o,
  input  logic              instr_req_ready_i,

  input  logic [XLEN-1:0] instr_rsp_data_i,
  input  logic            instr_rsp_error_i,
  input  logic            instr_rsp_valid_i,
  output logic            instr_rsp_ready_o,

  // Interface to data memory
  output logic [XLEN-1:0]   data_req_addr_o,
  output logic [XLEN-1:0]   data_req_data_o,
  output logic [NBYTES-1:0] data_req_strobe_o,
  output logic              data_req_write_o,
  output logic              data_req_valid_o,
  input  logic              data_req_ready_i,

  input  logic [XLEN-1:0] data_rsp_data_i,
  input  logic            data_rsp_error_i,
  input  logic            data_rsp_valid_i,
  output logic            data_rsp_ready_o



 // IRQ/Debug interface TODO

);

  /****************************************
  * SIGNAL DECLARATION
  ****************************************/
  logic             fetched_instr_valid;
  logic [XLEN-1:0]  fetched_instr;
  logic             dec_ready;
  logic [RALEN-1:0] rf_addr_a;
  logic [RALEN-1:0] rf_addr_b;
  alu_op_e          alu_op_sel;
  logic             rpa_or_pc;
  logic             rpb_or_imm;
  logic             alu_write_rf;
  logic             alu_write_rf_r;
  logic [RALEN-1:0] alu_regdest;
  logic [RALEN-1:0] alu_regdest_r;
  logic [XLEN-1:0]  immediate;
  logic             lsu_ctrl_valid;
  logic             lsu_ctrl_valid_r;
  lsu_ctrl_e        lsu_ctrl;
  lsu_ctrl_e        lsu_ctrl_r;
  logic [RALEN-1:0] lsu_regdest;
  logic [RALEN-1:0] lsu_regdest_r;
  logic [XLEN-1:0]  rf_alu_data_a;
  logic [XLEN-1:0]  rf_alu_data_b;

  logic [XLEN-1:0] alu_op_a_data;
  logic [XLEN-1:0] alu_op_b_data;
  logic [XLEN-1:0] program_counter;

  logic [XLEN-1:0] alu_res;

  assign program_counter = 32'h8000_0000; // TODO

  /****************************************
  * INSTRUCTION FETCH STAGE
  ****************************************/
  jedro_1_ifu ifu_inst(
    .clk_i              (clk_i),
    .rstn_i             (rstn_i),
    .instr_req_addr_o   (instr_req_addr_o),
    .instr_req_data_o   (instr_req_data_o),
    .instr_req_strobe_o (instr_req_strobe_o),
    .instr_req_write_o  (instr_req_write_o),
    .instr_req_valid_o  (instr_req_valid_o),
    .instr_req_ready_i  (instr_req_ready_i),

    .instr_rsp_data_i   (instr_rsp_data_i),
    .instr_rsp_error_i  (instr_rsp_error_i),
    .instr_rsp_valid_i  (instr_rsp_valid_i),
    .instr_rsp_ready_o  (instr_rsp_ready_o),

    .dec_instr_o        (fetched_instr),
    .dec_valid_o        (fetched_instr_valid),
    .dec_ready_i        (dec_ready),

    .jmp_addr_valid_i   (1'b0),  // TODO
    .jmp_addr_i         (32'b0),

    .ctrl_insn_misalign_exception_o (),
    .ctrl_fault_addr_o              ()
  );


  /****************************************
  * INSTRUCTION DECODE STAGE
  ****************************************/
  jedro_1_decoder decoder_inst(
    .clk_i               (clk_i),
    .rstn_i              (rstn_i),
    .ifu_instr_i         (fetched_instr),
    .ifu_valid_i         (fetched_instr_valid),
    .ifu_ready_o         (dec_ready),
    .rf_addr_a_o         (rf_addr_a),
    .rf_addr_b_o         (rf_addr_b),
    .alu_sel_o           (alu_op_sel),
    .rpa_or_pc_o         (rpa_or_pc),
    .rpb_or_imm_o        (rpb_or_imm),
    .alu_write_rf_o      (alu_write_rf),
    .alu_regdest_o       (alu_regdest),
    .immediate_o         (immediate),
    .lsu_ctrl_valid_o    (lsu_ctrl_valid),
    .lsu_ctrl_o          (lsu_ctrl),
    .lsu_regdest_o       (lsu_regdest)
  );

  /*********************************************
  * INSTRUCTION EXECUTE STAGE - ALU/REGFILE/MUX
  *********************************************/
  jedro_1_regfile regfile_inst(
    .clk_i      (clk_i),
    .rstn_i     (rstn_i),
    .rpa_addr_i (rf_addr_a),
    .rpa_data_o (rf_alu_data_a),
    .rpb_addr_i (rf_addr_b),
    .rpb_data_o (rf_alu_data_b),
    .wpc_addr_i (alu_regdest_r),
    .wpc_data_i (alu_res),
    .wpc_we_i   (alu_write_rf_r)
  );

  assign alu_op_a_data = rpa_or_pc  ? rf_alu_data_a : program_counter;
  assign alu_op_b_data = rpb_or_imm ? rf_alu_data_b : immediate;

  jedro_1_alu alu_inst(
    .clk_i  (clk_i),
    .rstn_i (rstn_i),
    .sel_i  (alu_op_sel),
    .op_a_i (rpa_or_pc),
    .op_b_i (rpb_or_imm),
    .res_o  (alu_res)
  );

  register #(
    .WORD_WIDTH  (1 + RALEN + 1 + $bits(lsu_ctrl_e) + RALEN),
    .RESET_VALUE (0)
  ) ex_mem_stage_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (1'b1),
    .in   ({alu_write_rf,   alu_regdest,   lsu_ctrl_valid,   lsu_ctrl,   lsu_regdest}),
    .out  ({alu_write_rf_r, alu_regdest_r, lsu_ctrl_valid_r, lsu_ctrl_r, lsu_regdest_r})
  );

  /*********************************************
  * MEMORY ACCESS STAGE
  *********************************************/
  jedro_1_lsu lsu_inst(
    .clk_i                   (clk_i),
    .rstn_i                  (rstn_i),
    .lsu_valid_i             (lsu_ctrl_valid_r),
    .lsu_ready_o             (),
    .lsu_cmd_i               (lsu_ctrl_r),
    .lsu_addr_i              (),
    .lsu_data_i              (),
    .lsu_regdest_i           (lsu_regdest_r),
    .rf_data_o               (),
    .rf_wb_o                 (),
    .rf_dest_o               (),
    .ctrl_misaligned_load_o  (),
    .ctrl_misaligned_store_o (),
    .ctrl_bus_error_o        (),
    .ctrl_exception_addr_o   (),
    .data_req_addr_o         (data_req_addr_o),
    .data_req_data_o         (data_req_data_o),
    .data_req_strobe_o       (data_req_strobe_o),
    .data_req_write_o        (data_req_write_o),
    .data_req_valid_o        (data_req_valid_o),
    .data_req_ready_i        (data_req_ready_i),
    .data_rsp_data_i         (data_rsp_data_i),
    .data_rsp_error_i        (data_rsp_error_i),
    .data_rsp_valid_i        (data_rsp_valid_i),
    .data_rsp_ready_o        (data_rsp_ready_o)
  );


  /*********************************************
  * WRITEBACK STAGE
  *********************************************/


endmodule
