// Wraps the block ram instantiation module with a system verilog interface
//
`timescale 1ns/1ps

`include "ram_read_io.sv"

module ram_sp_rom_wrap
(
  input clk_i,
  ram_read_io.SLAVE rom_if
);

  rams_sp_rom rom_me (.clk(clk), 
                      .we(1'b0), 
                      .addr(rom_if.addr[rom_if.ADDR_WIDTH-1:0]), 
                      .di(32'b0), 
                      .dout(rom_if.rdata[rom_if.DATA_WIDTH-1:0])
                     );

endmodule

