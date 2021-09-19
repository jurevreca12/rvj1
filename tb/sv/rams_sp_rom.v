// Initializing Block RAM (Single-Port Block RAM)
// File: rams_sp_rom 
module rams_sp_rom (clk, we, addr, di, dout);
input clk;
input we;
input [3:0] addr;
input [31:0] di;
output [31:0] dout;

reg [31:0] ram [15:0];
reg [31:0] dout;

initial 
begin
  ram[0]  = 32'h0000_0000; ram[1]  = 32'h0000_0001; ram[2]  = 32'h0000_0002; ram[3]  = 32'h0000_0003;
  ram[4]  = 32'h0000_0004; ram[5]  = 32'h0000_0005; ram[6]  = 32'h0000_0006; ram[7]  = 32'h0000_0007;
  ram[8]  = 32'h0000_0008; ram[9]  = 32'h0000_0009; ram[10] = 32'h0000_000A; ram[11] = 32'h0000_000B;
  ram[12] = 32'h0000_000C; ram[13] = 32'h0000_000D; ram[14] = 32'h0000_000E; 
  ram[15] = 32'hFFFF_FFFF;
end
 
always @(posedge clk)
begin
  if (we)
    ram[addr] <= di;
  dout <= ram[addr];
end 

endmodule
