// This test bench does some basic testing of the instruction fetch unit
`timescale 1ns/1ps

`include "interfaces.sv"

module jedro_1_ifu_tb();
  parameter DATA_WIDTH = 4;
  parameter ADDR_WIDTH = 32;

  logic clk;
  logic rstn;
  logic get_next_instr;
  logic jmp_addr;
  logic [31:0] jmp_instr;
  logic [31:0] current_instr;


  if_ram_1way if_ram_cpu_instr_inst();

  ram_sp_rom_wrap rom_memory_inst(.clk_i (clk),
                                  .rstn_i(rstn),
                                  .if_rom(if_ram_cpu_instr_inst.SLAVE)
                                );


  jedro_1_ifu ifu_inst(.clk_i           (clk),
                       .rstn_i          (rstn),
                       .get_next_instr_i(get_next_instr),
                       .jmp_instr_i     (jmp_instr),
                       .jmp_address_i   (jmp_addr),
                       .if_instr_mem    (if_ram_cpu_instr_inst.MASTER),
                       .cinstr_o        (current_instr)
                     );


  
  // Handle the clock signal
  always #10 clk = ~clk;

  initial begin
  clk            <= 1'b0;
  rstn           <= 1'b0;
  get_next_instr <= 1'b0;
  jmp_addr       <= 1'b0;
  current_instr  <= 1'b0;

  repeat (2) @ (posedge clk)

  // Simple cycle through (no jumps)
  get_next_instr <= 1'b1;

  for (int i = 0; i < 16; i++) begin
    repeat (1) @ (posedge clk) 
    repeat (1) @ (posedge clk) begin
      if (i < 15) begin
        assert current_instr == i;
      end
      else begin
        assert current_instr == 32'hFFFF_FFFF;
      end
    end
  end

  end

endmodule
