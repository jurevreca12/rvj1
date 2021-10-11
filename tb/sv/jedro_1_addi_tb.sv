// A basic test of the addi instruction.
`timescale 1ns/1ps

`include "if_ram_1way.sv"
`include "if_ram_2way_32b_data.sv"

module jedro_1_addi_tb();
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 32;

  logic clk;
  logic rstn;
  if_ram_1way #(.ADDR_WIDTH(ADDR_WIDTH), 
                .DATA_WIDTH(DATA_WIDTH)) instr_if();

  if_ram_2way_32b_data data_if();


  jedro_1_top dut(.clk_i(clk),
                  .rstn_i(rstn),
                  .if_instr_ram(instr_if.MASTER),
                  .if_data_ram(data_if.MASTER)
                );

  // Handle the clock signal
  always #1 clk = ~clk;

  initial begin
  clk <= 1'b0;
  rstn <= 1'b0;
  repeat (3) @ (posedge clk);
  rstn <= 1'b1;
  
  //                        imm12       _ rs1 _ f3_
  instr_if.ram_rdata <= 32'b000000000001_00001_000_00001_0010011;
  repeat (2) @ (posedge clk);
  instr_if.ram_rdata <= 32'b000000000010_00001_000_00001_0010011;
  repeat (2) @ (posedge clk);
  instr_if.ram_rdata <= 32'b000000000011_00001_000_00001_0010011;
  repeat (2) @ (posedge clk);
  assert (dut.regfile_inst.regfile[0] == 1);
  instr_if.ram_rdata <= 32'b000000000100_00001_000_00001_0010011;
  assert (dut.regfile_inst.regfile[0] == 3);
  repeat (2) @ (posedge clk);
  
  //if (!()) begin

  //end

  instr_if.ram_rdata <= 32'b000000000101_00001_000_00001_0010011;
  repeat (1) @ (posedge clk);

  repeat (8) @ (posedge clk);
  $finish;
  end

endmodule
