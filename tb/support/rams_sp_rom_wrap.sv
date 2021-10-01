// Wraps the block ram instantiation module with a system verilog interface
//
`timescale 1ns/1ps

module ram_sp_rom_wrap
(
  input clk,

  if_ram_1way.SLAVE if_rom
);

  rams_sp_rom rom_memory (.clk(clk), 
                          .we(1'b0), 
                          .addr(if_rom.ram_addr), 
                          .di(32'b0), 
                          .dout(if_rom.ram_rdata)
                        );

endmodule

