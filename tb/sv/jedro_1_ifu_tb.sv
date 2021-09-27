// This test bench does some basic testing of the instruction fetch unit
`timescale 1ns/1ps

`include "interfaces.sv"

module jedro_1_ifu_tb();
  parameter DATA_WIDTH = 4;
  parameter ADDR_WIDTH = 32;

  logic clk;
  logic rstn;
  logic get_next_instr;
  logic jmp_instr;
  logic [31:0] jmp_addr;
  logic [31:0] current_instr;




  jedro_1_ifu_tb_top dut(.clk  (clk),
                         .rstn (rstn),
                         .get_next_instr(get_next_instr),
                         .jmp_instr(jmp_instr),
                         .jmp_addr(jmp_addr),
                         .current_instr(current_instr)
                       );

  
  // Handle the clock signal
  always #10 clk = ~clk;

  initial begin
  clk            <= 1'b0;
  rstn           <= 1'b0;
  get_next_instr <= 1'b0;
  jmp_instr      <= 1'b0;
  jmp_addr       <= 32'b0;

  repeat (5) @ (posedge clk)
  
  rstn <= 1'b1;

  // Simple cycle through (no jumps)
  get_next_instr <= 1'b1;

  for (int i = 0; i < 16; i++) begin
    repeat (1) @ (posedge clk) 
    repeat (1) @ (posedge clk) begin
      if (i < 15) begin
        if (!(current_instr == i)) begin
          $display("ERROR 0: incorrect result at i:%d, current_instr:%d", i, current_instr);
        end
      end
      else begin
        if (!(current_instr == 32'hFFFF_FFFF)) begin
          $display("ERROR 1: incorrect result at i:%d, current_instr:%d", i, current_instr);
        end
      end
    end
  end

  $finish;

  end

endmodule
