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

  // Instruction interface
  wire                  instr_req;
  wire                  instr_rvalid;
  wire [DATA_WIDTH-1:0] instr_addr;
  wire [DATA_WIDTH-1:0] instr_rdata;
  wire                  instr_err;

  // Data interface
  wire [DATA_WIDTH-1:0] data_rdata;
  wire                  data_wvalid;
  wire                  data_rvalid;
  wire                  data_err;
  wire [3:0]            data_we;
  wire                  data_req;
  wire [DATA_WIDTH-1:0] data_addr;
  wire [DATA_WIDTH-1:0] data_wdata;

  // instruction memory
  bytewrite_sram_wrap #(
    .MEM_SIZE_WORDS(MEM_SIZE_WORDS),
    .INIT_FILE_BIN(0),
    .MEM_INIT_FILE(MEM_INIT_FILE)) rom_mem (
      .clk_i    (clk),
      .rstn_i   (rstn),

      .req_i    (instr_req),
      .rvalid_o (instr_rvalid),
      .addr_i   (instr_addr),
      .rdata_o  (instr_rdata),
      .we_i     (4'b0),
      .wdata_i  (32'b0),
      .wvalid_o (),
      .err_o    (instr_err)
  );

  // data memory
  bytewrite_sram_wrap #(
    .MEM_SIZE_WORDS(MEM_SIZE_WORDS),
    .INIT_FILE_BIN(0),
    .MEM_INIT_FILE(MEM_INIT_FILE)) data_mem (
      .clk_i  (clk),
      .rstn_i (rstn),

      .rdata_o  (data_rdata),
      .wvalid_o (data_wvalid),
      .rvalid_o (data_rvalid),
      .err_o    (data_err),
      .we_i     (data_we),
      .req_i    (data_req),
      .addr_i   (data_addr),
      .wdata_i  (data_wdata)
  );


  jedro_1_top dut(.clk_i       (clk),
                  .rstn_i      (rstn),

                  .instr_req_o    (instr_req),
                  .instr_rvalid_i (instr_rvalid),
                  .instr_addr_o   (instr_addr),
                  .instr_rdata_i  (instr_rdata),
                  .instr_err_i    (instr_err),

                  .data_we_o     (data_we),
                  .data_req_o    (data_req),
                  .data_addr_o   (data_addr),
                  .data_wdata_o  (data_wdata),
                  .data_rdata_i  (data_rdata),
                  .data_rvalid_i (data_rvalid),
                  .data_wvalid_i (data_wvalid),
                  .data_err_i    (data_err)
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
