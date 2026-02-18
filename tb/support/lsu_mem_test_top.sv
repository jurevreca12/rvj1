////////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                             //
//                                                                                //
//                                                                                //
//                                                                                //
// Design Name:    rvj1_ifu                                                       //
// Project Name:   riscv-jedro-1                                                  //
// Language:       System Verilog                                                 //
//                                                                                //
// Description:    The LSU test module.                                           //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////

/* verilator lint_off IMPORTSTAR */
import rvj1_defines::*;

module lsu_mem_test_top #(
    parameter int BASE_ADDR = 32'h8000_0000,
    parameter int MEM_SIZE_WORDS = 1 << 10
) (
    input  logic             clk_i,
    input  logic             rstn_i,

    // Interface to/from the decoder/ALU/ctrl
    input  logic             lsu_valid_i,
    output logic             lsu_ready_o,
    input  lsu_ctrl_e        lsu_cmd_i,
    input  logic [XLEN-1:0]  lsu_addr_i,
    input  logic [XLEN-1:0]  lsu_data_i,
    input  logic [RALEN-1:0] lsu_regdest_i,

    // Interface to the register file
    output logic [XLEN-1:0]  rf_data_o,
    output logic             rf_wb_o,    // write-back
    output logic [RALEN-1:0] rf_dest_o,

    // Interface to the core controller
    output logic             exc_load_addr_misaligned_o,
    output logic             exc_load_access_fault_o,
    output logic             exc_store_addr_misaligned_o,
    output logic             exc_store_access_fault_o,
    output logic [XLEN-1:0]  exc_addr_o
);

    logic [XLEN-1:0]   data_req_addr;
    logic [XLEN-1:0]   data_req_data;
    logic [NBYTES-1:0] data_req_strobe;
    logic              data_req_write;
    logic              data_req_valid;
    logic              data_req_ready;

    logic              data_ctrl_cancel;

    logic [XLEN-1:0]   data_rsp_data;
    logic              data_rsp_error;
    logic              data_rsp_valid;
    logic              data_rsp_ready;

    rvj1_lsu lsu_inst (
        .clk_i                      (clk_i),
        .rstn_i                     (rstn_i),

        .lsu_valid_i                (lsu_valid_i),
        .lsu_ready_o                (lsu_ready_o),
        .lsu_cmd_i                  (lsu_cmd_i),
        .lsu_addr_i                 (lsu_addr_i),
        .lsu_data_i                 (lsu_data_i),
        .lsu_regdest_i              (lsu_regdest_i),

        .rf_data_o                  (rf_data_o),
        .rf_wb_o                    (rf_wb_o),    // write-back
        .rf_dest_o                  (rf_dest_o),

        .exc_load_addr_misaligned_o (exc_load_addr_misaligned_o ),
        .exc_load_access_fault_o    (exc_load_access_fault_o    ),
        .exc_store_addr_misaligned_o(exc_store_addr_misaligned_o),
        .exc_store_access_fault_o   (exc_store_access_fault_o   ),
        .exc_addr_o                 (exc_addr_o                 ),

        .data_req_addr_o            (data_req_addr),
        .data_req_data_o            (data_req_data),
        .data_req_strobe_o          (data_req_strobe),
        .data_req_write_o           (data_req_write),
        .data_req_valid_o           (data_req_valid),
        .data_req_ready_i           (data_req_ready),

        .data_ctrl_cancel_o         (data_ctrl_cancel),

        .data_rsp_data_i            (data_rsp_data),
        .data_rsp_error_i           (data_rsp_error),
        .data_rsp_valid_i           (data_rsp_valid),
        .data_rsp_ready_o           (data_rsp_ready)
    );

    bytewrite_sram_wrap #(
      .IMEM_BASE_ADDR(BASE_ADDR),
      .DMEM_BASE_ADDR(BASE_ADDR),
      .IMEM_SIZE_WORDS(MEM_SIZE_WORDS),
      .DMEM_SIZE_WORDS(MEM_SIZE_WORDS)
    ) main_mem (
        .clk_i    (clk_i),
        .rstn_i   (rstn_i),

        .instr_req_addr_i  ('0),
        .instr_req_data_i  ('0),
        .instr_req_strobe_i('0),
        .instr_req_write_i (1'b0),
        .instr_req_valid_i (1'b0),
        .instr_req_ready_o (),

        .instr_ctrl_cancel_i(1'b0),

        .instr_rsp_data_o  (),
        .instr_rsp_error_o (),
        .instr_rsp_valid_o (),
        .instr_rsp_ready_i (1'b0),

        .data_req_addr_i   (data_req_addr),
        .data_req_data_i   (data_req_data),
        .data_req_strobe_i (data_req_strobe),
        .data_req_write_i  (data_req_write),
        .data_req_valid_i  (data_req_valid),
        .data_req_ready_o  (data_req_ready),

        .data_ctrl_cancel_i(data_ctrl_cancel),

        .data_rsp_data_o   (data_rsp_data),
        .data_rsp_error_o  (data_rsp_error),
        .data_rsp_valid_o  (data_rsp_valid),
        .data_rsp_ready_i  (data_rsp_ready)
    );


endmodule
