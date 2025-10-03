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
logic             ifu_decoder_instr_valid;
logic [XLEN-1:0]  ifu_decoder_instr_addr;
logic [XLEN-1:0]  ifu_decoder_instr;
logic [XLEN-1:0]  mux3_ifu_jmp_addr;
logic             decoder_ifu_ready;
logic             decoder_ifu_jmp_instr;
logic [XLEN-1:0]  decoder_ifu_jmp_addr;
logic             decoder_mux3_use_alu_jmp_addr;
alu_op_e          decoder_alu_sel;
logic [RALEN-1:0] decoder_alu_dest_addr;
logic             decoder_alu_wb;
logic [RALEN-1:0] decoder_rf_addr_a;
logic [RALEN-1:0] decoder_rf_addr_b;
logic [XLEN-1:0]  decoder_mux_imm_ex;
logic             decoder_mux_is_imm;
logic [XLEN-1:0]  decoder_mux2_instr_addr;
logic [XLEN-1:0]  decoder_1_mux2_instr_addr;
logic             decoder_mux2_use_pc;
logic [XLEN-1:0]  alu_mux4_res;
logic [RALEN-1:0] alu_mux4_dest_addr;
logic             alu_mux4_wb;
logic             alu_overflow;
logic             alu_decoder_ops_eq;
logic [XLEN-1:0]  rf_alu_data_a;
logic [XLEN-1:0]  rf_alu_data_b;
logic [XLEN-1:0]  mux_alu_op_b;
logic [XLEN-1:0]  mux2_alu_op_a;
logic             decoder_lsu_ctrl_valid;
lsu_ctrl_e        decoder_lsu_ctrl;
logic [RALEN-1:0] decoder_lsu_regdest;
logic             decoder_1_mux4_is_alu_write;
logic             decoder_mux4_is_alu_write;
logic [XLEN-1:0]  lsu_mux4_rdata;
logic             lsu_mux4_wb;
logic [RALEN-1:0] lsu_mux4_regdest;
logic             lsu_csr_misaligned_load;
logic             lsu_csr_misaligned_store;
logic [XLEN-1:0]  lsu_csr_misaligned_addr;
logic             lsu_csr_bus_error;
logic [XLEN-1:0]  mux4_rf_data;
logic             mux4_rf_wb;
logic [RALEN-1:0] mux4_rf_dest_addr;
logic             csr_ifu_trap;
logic [XLEN-1:0]  csr_ifu_mtvec;
logic             ifu_csr_exception;
logic [XLEN-1:0]  ifu_csr_fault_addr;


/****************************************
* INSTRUCTION FETCH STAGE
****************************************/
jedro_1_ifu ifu_inst(.clk_i            (clk_i),
                     .rstn_i           (rstn_i),

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

                     .dec_instr_o      (ifu_decoder_instr),
                     .dec_pc_o         (ifu_decoder_instr_addr),
                     .dec_valid_o      (ifu_decoder_instr_valid),
                     .dec_ready_i      (decoder_ifu_ready),

                     .jmp_addr_valid_i (decoder_ifu_jmp_instr |
                                        decoder_mux3_use_alu_jmp_addr |
                                        csr_ifu_trap),
                     .jmp_addr_i       (mux3_ifu_jmp_addr),

                     .ctrl_insn_misalign_exception_o     (ifu_csr_exception),
                     .ctrl_fault_addr_o    (ifu_csr_fault_addr)
                     );


