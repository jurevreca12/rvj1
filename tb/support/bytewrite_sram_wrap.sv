// Single-Port BRAM with Byte-wide Write Enable
// Read-First mode
// Single-process description
// Compact description of the write with a generate-for
//   statement
// Column width and number of columns easily configurable
//
// bytewrite_ram_1b.v
//

module bytewrite_sram_wrap #(
    parameter string MEM_INIT_FILE="out.hex",
    parameter int INIT_FILE_BIN=1,
    parameter int MEM_SIZE_WORDS=2**12,
    parameter int DATA_WIDTH=32,
    localparam int ADDR_WIDTH = $clog2(MEM_SIZE_WORDS),
    localparam int NUM_BYTES = DATA_WIDTH / 8,
    localparam int MEM_SIZE_BYTES = MEM_SIZE_WORDS * 4
)(
    input logic clk_i,
    input logic rstn_i,

    input  logic                  req_i,
    output logic                  rvalid_o,
    input  logic [DATA_WIDTH-1:0] addr_i,
    output logic [DATA_WIDTH-1:0] rdata_o,
    input  logic [NUM_BYTES-1:0]  we_i,
    input  logic [DATA_WIDTH-1:0] wdata_i,
    output  logic                 wvalid_o,
    output logic                  err_o
);

bytewrite_sram #(
    .MEM_INIT_FILE(MEM_INIT_FILE),
    .INIT_FILE_BIN(INIT_FILE_BIN),
    .MEM_SIZE_WORDS(MEM_SIZE_WORDS)
) mem (
    .clk  (clk_i),
    .we   (we_i),
    .addr (addr_i[MEM_SIZE_BYTES-1:2]), // convert to word address
    .din  (wdata_i),
    .dout (rdata_o)
);

// error logic
logic instr_is_err;
assign instr_is_err = 1'b0; // (addr_i > MEM_SIZE_BYTES);
always @(posedge clk_i) begin
    if (~rstn_i) begin
        err_o <= 1'b0;
    end
    else begin
    if (req_i)
        err_o <= instr_is_err;
    else
        err_o <= 1'b0;
    end
end

// valid logic
always @(posedge clk_i) begin
    if (~rstn_i) begin
        rvalid_o <= 1'b0;
        wvalid_o <= 1'b0;
    end
    else begin
        rvalid_o <= req_i;
        wvalid_o <= |we_i; // bitwise or
    end
end
endmodule
