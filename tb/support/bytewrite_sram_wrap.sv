// Single-Port BRAM with Byte-wide Write Enable
// Read-First mode
// Single-process description
// Compact description of the write with a generate-for
//   statement
// Column width and number of columns easily configurable
//
// bytewrite_ram_1b.v
//
// A low performance memory interface for SRAM.
// Just for basic simulation!

module bytewrite_sram_wrap #(
    parameter string MEM_INIT_FILE="out.hex",
    parameter int INIT_FILE_BIN=1,
    parameter int DATA_WIDTH=32,
    parameter int BASE_ADDR,
    parameter int MEM_SIZE_WORDS,
    localparam int NumBytes = DATA_WIDTH / 8,
    localparam int MemSizeBytes = MEM_SIZE_WORDS * 4,
    localparam int AddrWidth = $clog2(MemSizeBytes),
    localparam int EndAddr = BASE_ADDR + MemSizeBytes
)(
    input logic clk_i,
    input logic rstn_i,

    input  logic [DATA_WIDTH-1:0] req_addr_i,
    input  logic [DATA_WIDTH-1:0] req_data_i,
    input  logic [NumBytes-1:0]   req_strobe_i,
    input  logic                  req_write_i,
    input  logic                  req_valid_i,
    output logic                  req_ready_o,

    output logic [DATA_WIDTH-1:0] rsp_data_o,
    output logic                  rsp_error_o,
    output logic                  rsp_valid_o,
    input  logic                  rsp_ready_i
);
    typedef enum logic [1:0] {
        eREADY,
        eWAIT
    } bw_sram_fsm_e;
    bw_sram_fsm_e state, state_next;
    logic rspready, transact, addr_valid;

    assign req_ready_o = (state == eREADY);
    assign addr_valid = req_addr_i >= BASE_ADDR && req_addr_i < EndAddr;
    bytewrite_sram #(
        .MEM_INIT_FILE(MEM_INIT_FILE),
        .INIT_FILE_BIN(INIT_FILE_BIN),
        .MEM_SIZE_WORDS(MEM_SIZE_WORDS)
    ) mem (
        .clk    (clk_i),
        .strobe (req_strobe_i),
        .write  (req_write_i),
        .valid  (req_valid_i && req_ready_o && addr_valid),
        .addr   (req_addr_i[$clog2(MemSizeBytes)-1:2]), // convert to word address
        .din    (req_data_i),
        .dout   (rsp_data_o)
    );

    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            rsp_error_o <= 1'b0;
        else if (req_valid_i && req_ready_o)
            rsp_error_o <= ~addr_valid;
    end
    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            rsp_valid_o <= 1'b0;
        else if (req_valid_i && req_ready_o)
            rsp_valid_o <= 1'b1;
        else
            rsp_valid_o <= 1'b0;
    end

    always_comb begin
        rspready = (state == eWAIT)  && rsp_ready_i;
        transact = (state == eREADY) && req_ready_o && req_valid_i;
    end

    always_comb begin
        state_next = rspready ? eREADY : state;
        state_next = transact ? eWAIT  : state_next;
     end
    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            state <= eWAIT;
        else
            state <= state_next;
    end
endmodule
