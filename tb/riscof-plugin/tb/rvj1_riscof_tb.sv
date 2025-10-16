// The test used to simulate the core with the riscof test framework.
import rvj1_defines::*;

module rvj1_riscof_tb();
  parameter int MEM_SIZE_WORDS = 1 << 19;
  parameter int TIMEOUT        = 1000000;
  parameter string INSTR_MEM_INIT_FILE = "text.hex";
  parameter string DATA_MEM_INIT_FILE = "data.hex";
  parameter string SIGNATURE_FILE = "dut.signature";

  localparam int InstrMemBaseAddr  = 32'h8000_0000;
  localparam int DataMemBaseAddr   = 32'h8020_0000;
  localparam int InstrMemSizeWords = MEM_SIZE_WORDS;
  localparam int DataMemSizeWords  = MEM_SIZE_WORDS;
  localparam int InstrMemSizeBytes = InstrMemSizeWords * 4;
  localparam int DataMemSizeBytes  = DataMemSizeWords  * 4;
  localparam int InstrMemEndAddr   = InstrMemBaseAddr + InstrMemSizeBytes;
  localparam int DataMemEndAddr    = DataMemBaseAddr + DataMemSizeBytes;
  localparam int SigStartCellNum   = MEM_SIZE_WORDS - 1;
  localparam int SigEndCellNum     = MEM_SIZE_WORDS - 2;
  localparam int HaltCondCellnum   = MEM_SIZE_WORDS - 3;
  localparam int SigStartAddr      = DataMemBaseAddr + (SigStartCellNum * 4);
  localparam int SigEndAddr        = DataMemBaseAddr + (SigEndCellNum * 4);
  localparam int HaltCondAddr      = DataMemBaseAddr + (HaltCondCellnum * 4);

  reg clk;
  reg rstn;

  integer i;
  integer j;

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

    // instruction memory
    bytewrite_sram_wrap #(
      .BASE_ADDR(InstrMemBaseAddr),
      .MEM_SIZE_WORDS(InstrMemSizeWords),
      .INIT_FILE_BIN(0),
      .MEM_INIT_FILE(INSTR_MEM_INIT_FILE)) rom_mem (
        .clk_i    (clk),
        .rstn_i   (rstn),

        .req_addr_i   (instr_req_addr),
        .req_data_i   (instr_req_data),
        .req_strobe_i (instr_req_strobe),
        .req_write_i  (instr_req_write),
        .req_valid_i  (instr_req_valid),
        .req_ready_o  (instr_req_ready),

        .rsp_data_o   (instr_rsp_data),
        .rsp_error_o  (instr_rsp_error),
        .rsp_valid_o  (instr_rsp_valid),
        .rsp_ready_i  (instr_rsp_ready)
    );

    rvj1_top dut(
      .clk_i       (clk),
      .rstn_i      (rstn),

      .instr_req_addr_o   (instr_req_addr),
      .instr_req_data_o   (instr_req_data),
      .instr_req_strobe_o (instr_req_strobe),
      .instr_req_write_o  (instr_req_write),
      .instr_req_valid_o  (instr_req_valid),
      .instr_req_ready_i  (instr_req_ready),

      .instr_rsp_data_i   (instr_rsp_data),
      .instr_rsp_error_i  (instr_rsp_error),
      .instr_rsp_valid_i  (instr_rsp_valid),
      .instr_rsp_ready_o  (instr_rsp_ready),

      .data_req_addr_o   (data_req_addr),
      .data_req_data_o   (data_req_data),
      .data_req_strobe_o (data_req_strobe),
      .data_req_write_o  (data_req_write),
      .data_req_valid_o  (data_req_valid),
      .data_req_ready_i  (data_req_ready),

      .data_rsp_data_i   (data_rsp_data),
      .data_rsp_error_i  (data_rsp_error),
      .data_rsp_valid_i  (data_rsp_valid),
      .data_rsp_ready_o  (data_rsp_ready)
  );

  // data memory
  bytewrite_sram_wrap #(
    .BASE_ADDR(DataMemBaseAddr),
    .MEM_SIZE_WORDS(DataMemSizeWords),
    .INIT_FILE_BIN(0),
    .MEM_INIT_FILE(DATA_MEM_INIT_FILE)) data_mem (
      .clk_i  (clk),
      .rstn_i (rstn),

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

  // Handle the clock signal
  always #1 clk = ~clk;

  integer sig_file, start_addr, end_addr;
  initial begin
  $display("Starting simulation of RVJ1");
  $display("Instruction memory: 0x%8h-0x%8h", InstrMemBaseAddr, InstrMemEndAddr);
  $display("Data memory: 0x%8h-0x%8h", DataMemBaseAddr, DataMemEndAddr);
  $display("Simulation will run until a 1 is written into data RAM cell 0x%0h at address: 0x%8h.",
    HaltCondCellnum,
    HaltCondAddr
  );
  $display("When simulation finnishes the signature start and address will be in cells-address:");
  $display("begin_signature: 0x%0h-0x%8h", SigStartCellNum, SigStartAddr);
  $display("end_signature: 0x%0h-0x%8h", SigEndCellNum, SigEndAddr);
  $dumpfile("dump.fst");
  $dumpvars();
  clk = 1'b0;
  rstn = 1'b0;
  repeat (3) @ (posedge clk);
  rstn = 1'b1;

  i=0;
  while (i < TIMEOUT && data_mem.mem.RAM[HaltCondCellnum] !== 1) begin
    if (instr_rsp_data == 0 && instr_rsp_ready && instr_rsp_valid)
      break;
    @(posedge clk);
    i=i+1;
  end

  repeat (10) begin
    @(posedge clk);
  end

  if (i == TIMEOUT)
    $display("WARNING: Simulation did not finnish. Timeout occured after %0d cycles.", i);
  else
    $display("Simulation finnished after %0d cycles.", i);

  // get start and end address of the signature region
  start_addr = data_mem.mem.RAM[SigStartCellNum];
  end_addr   = data_mem.mem.RAM[SigEndCellNum];
  $display("Writing results to %s from RAM: 0x%0h - 0x%0h", SIGNATURE_FILE, start_addr, end_addr);
  //assert(end_addr > start_addr);

  sig_file = $fopen(SIGNATURE_FILE, "w");

  for (j=start_addr; j < end_addr; j=j+4) begin
    $fwrite(sig_file, "%h\n", data_mem.mem.RAM[j>>2]);
  end
  $fclose(sig_file);
  $finish;
  end

endmodule
