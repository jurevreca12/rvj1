////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_soc                                                   //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    Very simple SoC with rvj1 core.                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


import rvj1_defines::*;

module rvj1_soc (
  input  logic clk_i,
  input  logic rst,
  output logic [7:0] gpio_out
);
  parameter int MEM_SIZE_WORDS = 1 << 12;
  parameter int TIMEOUT        = 1000000;
  parameter string INSTR_MEM_INIT_FILE = "text.hex";

  localparam int InstrMemBaseAddr  = 32'h8000_0000;
  localparam int DataMemBaseAddr   = 32'h8002_0000;
  localparam int GpioAddr          = 32'h8002_0000; // overlaped with data mem

  localparam int InstrMemSizeWords = MEM_SIZE_WORDS;
  localparam int DataMemSizeWords  = MEM_SIZE_WORDS;
  localparam int InstrMemSizeBytes = InstrMemSizeWords * 4;
  localparam int DataMemSizeBytes  = DataMemSizeWords  * 4;
  localparam int InstrMemEndAddr   = InstrMemBaseAddr + InstrMemSizeBytes;
  localparam int DataMemEndAddr    = DataMemBaseAddr + DataMemSizeBytes;

  logic rstn_i;
  assign rstn_i = ~rst;
  logic [XLEN-1:0]   instr_req_addr;
  logic [XLEN-1:0]   instr_req_data;
  logic [NBYTES-1:0] instr_req_strobe;
  logic              instr_req_write;
  logic              instr_req_valid;
  logic              instr_req_ready;

  logic [XLEN-1:0] instr_rsp_data;
  logic            instr_rsp_error;
  logic            instr_rsp_valid;
  logic            instr_rsp_ready;


  logic [XLEN-1:0]   data_req_addr;
  logic [XLEN-1:0]   data_req_data;
  logic [NBYTES-1:0] data_req_strobe;
  logic              data_req_write;
  logic              data_req_valid;
  logic              data_req_ready;

  logic [XLEN-1:0] data_rsp_data;
  logic            data_rsp_error;
  logic            data_rsp_valid;
  logic            data_rsp_ready;

  logic [7:0] gpio_reg;
  logic       gpio_write;

  bytewrite_sram_wrap #(
    .MEM_INIT_FILE (INSTR_MEM_INIT_FILE),
    .INIT_FILE_BIN (0),
    .DATA_WIDTH    (32),
    .BASE_ADDR     (InstrMemSizeWords),
    .MEM_SIZE_WORDS(1024)
  ) instr_mem (
    .clk_i       (clk_i),
    .rstn_i      (rstn_i),
 
    .req_addr_i  (instr_req_addr),
    .req_data_i  (instr_req_data),
    .req_strobe_i(instr_req_strobe),
    .req_write_i (instr_req_write),
    .req_valid_i (instr_req_valid),
    .req_ready_o (instr_req_ready),
 
    .rsp_data_o  (instr_rsp_data),
    .rsp_error_o (instr_rsp_error),
    .rsp_valid_o (instr_rsp_valid),
    .rsp_ready_i (instr_rsp_ready)
  ); 
 
  rvj1_top core_0 (
    .clk_i  (clk_i),
    .rstn_i (rstn_i),
 
    .instr_req_addr_o  (instr_req_addr),
    .instr_req_data_o  (instr_req_data),
    .instr_req_strobe_o(instr_req_strobe),
    .instr_req_write_o (instr_req_write),
    .instr_req_valid_o (instr_req_valid),
    .instr_req_ready_i (instr_req_ready),
 
    .instr_rsp_data_i  (instr_rsp_data),
    .instr_rsp_error_i (instr_rsp_error),
    .instr_rsp_valid_i (instr_rsp_valid),
    .instr_rsp_ready_o (instr_rsp_ready),
 
    .data_req_addr_o   (data_req_addr),
    .data_req_data_o   (data_req_data),
    .data_req_strobe_o (data_req_strobe),
    .data_req_write_o  (data_req_write),
    .data_req_valid_o  (data_req_valid),
    .data_req_ready_i  (data_req_ready),
 
    .data_rsp_data_i   (data_rsp_data),
    .data_rsp_error_i  (data_rsp_error),
    .data_rsp_valid_i  (data_rsp_valid),
    .data_rsp_ready_o  (data_rsp_ready),
 
    .irq_external_i    (1'b0),
    .irq_timer_i       (1'b0),
    .irq_sw_i          (1'b0),
    .irq_platform_i    (16'b0),
    .irq_nmi_i         (1'b0)
  );
 
  bytewrite_sram_wrap #(
    .BASE_ADDR(DataMemBaseAddr),
    .MEM_SIZE_WORDS(DataMemSizeWords)
  ) data_mem (
      .clk_i  (clk_i),
      .rstn_i (rstn_i),
 
      .req_addr_i   (data_req_addr),
      .req_data_i   (data_req_data),
      .req_strobe_i (data_req_strobe),
      .req_write_i  (data_req_write),
      .req_valid_i  (data_req_valid),
      .req_ready_o  (data_req_ready),
 
      .rsp_data_o   (data_rsp_data),
      .rsp_error_o  (data_rsp_error),
      .rsp_valid_o  (data_rsp_valid),
      .rsp_ready_i  (data_rsp_ready)
  ); 
 
 
  assign gpio_write = data_req_valid && data_req_ready && data_req_write && (data_req_addr == GpioAddr);
  always_ff @(posedge clk_i) begin
    if (~rstn_i) 
      gpio_reg <= '0;
    else if (gpio_write)
      gpio_reg <= data_req_data[7:0];
  end 
  assign gpio_out = gpio_reg;
endmodule
