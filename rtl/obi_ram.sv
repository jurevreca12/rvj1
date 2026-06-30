module obi_ram #(
  parameter  string INIT_FILE="",
  parameter  int    INIT_FILE_BIN=0,
  parameter  int    DATA_WIDTH=32,
  parameter  int    ADDR_WIDTH=32,
  parameter  int    IDLEN=4,
  parameter  int    MEM_SIZE_WORDS,
  localparam int    NBytes=(DATA_WIDTH / 8),
  localparam int    MemAddrWidth=$clog2(MEM_SIZE_WORDS)
) (
  input  logic clk_i,
  input  logic rstn_i,

  input  logic [IDLEN-1:0]      obi_aid_i,
  input  logic                  obi_areq_i,
  output logic                  obi_agnt_o,
  input  logic [ADDR_WIDTH-1:0] obi_aaddr_i,
  input  logic                  obi_awe_i,
  input  logic [NBytes-1:0]     obi_abe_i,
  input  logic [DATA_WIDTH-1:0] obi_awdata_i,


  output logic [IDLEN-1:0]      obi_rid_o,
  output logic                  obi_rvalid_o,
  input  logic                  obi_rready_i,
  output logic [DATA_WIDTH-1:0] obi_rdata_o
);

  typedef struct packed {
    logic [IDLEN-1:0]        id;
    logic [MemAddrWidth-1:0] addr;
    logic [DATA_WIDTH-1:0]   data;
    logic [NBytes-1:0]       strobe;
    logic                    write;
  } obi_req_t;

  typedef struct packed {
    logic [IDLEN-1:0]      id;
    logic [DATA_WIDTH-1:0] data;
  } obi_rsp_t;

  obi_req_t act_req;
  logic act_req_valid, act_req_ready, act_req_fire, act_req_fire_r;

  logic [DATA_WIDTH-1:0] mem_data;
  logic                  rsp_buff_inp_ready;
  logic                  rsp_buff_almost_full, rsp_buff_full;
  logic [IDLEN-1:0]      rsp_id;

  fifo_handshake #(
    .dtype(obi_req_t),
    .DEPTH(3),
    .ALMOST_FULL_DEPTH(2)
  ) request_buffer (
    .clk_i         (clk_i),
    .rstn_i        (rstn_i),

    .input_valid_i (obi_areq_i),
    .input_ready_o (obi_agnt_o),
    .input_data_i  ({obi_aid_i, obi_aaddr_i[MemAddrWidth+1:2], obi_awdata_i, obi_abe_i, obi_awe_i}),

    .output_valid_o(act_req_valid),
    .output_ready_i(act_req_ready),
    .output_data_o (act_req),

    // verilator lint_off PINCONNECTEMPTY
    .full_o       (),
    .almost_full_o(),
    .empty_o      ()
    // verilator lint_on PINCONNECTEMPTY
  );

  assign act_req_ready = !(rsp_buff_almost_full || rsp_buff_full);
  assign act_req_fire = act_req_valid && act_req_ready;

  bytewrite_sram #(
    .WORD_SIZE      (DATA_WIDTH),
    .MEM_INIT_FILE  (INIT_FILE),
    .INIT_FILE_BIN  (INIT_FILE_BIN),
    .MEM_SIZE_WORDS (MEM_SIZE_WORDS)
  ) mem (
    .clk    (clk_i),
    .strobe (act_req.strobe),
    .write  (act_req.write),
    .valid  (act_req_fire),
    .addr   (act_req.addr),
    .din    (act_req.data),
    .dout   (mem_data)
  );

  register req_fire_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1),         .in(act_req_fire),     .out(act_req_fire_r)
  );
  register #(.DTYPE(logic [IDLEN-1:0])) dram_req_id_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(act_req_fire), .in(act_req.id),      .out(rsp_id)
  );

  fifo_handshake #(
    .dtype(obi_rsp_t),
    .DEPTH(3),
    .ALMOST_FULL_DEPTH(2)
  ) response_buffer (
    .clk_i        (clk_i),
    .rstn_i       (rstn_i),

    .input_valid_i (act_req_fire_r),
    .input_ready_o (rsp_buff_inp_ready),
    .input_data_i  ({rsp_id, mem_data}),

    .output_valid_o(obi_rvalid_o),
    .output_ready_i(obi_rready_i),
    .output_data_o ({obi_rid_o, obi_rdata_o}),

    .almost_full_o(rsp_buff_almost_full),

    // verilator lint_off PINCONNECTEMPTY
    .full_o       (rsp_buff_full),
    .empty_o      ()
    // verilator lint_on PINCONNECTEMPTY
  );

  `ifdef ASSERTIONS
    always_ff @(posedge clk_i) begin
      if (act_req_fire_r)
        no_req_dropped: assert(rsp_buff_inp_ready);
    end
  `endif
endmodule