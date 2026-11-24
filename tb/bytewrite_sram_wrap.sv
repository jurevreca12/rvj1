// Assume instruction memory is first, and there is no overlap.

module bytewrite_sram_wrap #(
    parameter int XLEN=32,
    parameter string MEM_INIT_FILE="",
    parameter int MEM_BASE_ADDR,
    parameter int MEM_SIZE_WORDS,
    parameter int IDLEN = 4,
    localparam int NBytes = XLEN / 8,
    localparam int MemSizeBytes = MEM_SIZE_WORDS * 4,
    localparam int EndAddr = MEM_BASE_ADDR + MemSizeBytes
)(
    input logic clk_i,
    input logic rstn_i,

    // Interface to memory
    input  logic [XLEN-1:0]   mem_req_addr_i,
    input  logic [XLEN-1:0]   mem_req_data_i,
    input  logic [NBytes-1:0] mem_req_strobe_i,
    input  logic              mem_req_write_i,
    input  logic              mem_req_valid_i,
    input  logic [IDLEN-1:0]  mem_req_id_i,
    output logic              mem_req_ready_o,

    output logic [XLEN-1:0]   mem_rsp_data_o,
    output logic              mem_rsp_error_o,
    output logic              mem_rsp_valid_o,
    output logic [IDLEN-1:0]  mem_rsp_id_o,
    input  logic              mem_rsp_ready_i
);
    typedef struct packed {
        logic [IDLEN-1:0]  id;
        logic [XLEN-1:0]   addr;
        logic [XLEN-1:0]   data;
        logic [NBytes-1:0] strobe;
        logic              write;
    } mem_req_t;

    typedef struct packed {
        logic [IDLEN-1:0]  id;
        logic [XLEN-1:0] data;
        logic            error;
    } mem_rsp_t;


    mem_req_t ram_req;
    logic ram_req_valid, ram_req_fire, ram_req_fire_r;
    logic ram_addr_valid;
    logic ram_req_err;
    logic ram_rsp_err;
    logic [IDLEN-1:0] ram_rsp_id;
    logic [XLEN-1:0] ram_rsp_data;
    logic supported_strobe;

    assign ram_addr_valid = ((ram_req.addr >= MEM_BASE_ADDR) &&
                             (ram_req.addr  < EndAddr) &&
                             (ram_req.addr [1:0] == 2'b00));
    assign ram_req_fire = ram_req_valid && mem_rsp_ready_i;
    assign supported_strobe = (ram_req.strobe == 4'b1111) || (ram_req.strobe == 4'b1100);
    assign ram_req_err = (~ram_addr_valid) || (~supported_strobe) || ram_req.write;

    skidbuffer #(
        .DTYPE(mem_req_t)
    ) ram_req_buff (
        .clk  (clk_i),
        .rstn (rstn_i),
        .clear(1'b0),

        .input_valid  (mem_req_valid_i),
        .input_ready  (mem_req_ready_o),
        .input_data   ({mem_req_id_i, mem_req_addr_i, mem_req_data_i, mem_req_strobe_i, mem_req_write_i}),

        .output_valid (ram_req_valid),
        .output_ready (mem_rsp_ready_i),
        .output_data  (ram_req),

        // verilator lint_off PINCONNECTEMPTY
        .empty ()
        // verilator lint_on PINCONNECTEMPTY
    );

    bytewrite_sram #(
        .MEM_INIT_FILE(MEM_INIT_FILE),
        .INIT_FILE_BIN(0),
        .MEM_SIZE_WORDS(MEM_SIZE_WORDS)
    ) mem (
        .clk   (clk_i),
        .rstn  (rstn_i),
        .strobe(ram_req.strobe),
        .write (ram_req.write),
        .valid (ram_req_fire && ram_addr_valid),
        .addr  (ram_req.addr[$clog2(MemSizeBytes)-1:2]), // convert to word address
        .din   (ram_req.data),
        .dout  (ram_rsp_data)
    );
    register ram_req_fire_reg (
        .clk(clk_i), .rstn(rstn_i), .ce(1'b1),          .in(ram_req_fire),    .out(ram_req_fire_r)
    );
    register ram_req_err_reg (
        .clk(clk_i), .rstn(rstn_i), .ce(ram_req_fire), .in(~ram_addr_valid), .out(ram_rsp_err)
    );
    register #(.DTYPE(logic [IDLEN-1:0])) dram_req_id_reg (
        .clk(clk_i), .rstn(rstn_i), .ce(ram_req_fire), .in(ram_req.id),      .out(ram_rsp_id)
    );
    skidbuffer #(
        .DTYPE(mem_rsp_t)
    ) ram_rsp_buff (
        .clk  (clk_i),
        .rstn (rstn_i),
        .clear(1'b0),

        .input_valid  (ram_req_fire_r),
        .input_ready  (),
        .input_data   ({ram_rsp_id, ram_rsp_data, ram_rsp_err}),

        .output_valid (mem_rsp_valid_o),
        .output_ready (mem_rsp_ready_i),
        .output_data  ({mem_rsp_id_o, mem_rsp_data_o, mem_rsp_error_o}),

        // verilator lint_off PINCONNECTEMPTY
        .empty ()
        // verilator lint_on PINCONNECTEMPTY
    );

endmodule
