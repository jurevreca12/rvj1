// Assume instruction memory is first, and there is no overlap.

module bytewrite_sram_wrap #(
    parameter int XLEN=32,
    parameter string IMEM_INIT_FILE="",
    parameter string DMEM_INIT_FILE="",
    parameter int IMEM_INIT_FILE_BIN=0,
    parameter int DMEM_INIT_FILE_BIN=0,
    parameter int IMEM_BASE_ADDR,
    parameter int DMEM_BASE_ADDR,
    parameter int IMEM_SIZE_WORDS,
    parameter int DMEM_SIZE_WORDS,
    parameter int IDLEN = 4,
    localparam int NBytes = XLEN / 8,
    localparam int IMemSizeBytes = IMEM_SIZE_WORDS * 4,
    localparam int DMemSizeBytes = DMEM_SIZE_WORDS * 4,
    localparam int MemSizeBytesTotal = IMemSizeBytes + DMemSizeBytes,
    localparam int IMemEndAddr = IMEM_BASE_ADDR + IMemSizeBytes,
    localparam int DMemEndAddr = DMEM_BASE_ADDR + DMemSizeBytes,
    localparam int EndAddr = IMEM_BASE_ADDR + MemSizeBytesTotal
)(
    input logic clk_i,
    input logic rstn_i,

    // Interface to instr memory
    input  logic [XLEN-1:0]   instr_req_addr_i,
    input  logic [XLEN-1:0]   instr_req_data_i,
    input  logic [NBytes-1:0] instr_req_strobe_i,
    input  logic              instr_req_write_i,
    input  logic              instr_req_valid_i,
    input  logic [IDLEN-1:0]  instr_req_id_i,
    output logic              instr_req_ready_o,

    output logic [XLEN-1:0]   instr_rsp_data_o,
    output logic              instr_rsp_error_o,
    output logic              instr_rsp_valid_o,
    output logic [IDLEN-1:0]  instr_rsp_id_o,
    input  logic              instr_rsp_ready_i,

    // Interface to data memory
    input  logic [XLEN-1:0]   data_req_addr_i,
    input  logic [XLEN-1:0]   data_req_data_i,
    input  logic [NBytes-1:0] data_req_strobe_i,
    input  logic              data_req_write_i,
    input  logic [IDLEN-1:0]  data_req_id_i,
    input  logic              data_req_valid_i,
    output logic              data_req_ready_o,


    output logic [XLEN-1:0]   data_rsp_data_o,
    output logic              data_rsp_error_o,
    output logic [IDLEN-1:0]  data_rsp_id_o,
    output logic              data_rsp_valid_o,
    input  logic              data_rsp_ready_i
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

    mem_req_t dram_req;
    mem_rsp_t dram_rsp;
    logic dram_req_valid, dram_req_ready, dram_req_fire, dram_req_fire_r;
    logic dram_addr_valid;
    logic dram_rsp_err;
    logic [IDLEN-1:0] dram_rsp_id;
    logic [XLEN-1:0] dram_rsp_data;

    mem_req_t iram_req;
    logic iram_req_valid, iram_req_fire, iram_req_fire_r;
    logic iram_rsp_valid;
    logic iram_addr_valid;
    logic iram_req_err;
    logic iram_rsp_err;
    logic [IDLEN-1:0] iram_rsp_id;
    logic [XLEN-1:0] iram_rsp_data;

    assign iram_addr_valid = ((iram_req.addr >= IMEM_BASE_ADDR) &&
                              (iram_req.addr  < IMemEndAddr) &&
                              (iram_req.addr [1:0] == 2'b00));
    // data can read/write any address
    assign dram_addr_valid = ((dram_req.addr >= IMEM_BASE_ADDR) &&
                              (dram_req.addr < EndAddr) &&
                              (dram_req.addr[1:0] == 2'b00));
    assign dram_req_fire = dram_req_valid && data_rsp_ready_i;
    assign iram_req_fire = iram_req_valid && instr_rsp_ready_i;
    assign iram_req_err = (~iram_addr_valid) || (iram_req.strobe != 4'b1111) || (iram_req.write);

    skidbuffer #(
        .DTYPE(mem_req_t)
    ) dram_req_buff (
        .clk  (clk_i),
        .rstn (rstn_i),

        .input_valid  (data_req_valid_i),
        .input_ready  (data_req_ready_o),
        .input_data   ({data_req_id_i, data_req_addr_i, data_req_data_i, data_req_strobe_i, data_req_write_i}),

        .output_valid (dram_req_valid),
        .output_ready (data_rsp_ready_i),
        .output_data  (dram_req),

        // verilator lint_off PINCONNECTEMPTY
        .empty ()
        // verilator lint_on PINCONNECTEMPTY
    );

    skidbuffer #(
        .DTYPE(mem_req_t)
    ) iram_req_buff (
        .clk  (clk_i),
        .rstn (rstn_i),

        .input_valid  (instr_req_valid_i),
        .input_ready  (instr_req_ready_o),
        .input_data   ({instr_req_id_i, instr_req_addr_i, instr_req_data_i, instr_req_strobe_i, instr_req_write_i}),

        .output_valid (iram_req_valid),
        .output_ready (instr_rsp_ready_i),
        .output_data  (iram_req),

        // verilator lint_off PINCONNECTEMPTY
        .empty ()
        // verilator lint_on PINCONNECTEMPTY
    );

    bytewrite_sram #(
        .MEM_INIT_FILE0(IMEM_INIT_FILE),
        .MEM_INIT_FILE1(DMEM_INIT_FILE),
        .INIT_FILE_BIN0(IMEM_INIT_FILE_BIN),
        .INIT_FILE_BIN1(DMEM_INIT_FILE_BIN),
        .MEM_SIZE_WORDS0(IMEM_SIZE_WORDS),
        .MEM_SIZE_WORDS1(DMEM_SIZE_WORDS)
    ) mem (
        .clk     (clk_i),
        .strobe0 (dram_req.strobe),
        .write0  (dram_req.write),
        .valid0  (dram_req_fire && dram_addr_valid),
        .addr0   (dram_req.addr[$clog2(MemSizeBytesTotal)-1:2]), // convert to word address
        .din0    (dram_req.data),
        .dout0   (dram_rsp_data),

        .valid1  (iram_req_fire && iram_addr_valid),
        .addr1   (iram_req.addr[$clog2(MemSizeBytesTotal)-1:2]),
        .dout1   (iram_rsp_data)
    );
    register dram_req_fire_reg (
        .clk(clk_i), .rstn(rstn_i), .ce(1'b1),          .in(dram_req_fire),    .out(dram_req_fire_r)
    );
    register dram_req_err_reg (
        .clk(clk_i), .rstn(rstn_i), .ce(dram_req_fire), .in(~dram_addr_valid), .out(dram_rsp_err)
    );
    register #(.DTYPE(logic [IDLEN-1:0])) dram_req_id_reg (
        .clk(clk_i), .rstn(rstn_i), .ce(dram_req_fire), .in(dram_req.id),      .out(dram_rsp_id)
    );
    register iram_req_fire_req (
        .clk(clk_i), .rstn(rstn_i), .ce(1'b1),          .in(iram_req_fire),    .out(iram_req_fire_r)
    );
    register iram_req_err_reg (
        .clk(clk_i), .rstn(rstn_i), .ce(iram_req_fire), .in(iram_req_err),     .out(iram_rsp_err)
    );
    register #(.DTYPE(logic [IDLEN-1:0])) iram_req_id_reg (
        .clk(clk_i), .rstn(rstn_i), .ce(iram_req_fire), .in(iram_req.id),      .out(iram_rsp_id)
    );
    skidbuffer #(
        .DTYPE(mem_rsp_t)
    ) dram_rsp_buff (
        .clk  (clk_i),
        .rstn (rstn_i),

        .input_valid  (dram_req_fire_r),
        .input_ready  (),
        .input_data   ({dram_rsp_id, dram_rsp_data, dram_rsp_err}),

        .output_valid (data_rsp_valid_o),
        .output_ready (data_rsp_ready_i),
        .output_data  ({data_rsp_id_o, data_rsp_data_o, data_rsp_error_o}),

        // verilator lint_off PINCONNECTEMPTY
        .empty ()
        // verilator lint_on PINCONNECTEMPTY
    );
    skidbuffer #(
        .DTYPE(mem_rsp_t)
    ) iram_rsp_buff (
        .clk  (clk_i),
        .rstn (rstn_i),

        .input_valid  (iram_req_fire_r),
        .input_ready  (),
        .input_data   ({iram_rsp_id, iram_rsp_data, iram_rsp_err}),

        .output_valid (instr_rsp_valid_o),
        .output_ready (instr_rsp_ready_i),
        .output_data  ({instr_rsp_id_o, instr_rsp_data_o, instr_rsp_error_o}),

        // verilator lint_off PINCONNECTEMPTY
        .empty ()
        // verilator lint_on PINCONNECTEMPTY
    );

endmodule
