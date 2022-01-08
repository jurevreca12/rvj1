// Initializing Block RAM from external data file
// Binary data
// File: rams_init_file.v 

module rams_init_file #(
    parameter MEM_INIT_FILE="",
    parameter MEM_SIZE=2**12) (clk, we, addr, din, dout);

input clk;
input we;
input [31:0] addr;
input [31:0] din;
output [31:0] dout;


reg [31:0] ram [0:MEM_SIZE];
reg [31:0] dout;

initial begin
    if (MEM_INIT_FILE != "") begin
        $readmemb(MEM_INIT_FILE, ram);
    end
end

always @(posedge clk)
begin
  if (we)
     ram[addr >> 2] <= din;
  dout <= ram[addr >> 2];
end endmodule
