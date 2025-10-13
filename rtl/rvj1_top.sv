////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_top                                                   //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The top file of the rvj1 riscv core.                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import rvj1_defines::*;

module rvj1_top
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
  logic [XLEN-1:0]  rf_alu_data_b_r;

  logic [XLEN-1:0] alu_op_a_data;
  logic [XLEN-1:0] alu_op_b_data;
  logic [XLEN-1:0] alu_res;
  logic [XLEN-1:0] alu_res_r;

  logic [XLEN-1:0]  program_counter;
  logic             stall;
  logic             instr_issued;
  logic             jmp_addr_valid;
  logic [XLEN-1:0]  jmp_addr;
  logic             lsu_ready;
  logic [RALEN-1:0] wpc_addr;
  logic [XLEN-1:0]  wpc_data;
  logic             wpc_we;
  logic [RALEN-1:0] rf_dest;
  logic [XLEN-1:0]  rf_data;
  logic             rf_wb;
  logic             jump;
  logic             jump_r;
  logic             flush;
  logic             ctrl_branch;
  branch_ctrl_e     ctrl_branch_type;

  /****************************************
  * INSTRUCTION FETCH STAGE
  ****************************************/
  rvj1_ifu ifu_inst(
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

    .jmp_addr_valid_i   (jmp_addr_valid),
    .jmp_addr_i         (jmp_addr),

    .ctrl_insn_misalign_exception_o (),
    .ctrl_fault_addr_o              ()
  );


  /****************************************
  * INSTRUCTION DECODE STAGE
  ****************************************/
  rvj1_dec decoder_inst(
    .clk_i               (clk_i),
    .rstn_i              (rstn_i && ~flush),
    .ifu_instr_i         (fetched_instr),
    .ifu_valid_i         (fetched_instr_valid),
    .ifu_ready_o         (dec_ready),
    .stall_i             (stall),
    .instr_issued_o      (instr_issued),
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
    .lsu_regdest_o       (lsu_regdest),
    .ctrl_jump_o         (jump),
    .ctrl_branch_o       (ctrl_branch),
    .ctrl_branch_type_o  (ctrl_branch_type)
  );

  /*********************************************
  * INSTRUCTION EXECUTE STAGE - ALU/REGFILE/MUX
  *********************************************/

  rvj1_regfile regfile_inst(
    .clk_i      (clk_i),
    .rstn_i     (rstn_i),
    .rpa_addr_i (rf_addr_a),
    .rpa_data_o (rf_alu_data_a),
    .rpb_addr_i (rf_addr_b),
    .rpb_data_o (rf_alu_data_b),
    .wpc_addr_i (wpc_addr),
    .wpc_data_i (wpc_data),
    .wpc_we_i   (wpc_we)
  );

  assign alu_op_a_data = rpa_or_pc  ? program_counter : rf_alu_data_a;
  assign alu_op_b_data = rpb_or_imm ? immediate       : rf_alu_data_b;

  rvj1_alu alu_inst(
    .clk_i  (clk_i),
    .sel_i  (alu_op_sel),
    .op_a_i (alu_op_a_data),
    .op_b_i (alu_op_b_data),
    .res_o  (alu_res)
  );

  pipeline_register #(
    .WORD_WIDTH  (1 + RALEN + XLEN + 1 + $bits(lsu_ctrl_e) + RALEN + XLEN + 1),
    .RESET_VALUE (0)
  ) ex_mem_stage_reg (
    .clk  (clk_i),
    .ce   (~stall),
    .in   ({alu_write_rf,   alu_regdest,   alu_res,   lsu_ctrl_valid,   lsu_ctrl,   lsu_regdest,   rf_alu_data_b, jump}),
    .out  ({alu_write_rf_r, alu_regdest_r, alu_res_r, lsu_ctrl_valid_r, lsu_ctrl_r, lsu_regdest_r, rf_alu_data_b_r, jump_r})
  );

  /*********************************************
  * MEMORY ACCESS STAGE
  *********************************************/
  rvj1_lsu lsu_inst(
    .clk_i                   (clk_i),
    .rstn_i                  (rstn_i),
    .lsu_valid_i             (lsu_ctrl_valid_r),
    .lsu_ready_o             (lsu_ready),
    .lsu_cmd_i               (lsu_ctrl_r),
    .lsu_addr_i              (alu_res_r),
    .lsu_data_i              (rf_alu_data_b_r),
    .lsu_regdest_i           (lsu_regdest_r),
    .rf_data_o               (rf_data),
    .rf_wb_o                 (rf_wb),
    .rf_dest_o               (rf_dest),
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
  assign wpc_addr = rf_wb ? rf_dest : alu_regdest_r;
  assign wpc_we   = rf_wb || alu_write_rf_r || jump_r;
  assign wpc_data = jump_r ? program_counter : (rf_wb ? rf_data : alu_res_r);

  /*********************************************
  * CONTROLLER
  *********************************************/
  rvj1_ctrl ctrl_inst(
    .clk_i             (clk_i),
    .rstn_i            (rstn_i),
    .rf_addr_a_i       (rf_addr_a),
    .rf_addr_b_i       (rf_addr_b),
    .rpa_or_pc_i       (rpa_or_pc),
    .rpb_or_imm_i      (rpb_or_imm),
    .alu_regdest_r_i   (alu_regdest_r),
    .lsu_cmd_i         (lsu_ctrl),
    .lsu_ctrl_valid_i  (lsu_ctrl_valid),
    .lsu_ready_i       (lsu_ready),
    .ctrl_jump_i       (jump),
    .alu_res_i         (alu_res_r),
    .ctrl_branch_i     (ctrl_branch),
    .ctrl_branch_type_i(ctrl_branch_type),
    .instr_issued_i    (instr_issued),
    .stall_o           (stall),
    .program_counter_o (program_counter),
    .flush_o           (flush),
    .jmp_addr_valid_o  (jmp_addr_valid),
    .jmp_addr_o        (jmp_addr)
  );
endmodule
