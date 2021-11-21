// Single-Port Block RAM No-Change Mode
// File: rams_sp_nc.v

module rams_sp_nc (clk, we, en, addr, di, dout);

input clk; 
input we; 
input en;
input [32-1:0] addr; 
input [32-1:0] di; 
output [32-1:0] dout;

reg	[32-1:0] RAM [1023:0];
reg	[32-1:0] dout;

always @(posedge clk)
begin
  if (en)
  begin
    if (we)
      RAM[addr >> 2] <= di;
    else
      dout <= RAM[addr >> 2];
  end
end
endmodule
