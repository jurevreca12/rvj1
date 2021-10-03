// Thtests the jump instruction functionality
`timescale 1ns/1ps

`include "interfaces.sv"

module jedro_1_ifu_jmp_tb();
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 32;

  logic clk;
  logic rstn;
  logic get_next_instr;
  logic jmp_instr;
  logic [31:0] jmp_addr;
  logic [31:0] current_instr;
  logic cinstr_valid_o;



  jedro_1_ifu_tb_top #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  )
                          dut(.clk  (clk),
                         .rstn (rstn),
                         .get_next_instr(get_next_instr),
                         .jmp_instr(jmp_instr),
                         .jmp_addr(jmp_addr),
                         .current_instr(current_instr),
                         .current_instr_valid(cistr_valid_o)
                       );

  
  // Handle the clock signal
  always #1 clk = ~clk;

  initial begin
  clk            <= 1'b0;
  rstn           <= 1'b0;
  get_next_instr <= 1'b0;
  jmp_instr      <= 1'b0;
  jmp_addr       <= 32'b0;

  repeat (3) @ (posedge clk);
  
  rstn <= 1'b1;

  repeat (1) @ (posedge clk);
  // Simple cycle through (no jumps)
  get_next_instr <= 1'b1;
  repeat (2) @ (posedge clk);
  for (int i = 0; i < 4; i++) begin
    if (cinstr_valid_o == 1'b0) begin
      $display("ERROR 0, cinstr_valid_o should be asserted here.");
    end
    repeat (1) @ (posedge clk) begin
      if ( (i < 4) & (!(current_instr == i)) ) begin
          $display("ERROR 1: incorrect result at i:%d, current_instr:%d", i, current_instr);
      end
    end
  end

  
  repeat (1) @ (posedge clk);
  
  jmp_instr <= 1'b1;
  jmp_addr  <= 32'h0000_0004;

  repeat (1) @ (posedge clk);
  
  jmp_instr <= 1'b0;

  if (cinstr_valid_o == 1'b1)
    $display("ERROR 2: cinstr_valid_o should NOT be asserted one clock after jmp.");

  repeat (1) @ (posedge clk);

  if (cinstr_valid_o == 1'b1)
    $display("ERROR 3: cinstr_valid_o should NOT be asserted two clocks after jmp.");


  repeat (2) @ (posedge clk);

  if (cinstr_valid_o == 1'b0)
    $display("ERROR 4: cinstr_valid_o should be asserted three clocks after jmp.");

  if (!(current_instr == 1))
    $display("ERROR 5: current_instr should be set to 1 (value at address 4)");

  repeat (3) @ (posedge clk);
  $finish;

  end

endmodule
