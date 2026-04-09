// The test used to simulate the core with the riscof test framework.


`include "rvfi_macros.sv"

module rvj1_test_top import rvj1_pkg::*;();
  parameter int IRAM_BASE_ADDR = 32'h8000_0000;
  parameter int IRAM_WORD_SIZE = 1 << 8;
  parameter int DRAM_BASE_ADDR = 32'h8000_0400;
  parameter int DRAM_WORD_SIZE = 1 << 8;

  logic clk;
  logic rstn;

  logic [XLEN-1:0]   instr_req_addr;
  logic [XLEN-1:0]   instr_req_data;
  logic [NBYTES-1:0] instr_req_strobe;
  logic              instr_req_write;
  logic [IDLEN-1:0]  instr_req_id;
  logic              instr_req_valid;
  logic              instr_req_ready;

  logic [XLEN-1:0]   instr_rsp_data;
  logic              instr_rsp_error;
  logic [IDLEN-1:0]  instr_rsp_id;
  logic              instr_rsp_valid;
  logic              instr_rsp_ready;


  logic [XLEN-1:0]   data_req_addr;
  logic [XLEN-1:0]   data_req_data;
  logic [NBYTES-1:0] data_req_strobe;
  logic              data_req_write;
  logic [IDLEN-1:0]  data_req_id;
  logic              data_req_valid;
  logic              data_req_ready;

  logic [XLEN-1:0]   data_rsp_data;
  logic              data_rsp_error;
  logic [IDLEN-1:0]  data_rsp_id;
  logic              data_rsp_valid;
  logic              data_rsp_ready;

  `ifdef RVFI
  `RVFI_WIRES
  `endif

    // instruction memory
    bytewrite_sram_wrap #(
      .IMEM_BASE_ADDR(IRAM_BASE_ADDR),
      .DMEM_BASE_ADDR(DRAM_BASE_ADDR),
      .IMEM_SIZE_WORDS(IRAM_WORD_SIZE),
      .DMEM_SIZE_WORDS(DRAM_WORD_SIZE),
      .IMEM_INIT_FILE_BIN(0),
      .DMEM_INIT_FILE_BIN(0),
      .IMEM_INIT_FILE(""),
      .DMEM_INIT_FILE("")
    ) main_mem (
        .clk_i    (clk),
        .rstn_i   (rstn),

        .instr_req_addr_i  (instr_req_addr),
        .instr_req_data_i  (instr_req_data),
        .instr_req_strobe_i(instr_req_strobe),
        .instr_req_write_i (instr_req_write),
        .instr_req_id_i    (instr_req_id),
        .instr_req_valid_i (instr_req_valid),
        .instr_req_ready_o (instr_req_ready),

        .instr_rsp_data_o  (instr_rsp_data),
        .instr_rsp_error_o (instr_rsp_error),
        .instr_rsp_id_o    (instr_rsp_id),
        .instr_rsp_valid_o (instr_rsp_valid),
        .instr_rsp_ready_i (instr_rsp_ready),


        .data_req_addr_i   (data_req_addr),
        .data_req_data_i   (data_req_data),
        .data_req_strobe_i (data_req_strobe),
        .data_req_write_i  (data_req_write),
        .data_req_id_i     (data_req_id),
        .data_req_valid_i  (data_req_valid),
        .data_req_ready_o  (data_req_ready),

        .data_rsp_data_o   (data_rsp_data),
        .data_rsp_error_o  (data_rsp_error),
        .data_rsp_id_o     (data_rsp_id),
        .data_rsp_valid_o  (data_rsp_valid),
        .data_rsp_ready_i  (data_rsp_ready)
    );

    rvj1_top dut(
      .clk_i       (clk),
      .rstn_i      (rstn),

      .instr_req_addr_o   (instr_req_addr),
      .instr_req_data_o   (instr_req_data),
      .instr_req_strobe_o (instr_req_strobe),
      .instr_req_write_o  (instr_req_write),
      .instr_req_id_o     (instr_req_id),
      .instr_req_valid_o  (instr_req_valid),
      .instr_req_ready_i  (instr_req_ready),

      .instr_rsp_data_i   (instr_rsp_data),
      .instr_rsp_error_i  (instr_rsp_error),
      .instr_rsp_id_i     (instr_rsp_id),
      .instr_rsp_valid_i  (instr_rsp_valid),
      .instr_rsp_ready_o  (instr_rsp_ready),

      .data_req_addr_o   (data_req_addr),
      .data_req_data_o   (data_req_data),
      .data_req_strobe_o (data_req_strobe),
      .data_req_write_o  (data_req_write),
      .data_req_id_o     (data_req_id),
      .data_req_valid_o  (data_req_valid),
      .data_req_ready_i  (data_req_ready),

      .data_rsp_data_i   (data_rsp_data),
      .data_rsp_error_i  (data_rsp_error),
      .data_rsp_id_i     (data_rsp_id),
      .data_rsp_valid_i  (data_rsp_valid),
      .data_rsp_ready_o  (data_rsp_ready),

      .irq_external_i    (1'b0),
      .irq_timer_i       (1'b1), // at reset mtime == mtimecmp, meaning it is 1
      .irq_sw_i          (1'b0),
      .irq_lcofi_i       (1'b0),
      .irq_platform_i    (16'b0),
      .irq_nmi_i         (1'b0),

      // verilator lint_off REDEFMACRO
      `ifdef RVFI
      `RVFI_CONN
      `endif
      // verilator lint_on REDEFMACRO
  );

endmodule
