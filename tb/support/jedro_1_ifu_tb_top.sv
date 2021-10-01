`timescale 1ns/1ps

`include "interfaces.sv"

module jedro_1_ifu_tb_top
#(
  parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = 32
)
(
  input clk,
  input rstn,
  input get_next_instr,
  input jmp_instr,
  input [31:0] jmp_addr,
  output [31:0] current_instr,
  output current_instr_valid
);

  if_ram_1way #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) cpu_rom_if();

  ram_sp_rom_wrap rom_memory_inst(.clk(clk),
                                  .if_rom(cpu_rom_if.SLAVE)
                                );


  jedro_1_ifu ifu_inst(.clk_i           (clk),
                       .rstn_i          (rstn),
                       .get_next_instr_i(get_next_instr),
                       .jmp_instr_i     (jmp_instr),
                       .jmp_address_i   (jmp_addr),
                       .if_instr_mem    (cpu_rom_if.MASTER),
                       .cinstr_o        (current_instr),
                       .cinstr_valid_o  (current_instr_valid)
                     );

endmodule