/****************************************
* INSTRUCTION DECODE STAGE
****************************************/
jedro_1_decoder decoder_inst(.clk_i               (clk_i),
                             .rstn_i              (rstn_i),
                             .instr_addr_i        (ifu_decoder_instr_addr),
                             .instr_addr_o        (decoder_mux2_instr_addr),
                             .use_pc_o            (decoder_mux2_use_pc),
                             .instr_i             (ifu_decoder_instr),
                             .instr_valid_i       (ifu_decoder_instr_valid),
                             .ready_o             (decoder_ifu_ready),
                             .jmp_instr_o         (decoder_ifu_jmp_instr),
                             .jmp_addr_o          (decoder_ifu_jmp_addr),
                             .use_alu_jmp_addr_o  (decoder_mux3_use_alu_jmp_addr),
                             .illegal_instr_o     (decoder_csr_illegal_instr),
                             .ecall_o             (decoder_csr_ecall),
                             .ebreak_o            (decoder_csr_ebreak),
                             .alu_is_write_o      (decoder_mux4_is_alu_write),
                             .alu_sel_o           (decoder_alu_sel),
                             .alu_dest_addr_o     (decoder_alu_dest_addr),
                             .alu_wb_o            (decoder_alu_wb),
                             .alu_res_i           (alu_mux4_res),
                             .alu_ops_eq_i        (alu_decoder_ops_eq),
                             .rf_addr_a_o         (decoder_rf_addr_a),
                             .rf_addr_b_o         (decoder_rf_addr_b),
                             .is_imm_o            (decoder_mux_is_imm),
                             .imm_ext_o           (decoder_mux_imm_ex),
                             .lsu_ctrl_valid_o    (decoder_lsu_ctrl_valid),
                             .lsu_ctrl_o          (decoder_lsu_ctrl),
                             .lsu_regdest_o       (decoder_lsu_regdest),
                             .lsu_read_complete_i (lsu_mux4_wb),
                           );


/*********************************************
* INSTRUCTION EXECUTE STAGE - ALU/REGFILE/MUX
*********************************************/
jedro_1_regfile  regfile_inst(.clk_i        (clk_i),
                              .rstn_i       (rstn_i),
                              .rpa_addr_i   (decoder_rf_addr_a),
                              .rpa_data_co  (rf_alu_data_a),
                              .rpb_addr_i   (decoder_rf_addr_b),
                              .rpb_data_co  (rf_alu_data_b),
                              .wpc_addr_i   (mux4_rf_dest_addr),
                              .wpc_data_i   (mux4_rf_data),
                              .wpc_we_i     (mux4_rf_wb)
                            );


jedro_1_alu alu_inst(.clk_i       (clk_i),
                     .rstn_i      (rstn_i),
                     .sel_i       (decoder_alu_sel),
                     .op_a_i      (mux2_alu_op_a),
                     .op_b_i      (mux_alu_op_b),
                     .res_ro      (alu_mux4_res),
                   );



/*********************************************
* MEMORY ACCESS STAGE
*********************************************/
jedro_1_lsu lsu_inst(.clk_i               (clk_i),
                     .rstn_i              (rstn_i),
                     .lsu_valid_i         (decoder_lsu_ctrl_valid),
                     .ctrl_i              (decoder_lsu_ctrl),
                     .addr_i              (alu_mux4_res),
                     .wdata_i             (rf_alu_data_b),
                     .rdata_o             (lsu_mux4_rdata),
                     .rf_wb_o             (lsu_mux4_wb),
                     .regdest_i           (decoder_lsu_regdest),
                     .rf_dest_o          (lsu_mux4_regdest),
                     .ctrl_misaligned_load_o  (lsu_csr_misaligned_load),
                     .ctrl_misaligned_store_o (lsu_csr_misaligned_store),
                     .ctrl_bus_error_o        (lsu_csr_bus_error),
                     .ctrl_exception_addr_o   (lsu_csr_misaligned_addr),

                     .data_req_addr_o     (data_req_addr_o),
                     .data_req_data_o     (data_req_data_o),
                     .data_req_strobe_o   (data_req_strobe_o),
                     .data_req_write_o    (data_req_write_o),
                     .data_req_valid_o    (data_req_valid_o),
                     .data_req_ready_i    (data_req_ready_i),

                     .data_rsp_data_i     (data_rsp_data_i),
                     .data_rsp_error_i    (data_rsp_error_i),
                     .data_rsp_valid_i    (data_rsp_valid_i),
                     .data_rsp_ready_o    (data_rsp_ready_o)
                    );


/*********************************************
* WRITEBACK STAGE
*********************************************/


endmodule
