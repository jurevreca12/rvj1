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
    parameter int DATA_WIDTH=32,
    parameter string MEM_INIT_FILE0="text.hex",
    parameter string MEM_INIT_FILE1="data.hex",
    parameter int INIT_FILE_BIN0=1,
    parameter int INIT_FILE_BIN1=0,
    parameter int BASE_ADDR0,
    parameter int BASE_ADDR1,
    parameter int MEM_SIZE_WORDS0,
    parameter int MEM_SIZE_WORDS1,
    localparam int NumBytes = DATA_WIDTH / 8,
    localparam int MemSizeBytes0 = MEM_SIZE_WORDS0 * 4,
    localparam int MemSizeBytes1 = MEM_SIZE_WORDS1 * 4,
    localparam int MemSizeBytesTotal = MemSizeBytes0 + MemSizeBytes1,
    localparam int EndAddr = BASE_ADDR0 + MemSizeBytesTotal
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
    input  logic                  rsp_ready_i,

    input  logic [DATA_WIDTH-1:0] req_addr1_i,
    input  logic                  req_valid1_i,
    output logic                  req_ready1_o,

    output logic [DATA_WIDTH-1:0] rsp_data1_o,
    output logic                  rsp_valid1_o,
    input  logic                  rsp_ready1_i
);

    typedef enum logic [1:0] {
        eREADY,
        eWAIT
    } bw_sram_fsm_e;
    bw_sram_fsm_e state0, state0_next, state1, state1_next;
    logic rspready0, transact0, rspready1, transact1, addr_valid0, addr_valid1;

    assign req_ready_o = (state0 == eREADY);
    assign addr_valid0 = req_addr_i >= BASE_ADDR0 && req_addr_i < EndAddr;
    bytewrite_sram #(
        .BASE_ADDR0(BASE_ADDR0),
        .BASE_ADDR1(BASE_ADDR1),
        .MEM_INIT_FILE0(MEM_INIT_FILE0),
        .MEM_INIT_FILE1(MEM_INIT_FILE1),
        .INIT_FILE_BIN0(INIT_FILE_BIN0),
        .INIT_FILE_BIN1(INIT_FILE_BIN1),
        .MEM_SIZE_WORDS0(MEM_SIZE_WORDS0),
        .MEM_SIZE_WORDS1(MEM_SIZE_WORDS1)
    ) mem (
        .clk     (clk_i),
        .strobe0 (req_strobe_i),
        .write0  (req_write_i),
        .valid0  (req_valid_i && req_ready_o && addr_valid0),
        .addr0   (req_addr_i[$clog2(MemSizeBytesTotal)-1:2]), // convert to word address
        .din0    (req_data_i),
        .dout0   (rsp_data_o),

        .valid1  (req_valid1_i && req_ready1_o && addr_valid1),
        .addr1   (req_addr1_i[$clog2(MemSizeBytesTotal)-1:2]),
        .dout1   (rsp_data1_o)
    );

    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            rsp_error_o <= 1'b0;
        else if (req_valid_i && req_ready_o)
            rsp_error_o <= ~addr_valid0;
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
        rspready0 = (state0 == eWAIT)  && rsp_ready_i;
        transact0 = (state0 == eREADY) && req_ready_o && req_valid_i;
    end

    always_comb begin
        state0_next = rspready0 ? eREADY : state0;
        state0_next = transact0 ? eWAIT  : state0_next;
     end
    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            state0 <= eWAIT;
        else
            state0 <= state0_next;
    end

    // Read port
    assign addr_valid1 = req_addr1_i >= BASE_ADDR0 && req_addr1_i < EndAddr;
    assign req_ready1_o = (state1 == eREADY);
    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            rsp_valid1_o <= 1'b0;
        else if (req_valid1_i && req_ready1_o)
            rsp_valid1_o <= 1'b1;
        else
            rsp_valid1_o <= 1'b0;
    end
    always_comb begin
        rspready1 = (state1 == eWAIT)  && rsp_ready1_i;
        transact1 = (state1 == eREADY) && req_ready1_o && req_valid1_i;
    end

    always_comb begin
        state1_next = rspready1 ? eREADY : state1;
        state1_next = transact1 ? eWAIT  : state1_next;
     end
    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            state1 <= eWAIT;
        else
            state1 <= state1_next;
    end
endmodule
