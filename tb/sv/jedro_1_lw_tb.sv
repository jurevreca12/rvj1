// A basic test of the lw (load word) instruction.
`timescale 1ns/1ps

module jedro_1_lw_tb();
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 32;

  logic clk;
  logic rstn;
  logic [31:0] iaddr;
  logic [31:0] idata;
  int i;

  logic [31:0] rdata;
  logic ack;
  logic err;
  logic [3:0] we;
  logic stb;
  logic [31:0] addr;
  logic [31:0] wdata;

  rams_init_file_wrap #(.MEM_INIT_FILE("jedro_1_lw_tb.mem")) rom_mem (.clk_i(clk),
								      .addr_i(iaddr),
								      .rdata_o(idata));
  bytewrite_ram_wrap data_mem (.clk_i  (clk),
                               .rstn_i (rstn),
			       .rdata(rdata),
                               .ack(ack),
                               .err(err),
                               .we(we),
                               .stb(stb),
                               .addr(addr),
                               .wdata(wdata));

  jedro_1_top dut(.clk_i       (clk),
                  .rstn_i      (rstn),
		  .iram_addr   (iaddr),
                  .iram_rdata  (iram_rdata),
                  .dram_we     (we),
                  .dram_stb    (stb),
                  .dram_addr   (addr),
                  .dram_wdata  (wdata),
                  .dram_rdata  (rdata),
                  .dram_ack    (ack),
                  .dram_err    (err));


  // Handle the clock signal
  always #1 clk = ~clk;

  initial begin
  clk <= 1'b0;
  rstn <= 1'b0;
  repeat (3) @ (posedge clk);
  rstn <= 1'b1;
 
  while (i < 64 && dut.decoder_inst.illegal_instr_ro == 0) begin
    @(posedge clk);
    i++;
  end
  repeat (3) @ (posedge clk); // finish instructions in the pipeline

  assert (dut.regfile_inst.regfile[30] == 32'b11111111_11111111_11111111_11111111 &&
          dut.regfile_inst.regfile[31] == 32'b11111111_11111111_11111111_11111111) 
  else $display("ERROR: After executing jedro_1_lw_tb.mem the values in registers 30 and 31 should both be all 1s. Not %d and %d.", 
                 dut.regfile_inst.regfile[30], dut.regfile_inst.regfile[31]);

  assert (dut.regfile_inst.regfile[14] == 32'b00000000_00000000_00000000_00001111 &&
          dut.regfile_inst.regfile[15] == 32'b00000000_00000000_00000000_00001111) 
  else $display("ERROR: After executing jedro_1_lw_tb.mem the values in register 14 and 15 both be 15. Not %d and %d.", 
                 dut.regfile_inst.regfile[14], dut.regfile_inst.regfile[15]);

  $finish;
  end

endmodule : jedro_1_lw_tb
