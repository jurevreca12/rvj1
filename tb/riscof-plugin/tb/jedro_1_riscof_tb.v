// The test used to simulate the core with the riscof test framework.
`timescale 1ns/1ps

module jedro_1_riscof_tb();
  parameter DATA_WIDTH     = 32;
  parameter ADDR_WIDTH     = 32;
  parameter MEM_SIZE_WORDS = 1 << 19;
  parameter TIMEOUT        = 1000000;
 
  localparam SIG_START_ADDR_CELLNUM = MEM_SIZE_WORDS - 1;
  localparam SIG_END_ADDR_CELLNUM   = MEM_SIZE_WORDS - 2;
  localparam HALT_COND_CELLNUM      = MEM_SIZE_WORDS - 3;
   
  reg clk;
  reg rstn;
  
  integer i;
  integer j;

  // Instruction interface  
  wire [DATA_WIDTH-1:0] iram_addr;
  wire [DATA_WIDTH-1:0] iram_rdata;

  // Data interface
  wire [DATA_WIDTH-1:0] dram_rdata;
  wire                  dram_ack;
  wire                  dram_err;
  wire [3:0]            dram_we;
  wire                  dram_stb;
  wire [DATA_WIDTH-1:0] dram_addr;
  wire [DATA_WIDTH-1:0] dram_wdata;

  rams_init_file_wrap #(.MEM_SIZE_WORDS(MEM_SIZE_WORDS),
                        .INIT_FILE_BIN(0),
                        .MEM_INIT_FILE("out.hex")) rom_mem (.clk_i   (clk),
                                                            .addr_i  (iram_addr),
                                                            .rdata_o (iram_rdata));

  // Data interface
  bytewrite_ram_wrap #(.MEM_SIZE_WORDS(MEM_SIZE_WORDS),
                       .INIT_FILE_BIN(0),
                       .MEM_INIT_FILE("out.hex")) data_mem (.clk_i  (clk),
                                                            .rstn_i (rstn),
                                                            .rdata  (dram_rdata),
                                                            .ack    (dram_ack),
                                                            .err    (dram_err),
                                                            .we     (dram_we),
                                                            .stb    (dram_stb),
                                                            .addr   (dram_addr),
                                                            .wdata  (dram_wdata));


  jedro_1_top dut(.clk_i       (clk),
                  .rstn_i      (rstn),

                  .iram_addr   (iram_addr),
                  .iram_rdata  (iram_rdata),

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
  clk <= 1'b0;
  rstn <= 1'b0;
  repeat (3) @ (posedge clk);
  rstn <= 1'b1;
  
  i=0;
  while (i < TIMEOUT && data_mem.data_ram.RAM[HALT_COND_CELLNUM] !== 1) begin
    @(posedge clk);
    i=i+1;
  end

  // get stard and end address of the signature region
  start_addr = data_mem.data_ram.RAM[SIG_START_ADDR_CELLNUM][$clog2(MEM_SIZE_WORDS*4)-1:0];
  end_addr   = data_mem.data_ram.RAM[SIG_END_ADDR_CELLNUM][$clog2(MEM_SIZE_WORDS*4)-1:0];

  sig_file = $fopen("dut.signature", "w");
  for (j=start_addr; j < end_addr; j=j+4) begin
    $fwrite(sig_file, "%h\n", data_mem.data_ram.RAM[j>>2]);
  end
  $fclose(sig_file);
  $finish;
  end

endmodule 
