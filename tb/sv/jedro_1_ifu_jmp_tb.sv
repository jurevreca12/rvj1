// Thtests the jump instruction functionality
`timescale 1ns/1ps

module jedro_1_ifu_jmp_tb();
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 32;

  logic clk;
  logic rstn;
  logic decoder_ready;
  logic jmp_instr;
  logic [31:0] jmp_addr;
  logic [31:0] instr;
  logic instr_valid;


  jedro_1_ifu_tb_top #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
  )
                     dut(.clk_i          (clk),
                         .rstn_i         (rstn),
                         .decoder_ready_i(decoder_ready),
                         .jmp_instr_i    (jmp_instr),
                         .jmp_addr_i     (jmp_addr),
                         .instr_ro       (instr),
                         .instr_valid_ro (instr_valid)
                       );

  
  // Handle the clock signal
  always #1 clk = ~clk;

  initial begin
  clk            <= 1'b0;
  rstn           <= 1'b0;
  decoder_ready  <= 1'b0;
  jmp_instr      <= 1'b0;
  jmp_addr       <= 32'b0;

  repeat (3) @ (posedge clk);
  
  rstn <= 1'b1;

  repeat (1) @ (posedge clk);
  // Simple cycle through (no jumps)
  decoder_ready <= 1'b1;
  repeat (2) @ (posedge clk);
  for (int i = 0; i < 4; i++) begin
    assert (instr_valid == 1'b1) else $display("ERROR 0, instr_valid should be asserted here.");
    assert (instr == i) else $display("ERROR 1: incorrect result at i:%d, instr:%d", i, instr);
    repeat (1) @ (posedge clk);
  end
  
  jmp_instr <= 1'b1;
  jmp_addr  <= 32'h0000_0004;
  repeat (1) @ (posedge clk);
  jmp_instr <= 1'b0;
  repeat (1) @ (posedge clk);
  assert (instr_valid == 1'b0) else $display("ERROR 2: instr_valid should NOT be asserted one clock after jmp.");
  repeat (1) @ (posedge clk);
  assert (instr_valid == 1'b0) else $display("ERROR 3: instr_valid should NOT be asserted two clocks after jmp.");
  repeat (1) @ (posedge clk);
  assert (instr_valid == 1'b1) else $display("ERROR 4: instr_valid should be asserted three clocks after jmp.");
  assert (instr == 1) else $display("ERROR 5: instr should be set to 1 (value at address 4)");
  
  repeat (3) @ (posedge clk);
  $finish;

  end

endmodule : jedro_1_ifu_jmp_tb
