// The test used to simulate the core with the riscof test framework.

module jedro_1_riscof_tb();
  parameter int DATA_WIDTH     = 32;
  parameter int ADDR_WIDTH     = 32;
  parameter int MEM_SIZE_WORDS = 1 << 19;
  parameter int TIMEOUT        = 1000000;
  parameter string MEM_INIT_FILE  = "out.hex";
  parameter string SIGNATURE_FILE = "dut.signature";

  localparam MEM_SIZE_BYTES = MEM_SIZE_WORDS * 4;
  localparam SIG_START_ADDR_CELLNUM = MEM_SIZE_WORDS - 1;
  localparam SIG_END_ADDR_CELLNUM   = MEM_SIZE_WORDS - 2;
  localparam HALT_COND_CELLNUM      = MEM_SIZE_WORDS - 3;

  reg clk;
  reg rstn;

  integer i;
  integer j;

  // Instruction interface
 // wire [DATA_WIDTH-1:0] iram_addr;
  //wire [DATA_WIDTH-1:0] iram_rdata;
  wire                  instr_req = 1'b1;
  wire                  instr_rvalid;
  wire [DATA_WIDTH-1:0] instr_addr;
  wire [DATA_WIDTH-1:0] instr_rdata;
  wire                  instr_err;

  // Data interface
  wire [DATA_WIDTH-1:0] dram_rdata;
  wire                  dram_ack1;
  wire                  dram_ack2;
  wire                  dram_ack;
  assign dram_ack = dram_ack1 | dram_ack2;
  wire                  dram_err;
  wire [3:0]            dram_we;
  wire                  dram_stb;
  wire [DATA_WIDTH-1:0] dram_addr;
  wire [DATA_WIDTH-1:0] dram_wdata;

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

      // .clk  (clk),
      // .we   (1'b0),
      // .addr (iram_addr[MEM_SIZE_BYTES-1:2]),
      // .din  (32'b0),
      // .dout (iram_rdata)
  );

  // data memory
  bytewrite_sram_wrap #(
    .MEM_SIZE_WORDS(MEM_SIZE_WORDS),
    .INIT_FILE_BIN(0),
    .MEM_INIT_FILE(MEM_INIT_FILE)) data_mem (
      .clk_i  (clk),
      .rstn_i (rstn),

      .rdata_o  (dram_rdata),
      .wvalid_o (dram_ack1),
      .rvalid_o (dram_ack2),
      .err_o    (dram_err),
      .we_i     (dram_we),
      .req_i    (dram_stb),
      .addr_i   (dram_addr),
      .wdata_i  (dram_wdata)
  );


  jedro_1_top dut(.clk_i       (clk),
                  .rstn_i      (rstn),

                  //.iram_addr   (iram_addr),
                  //.iram_rdata  (iram_rdata),
                  .instr_req_o    (instr_req),
                  .instr_rvalid_i (instr_rvalid),
                  .instr_addr_o   (instr_addr),
                  .instr_rdata_i  (instr_rdata),
                  .instr_err_i    (instr_err),

                  .dram_we     (dram_we),
                  .dram_stb    (dram_stb),
                  .dram_addr   (dram_addr),
                  .dram_wdata  (dram_wdata),
                  .dram_rdata  (dram_rdata),
                  .dram_ack    (dram_ack),
                  .dram_err    (dram_err)
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
