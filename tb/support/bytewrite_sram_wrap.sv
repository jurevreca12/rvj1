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

    input  logic [DATA_WIDTH-1:0] req_addr_i,
    input  logic [DATA_WIDTH-1:0] req_data_i,
    input  logic [NUM_BYTES-1:0]  req_strobe_i,
    input  logic                  req_write_i,
    input  logic                  req_valid_i,
    output logic                  req_ready_o,

    output logic [DATA_WIDTH-1:0] rsp_data_o,
    output logic                  rsp_err_o,
    output logic                  rsp_valid_o,
    input  logic                  rsp_ready_i
);

bytewrite_sram #(
    .MEM_INIT_FILE(MEM_INIT_FILE),
    .INIT_FILE_BIN(INIT_FILE_BIN),
    .MEM_SIZE_WORDS(MEM_SIZE_WORDS)
) mem (
    .clk    (clk_i),
    .strobe (req_strobe_i),
    .write  (req_write_i),
    .valid  (req_valid_i),
    .addr   (req_addr_i[$clog2(MEM_SIZE_BYTES)-1:2]), // convert to word address
    .din    (req_data_i),
    .dout   (rsp_data_o)
);

// Always ready for requests
assign req_ready_o = 1'b1;

// no error logic for now
assign rsp_err_o = 1'b0;

// valid logic
always_ff @(posedge clk_i) begin
    if (~rstn_i)
        rsp_valid_o <= 1'b0;
    else
        rsp_valid_o <= req_valid_i;
end
endmodule
