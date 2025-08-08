// Single-Port BRAM with Byte-wide Write Enable
// Read-First mode
// Single-process description
// Compact description of the write with a generate-for 
//   statement
// Column width and number of columns easily configurable
//
// bytewrite_ram_1b.v
//

module bytewrite_ram_1b (clk, we, addr, di, dout);

parameter string MEM_INIT_FILE="";
parameter int INIT_FILE_BIN=1;
parameter int MEM_SIZE_WORDS = 2**12;
localparam int ADDR_WIDTH = $clog2(MEM_SIZE_WORDS);
localparam int WORD_SIZE = 32;
localparam int NUM_BYTES = WORD_SIZE / 8;

input clk;
input [NUM_BYTES-1:0] we;
input [ADDR_WIDTH-1:0] addr;
input [WORD_SIZE-1:0] di;
output reg [WORD_SIZE-1:0] dout;

reg [WORD_SIZE-1:0] RAM [MEM_SIZE_WORDS-1:0];

integer flen;
initial begin
    if (MEM_INIT_FILE != "") begin
        if   (INIT_FILE_BIN==1) $readmemb(MEM_INIT_FILE, RAM);
        else                    $readmemh(MEM_INIT_FILE, RAM);
    end
end

always @(posedge clk)
begin
    dout <= RAM[addr];
end

generate genvar i;
for (i = 0; i < NUM_BYTES; i = i+1)
begin
always @(posedge clk)
begin
    if (we[i])
        RAM[addr][8 * (i + 1) - 1 : i * 8] <= di[8 * (i + 1) - 1 : i * 8];
    end 
end
endgenerate

endmodule
