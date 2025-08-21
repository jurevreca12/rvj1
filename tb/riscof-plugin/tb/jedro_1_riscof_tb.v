// The test used to simulate the core with the riscof test framework.

module jedro_1_riscof_tb();
  parameter int DATA_WIDTH     = 32;
  parameter int ADDR_WIDTH     = 32;
  parameter int MEM_SIZE_WORDS = 1 << 19;
  parameter int TIMEOUT        = 1000000;
  parameter string MEM_INIT_FILE  = "out.hex";
  parameter string SIGNATURE_FILE = "dut.signature";

  localparam int MEM_SIZE_BYTES = MEM_SIZE_WORDS * 4;
  localparam int SIG_START_ADDR_CELLNUM = MEM_SIZE_WORDS - 1;
  localparam int SIG_END_ADDR_CELLNUM   = MEM_SIZE_WORDS - 2;
  localparam int HALT_COND_CELLNUM      = MEM_SIZE_WORDS - 3;

  reg clk;
  reg rstn;

  integer i;
  integer j;

  wire [DATA_WIDTH-1:0] instr_req_addr;
  wire [DATA_WIDTH-1:0] instr_req_data;
  wire [3:0]            instr_req_strobe;
  wire                  instr_req_write;
  wire                  instr_req_valid;
  wire                  instr_req_ready;

  wire [DATA_WIDTH-1:0] instr_rsp_data;
  wire                  instr_rsp_error;
  wire                  instr_rsp_valid;
  wire                  instr_rsp_ready;


  wire [DATA_WIDTH-1:0] data_req_addr;
  wire [DATA_WIDTH-1:0] data_req_data;
  wire [3:0]            data_req_strobe;
  wire                  data_req_write;
  wire                  data_req_valid;
  wire                  data_req_ready;

  wire [DATA_WIDTH-1:0] data_rsp_data;
  wire                  data_rsp_error;
  wire                  data_rsp_valid;
  wire                  data_rsp_ready;

  // instruction memory
  bytewrite_sram_wrap #(
    .MEM_SIZE_WORDS(MEM_SIZE_WORDS),
    .INIT_FILE_BIN(0),
    .MEM_INIT_FILE(MEM_INIT_FILE)) rom_mem (
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

  // data memory
  bytewrite_sram_wrap #(
    .MEM_SIZE_WORDS(MEM_SIZE_WORDS),
    .INIT_FILE_BIN(0),
    .MEM_INIT_FILE(MEM_INIT_FILE)) data_mem (
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


  jedro_1_top dut(
    .clk_i       (clk),
    .rstn_i      (rstn),

    .instr_req_addr_o   (instr_req_addr),
    .instr_req_data_o   (instr_req_data),
    .instr_req_strobe_o (instr_req_strobe),
    .instr_req_write_o  (instr_req_write),
    .instr_req_valid_o  (instr_req_valid),
    .instr_req_ready_i  (instr_req_ready),

    .instr_rsp_data_i   (instr_rsp_data),
    .instr_rsp_error_i    (instr_rsp_error),
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

  // Handle the clock signal
  always #1 clk = ~clk;

  integer sig_file, start_addr, end_addr;
  initial begin
  $dumpfile("dump.fst");
  $dumpvars();
  clk = 1'b0;
  rstn = 1'b0;
  repeat (3) @ (posedge clk);
  rstn = 1'b1;

  i=0;
  while (i < TIMEOUT && data_mem.mem.RAM[HALT_COND_CELLNUM] !== 1) begin
    @(posedge clk);
    i=i+1;
  end

  // get start and end address of the signature region
  start_addr = data_mem.mem.RAM[SIG_START_ADDR_CELLNUM];
  end_addr   = data_mem.mem.RAM[SIG_END_ADDR_CELLNUM];

  sig_file = $fopen(SIGNATURE_FILE, "w");

  for (j=start_addr; j < end_addr; j=j+4) begin
    $fwrite(sig_file, "%h\n", data_mem.mem.RAM[j>>2]);
  end
  $fclose(sig_file);
  $finish;
  end

endmodule
