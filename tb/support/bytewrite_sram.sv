// Single-Port BRAM with Byte-wide Write Enable
// Read-First mode
// Single-process description
// Compact description of the write with a generate-for 
//   statement
// Column width and number of columns easily configurable
//
// bytewrite_ram_1b.v
//

module bytewrite_sram #(
    parameter string MEM_INIT_FILE0="",
    parameter string MEM_INIT_FILE1="",
    parameter int INIT_FILE_BIN0=1,
    parameter int INIT_FILE_BIN1=1,
    parameter int MEM_SIZE_WORDS0 = 2**12,
    parameter int MEM_SIZE_WORDS1 = 2**12,
    localparam int MemSizeWordsTotal = MEM_SIZE_WORDS0 + MEM_SIZE_WORDS1,
    localparam int AddrWidth = $clog2(MemSizeWordsTotal),
    localparam int WordSize = 32,
    localparam int NumBytes = WordSize / 8
)(
    input                        clk,
    input  logic [NumBytes-1:0]  strobe0,
    input  logic                 write0,
    input  logic                 valid0,
    input  logic [AddrWidth-1:0] addr0,
    input  logic [WordSize-1:0]  din0,
    output logic [WordSize-1:0]  dout0,

    input  logic                 valid1,
    input  logic [AddrWidth-1:0] addr1,
    output logic [WordSize-1:0]  dout1
);

logic [WordSize-1:0] RAM [MemSizeWordsTotal];

initial begin
    string mem_init_file0, mem_init_file1;
    if (MEM_INIT_FILE0 != "") begin
        if   (INIT_FILE_BIN0==1) $readmemb(MEM_INIT_FILE0, RAM, 0);
        else                     $readmemh(MEM_INIT_FILE0, RAM, 0);
    end else begin
        $value$plusargs("MEM_INIT_FILE0=%s", mem_init_file0);
        if   (INIT_FILE_BIN0==1) $readmemb(mem_init_file0, RAM, 0);
        else                     $readmemh(mem_init_file0, RAM, 0);
    end
    if (MEM_INIT_FILE1 != "") begin
        if   (INIT_FILE_BIN1==1) $readmemb(MEM_INIT_FILE1, RAM, MEM_SIZE_WORDS0);
        else                     $readmemh(MEM_INIT_FILE1, RAM, MEM_SIZE_WORDS0);
    end else begin
        $value$plusargs("MEM_INIT_FILE1=%s", mem_init_file1);
        if   (INIT_FILE_BIN1==1) $readmemb(mem_init_file1, RAM, MEM_SIZE_WORDS0);
        else                     $readmemh(mem_init_file1, RAM, MEM_SIZE_WORDS0);
    end
end

always @(posedge clk)
begin
    if (valid0)
        dout0 <= RAM[addr0];
end

always @(posedge clk)
begin
    if (valid1)
        dout1 <= RAM[addr1];
end

generate genvar i;
for (i = 0; i < NumBytes; i = i+1)
begin: gen_per_byte_we
always @(posedge clk)
begin
    if (strobe0[i] & write0 & valid0)
        RAM[addr0][8 * (i + 1) - 1 : i * 8] <= din0[8 * (i + 1) - 1 : i * 8];
    end
end
endgenerate
endmodule
