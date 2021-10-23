// A basic test of the addi instruction.
`timescale 1ns/1ps

`include "if_ram_1way.sv"
`include "if_ram_2way_32b_data.sv"

module jedro_1_addi_tb();
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 32;

  logic clk;
  logic rstn;
  
  int i;
  
  if_ram_1way #(.ADDR_WIDTH(ADDR_WIDTH), 
                .DATA_WIDTH(DATA_WIDTH)) instr_if();

  if_ram_2way_32b_data data_if();


  jedro_1_top dut(.clk_i(clk),
                  .rstn_i(rstn),
                  .if_instr_ram(instr_if.MASTER),
                  .if_data_ram(data_if.MASTER)
                );

  rams_init_file_wrap #(.MEM_INIT_FILE("jedro_1_addi_tb.mem")) rom_mem (.clk(clk),
                                                                 .if_rom(instr_if));

  // Handle the clock signal
  always #1 clk = ~clk;

  initial begin
  clk <= 1'b0;
  rstn <= 1'b0;
  repeat (3) @ (posedge clk);
  rstn <= 1'b1;
  

  while (i < 32) begin
    @(posedge clk);
    i++;
  end

  $finish;
  end

endmodule
