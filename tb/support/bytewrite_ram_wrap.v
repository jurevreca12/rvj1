// Wraps the block ram instantiation module with a system verilog interface
//
`timescale 1ns/1ps
`include "jedro_1_defines.v"

module bytewrite_ram_wrap
#(
    parameter MEM_INIT_FILE="",
    parameter INIT_FILE_BIN=1,
    parameter MEM_SIZE_WORDS=2**12
)
(
  input clk_i,
  input rstn_i,
  
  // RAM IF
  output [`DATA_WIDTH-1:0] rdata,
  output reg               ack,
  output                   err,
  input  [3:0]             we,
  input                    stb,
  input  [`DATA_WIDTH-1:0] addr,
  input  [`DATA_WIDTH-1:0] wdata
);

  bytewrite_ram_1b #(.SIZE(MEM_SIZE_WORDS),
                     .INIT_FILE_BIN(INIT_FILE_BIN),
                     .MEM_INIT_FILE(MEM_INIT_FILE)) data_ram (.clk(clk_i), 
                                                              .we(we[3:0]), 
                                                              .addr(addr[$clog2(MEM_SIZE_WORDS*4)-1:0]), 
                                                              .di(wdata[`DATA_WIDTH-1:0]), 
                                                              .dout(rdata[`DATA_WIDTH-1:0]));

  assign err = 0;

  always @(posedge clk_i) begin
    if (rstn_i == 1'b0) ack <= 0;
    else                ack <= stb;
  end
  
endmodule

