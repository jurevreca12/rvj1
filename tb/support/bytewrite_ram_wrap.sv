// Wraps the block ram instantiation module with a system verilog interface
//
`timescale 1ns/1ps

module bytewrite_ram_wrap
#(
    parameter MEM_INIT_FILE="",
    parameter MEM_SIZE_WORDS=2**12
)
(
  input clk_i,
  input rstn_i,
  ram_rw_io.SLAVE ram_if
);

  bytewrite_ram_1b #(.SIZE(MEM_SIZE_WORDS),
                     .MEM_INIT_FILE(MEM_INIT_FILE)) data_ram (.clk(clk_i), 
                                                              .we(ram_if.we[3:0]), 
                                                              .addr(ram_if.addr[$clog2(MEM_SIZE_WORDS*4)-1:0]), 
                                                              .di(ram_if.wdata[ram_if.DATA_WIDTH-1:0]), 
                                                              .dout(ram_if.rdata[ram_if.DATA_WIDTH-1:0])
                        );

  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) ram_if.ack <= 0;
    else                ram_if.ack <= ram_if.stb;
  end
  
endmodule : bytewrite_ram_wrap

