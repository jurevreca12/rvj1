// Wraps the block ram instantiation module with a system verilog interface
//
`timescale 1ns/1ps

module rams_init_file_wrap
#(
    parameter MEM_INIT_FILE="",
    parameter INIT_FILE_BIN=1,
    parameter MEM_SIZE_WORDS=2**12
)
(
  input clk_i,
  input [31:0] addr_i,
  output [31:0] rdata_o
);


  rams_init_file #(.MEM_SIZE(MEM_SIZE_WORDS),
                   .INIT_FILE_BIN(INIT_FILE_BIN),
                   .MEM_INIT_FILE(MEM_INIT_FILE)) rom_memory (
                          .clk(clk_i), 
                          .we(1'b0), 
                          .addr(addr_i[$clog2(MEM_SIZE_WORDS*4)-1:0]), 
                          .din(32'b0), 
                          .dout(rdata_o[`DATA_WIDTH-1:0])
                        );

endmodule

