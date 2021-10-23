// Wraps the block ram instantiation module with a system verilog interface
//
`timescale 1ns/1ps

module rams_init_file_wrap
#(
    parameter MEM_INIT_FILE =""
)
(
  input clk,

  if_ram_1way.SLAVE if_rom
);


  rams_init_file #(.MEM_INIT_FILE(MEM_INIT_FILE)) rom_memory (
                          .clk(clk), 
                          .we(1'b0), 
                          .addr(if_rom.ram_addr[if_rom.ADDR_WIDTH-1:0]), 
                          .din(32'b0), 
                          .dout(if_rom.ram_rdata[if_rom.DATA_WIDTH-1:0])
                        );

endmodule

