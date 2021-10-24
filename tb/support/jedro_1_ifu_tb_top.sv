`timescale 1ns/1ps

module jedro_1_ifu_tb_top
#(
  parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = 32
)
(
  input clk_i,
  input rstn_i,
  input decoder_ready_i,
  input jmp_instr_i,
  input [31:0] jmp_addr_i,
  output [31:0] instr_ro,
  output instr_valid_ro
);

  ram_read_io #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) instr_mem_if();

  ram_sp_rom_wrap rom_memory_inst(.clk_i (clk_i),
                                  .rom_if(instr_mem_if.SLAVE)
                                );


  jedro_1_ifu ifu_inst(.clk_i           (clk_i),
                       .rstn_i          (rstn_i),
                       .jmp_instr_i     (jmp_instr_i),
                       .jmp_address_i   (jmp_addr_i),
                       .instr_ro        (instr_ro),
                       .instr_valid_ro  (instr_valid_ro),
                       .decoder_ready_i (decoder_ready_i),
                       .instr_mem_if    (instr_mem_if.MASTER)
                     );

endmodule
