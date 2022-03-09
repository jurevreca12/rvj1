// Simulates a slave that returns an error
// signal on write request
`timescale 1ns/1ps

module bytewrite_ram_error_wrap
#(
    parameter MEM_INIT_FILE="",
    parameter MEM_SIZE_WORDS=2**12
)
(
  input clk_i,
  input rstn_i,
  ram_rw_io.SLAVE ram_if
);
  logic delay;

  bytewrite_ram_1b #(.SIZE(MEM_SIZE_WORDS),
                     .MEM_INIT_FILE(MEM_INIT_FILE)) data_ram (.clk(clk_i), 
                                                              .we(ram_if.we[3:0]), 
                                                              .addr(ram_if.addr[$clog2(MEM_SIZE_WORDS*4)-1:0]), 
                                                              .di(ram_if.wdata[ram_if.DATA_WIDTH-1:0]), 
                                                              .dout(ram_if.rdata[ram_if.DATA_WIDTH-1:0]));

  assign ram_if.ack = 0;
   
  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) delay <= 0;
    else                delay <= ram_if.stb;
  end

  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) ram_if.err <= 0;
    else                ram_if.err <= delay;
  end
  

endmodule : bytewrite_ram_error_wrap

