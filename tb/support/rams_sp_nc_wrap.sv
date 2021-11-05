// Wraps the block ram instantiation module with a system verilog interface
//
`timescale 1ns/1ps

module rams_sp_nc_wrap
(
  input clk_i,
  ram_rw_io.SLAVE ram_if
);

  rams_sp_nc data_ram (.clk(clk_i), 
                       .we(ram_if.we), 
                       .addr(ram_if.addr[ram_if.ADDR_WIDTH-1:0]), 
                       .di(ram_if.wdata[ram_if.ADDR_WIDTH-1:0]), 
                       .dout(ram_if.rdata[ram_if.DATA_WIDTH-1:0])
                     );

endmodule : rams_sp_nc_wrap

