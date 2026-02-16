////////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                             //
//                                                                                //
//                                                                                //
//                                                                                //
// Design Name:    rvj1_ifu                                                       //
// Project Name:   riscv-jedro-1                                                  //
// Language:       System Verilog                                                 //
//                                                                                //
// Description:    The instruction fetch unit test module.                        //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////

/* verilator lint_off IMPORTSTAR */
import rvj1_defines::*;

module ifu_mem_test_top (
    input  logic            clk_i,
    input  logic            rstn_i,

    output logic [XLEN-1:0] dec_instr_o,
    output logic            dec_valid_o,
    input  logic            dec_ready_i,

    input  logic            jmp_addr_valid_i,
    input  logic [XLEN-1:0] jmp_addr_i,

    output logic            instr_fetch_err_o,
    output logic [XLEN-1:0] instr_fault_addr_o
);
    localparam int BaseAddr = 32'h8000_0000;
    localparam int MemSizeWords = 1 << 10;

    logic [XLEN-1:0]   instr_req_addr;
    logic [XLEN-1:0]   instr_req_data;
    logic [NBYTES-1:0] instr_req_strobe;
    logic              instr_req_write;
    logic              instr_req_valid;
    logic              instr_req_ready;

    logic              instr_ctrl_cancel;

    logic [XLEN-1:0]   instr_rsp_data;
    logic              instr_rsp_error;
    logic              instr_rsp_valid;
    logic              instr_rsp_ready;

    rvj1_ifu ifu_instr(
        .clk_i  (clk_i),
        .rstn_i (rstn_i),

        .instr_req_addr_o   (instr_req_addr),
        .instr_req_data_o   (instr_req_data),
        .instr_req_strobe_o (instr_req_strobe),
        .instr_req_write_o  (instr_req_write),
        .instr_req_valid_o  (instr_req_valid),
        .instr_req_ready_i  (instr_req_ready),

        .instr_ctrl_cancel_o(instr_ctrl_cancel),

        .instr_rsp_data_i   (instr_rsp_data),
        .instr_rsp_error_i  (instr_rsp_error),
        .instr_rsp_valid_i  (instr_rsp_valid),
        .instr_rsp_ready_o  (instr_rsp_ready),

        .dec_instr_o       (dec_instr_o),
        .dec_valid_o       (dec_valid_o),
        .dec_ready_i       (dec_ready_i),

        .jmp_addr_valid_i  (jmp_addr_valid_i),
        .jmp_addr_i        (jmp_addr_i),

        .instr_fetch_err_o (instr_fetch_err_o),

        .instr_fault_addr_o(instr_fault_addr_o)
    );

    bytewrite_sram_wrap #(
      .IMEM_BASE_ADDR(BaseAddr),
      .DMEM_BASE_ADDR(BaseAddr * 4),
      .IMEM_SIZE_WORDS(MemSizeWords),
      .DMEM_SIZE_WORDS(0)
    ) main_mem (
        .clk_i    (clk_i),
        .rstn_i   (rstn_i),

        .instr_req_addr_i  (instr_req_addr),
        .instr_req_data_i  (instr_req_data),
        .instr_req_strobe_i(instr_req_strobe),
        .instr_req_write_i (instr_req_write),
        .instr_req_valid_i (instr_req_valid),
        .instr_req_ready_o (instr_req_ready),

        .instr_ctrl_cancel_i(instr_ctrl_cancel),

        .instr_rsp_data_o  (instr_rsp_data),
        .instr_rsp_error_o (instr_rsp_error),
        .instr_rsp_valid_o (instr_rsp_valid),
        .instr_rsp_ready_i (instr_rsp_ready),

        .data_req_addr_i   ('0),
        .data_req_data_i   ('0),
        .data_req_strobe_i ('0),
        .data_req_write_i  (1'b0),
        .data_req_valid_i  (1'b0),
        .data_req_ready_o  (),

        .data_rsp_data_o   (),
        .data_rsp_error_o  (),
        .data_rsp_valid_o  (),
        .data_rsp_ready_i  (1'b0)
    );


endmodule
