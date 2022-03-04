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

parameter MEM_INIT_FILE="";
parameter SIZE = 2**12; 
parameter ADDR_WIDTH = $clog2(SIZE*4); 
parameter COL_WIDTH = 8; 
parameter NB_COL = 4;

input clk;
input [NB_COL-1:0] we;
input [ADDR_WIDTH-1:0] addr;
input [NB_COL*COL_WIDTH-1:0] di;
output reg [NB_COL*COL_WIDTH-1:0] dout;

reg [NB_COL*COL_WIDTH-1:0] RAM [SIZE-1:0];

integer flen;
string file;
initial begin
    if (MEM_INIT_FILE != "") begin
        file = MEM_INIT_FILE;
        flen = file.len();
        if(file.substr(flen-4,flen-1) == ".mem") begin
            $readmemb(MEM_INIT_FILE, RAM);
        end
        else begin
            $readmemh(MEM_INIT_FILE, RAM);
        end
    end
end

always @(posedge clk)
begin
    dout <= RAM[addr >> 2];
end

generate genvar i;
for (i = 0; i < NB_COL; i = i+1)
begin
always @(posedge clk)
begin
    if (we[i])
        RAM[addr >> 2][(i+1)*COL_WIDTH-1:i*COL_WIDTH] <= di[(i+1)*COL_WIDTH-1:i*COL_WIDTH];
    end 
end
endgenerate

endmodule
