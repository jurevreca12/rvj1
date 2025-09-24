////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_lsu                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The load-store unit.                                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import jedro_1_defines::*;

module jedro_1_lsu (
    input logic clk_i,
    input logic rstn_i,

    // Interface to/from the decoder/ALU
    input  logic                      lsu_valid_i,
    output logic                      lsu_ready_o,
    input  lsu_ctrl_e                 lsu_cmd_i,
    input  logic [DATA_WIDTH-1:0]     lsu_addr_i,
    input  logic [DATA_WIDTH-1:0]     lsu_data_i,
    input  logic [REG_ADDR_WIDTH-1:0] lsu_regdest_i,

    // Interface to the register file
    output logic [    DATA_WIDTH-1:0] rf_data_o,
    output logic                      rf_wb_o,    // write-back
    output logic [REG_ADDR_WIDTH-1:0] rf_dest_o,

    // Interface to the core controller
    output logic                  ctrl_misaligned_load_o,
    output logic                  ctrl_misaligned_store_o,
    output logic                  ctrl_bus_error_o,
    output logic [DATA_WIDTH-1:0] ctrl_exception_addr_o,

    // Interface to data RAM
    output logic [DATA_WIDTH-1:0] data_req_addr_o,
    output logic [DATA_WIDTH-1:0] data_req_data_o,
    output logic [3:0]            data_req_strobe_o,
    output logic                  data_req_write_o,
    output logic                  data_req_valid_o,
    input  logic                  data_req_ready_i,

    input  logic [DATA_WIDTH-1:0] data_rsp_data_i,
    input  logic                  data_rsp_error_i,
    input  logic                  data_rsp_valid_i,
    output logic                  data_rsp_ready_o
);

lsu_ctrl_e                 input_buffer_cmd;
logic [DATA_WIDTH-1:0]     input_buffer_addr;
logic [DATA_WIDTH-1:0]     input_buffer_data;
logic [REG_ADDR_WIDTH-1:0] input_buffer_regdest;

lsu_ctrl_e                 output_buffer_cmd;
logic [DATA_WIDTH-1:0]     output_buffer_addr;
logic [DATA_WIDTH-1:0]     output_buffer_data;
logic [REG_ADDR_WIDTH-1:0] output_buffer_regdest;

lsu_ctrl_e                 selected_request_cmd;
logic [DATA_WIDTH-1:0]     selected_request_addr;
logic [DATA_WIDTH-1:0]     selected_request_data;
logic [REG_ADDR_WIDTH-1:0] selected_request_regdest;

logic input_buffer_clock_enable, output_buffer_clock_enable, use_buffered_data;


logic load, flow, fill, flush, unload;
typedef enum logic [1:0] {
  eEMPTY,   // both input and output buffers empty
  eBUSY,    // output buffer holds data, input buffer empty
  eFULL     // both buffers hold data
} lsu_fsm_e;
lsu_fsm_e state, state_next;


logic [DATA_WIDTH-1:0]     data_rsp_data_buff;
logic [REG_ADDR_WIDTH-1:0] data_rsp_regdest_buff;
/*************************************
* Skid Buffer the incoming requests
*************************************/
always_ff @(posedge clk_i) begin
    if (~rstn_i) begin
        input_buffer_cmd     <= 0;
        input_buffer_addr    <= 0;
        input_buffer_data    <= 0;
        input_buffer_regdest <= 0;
    end
    else if(input_buffer_clock_enable)
        input_buffer_cmd     <= lsu_cmd_i;
        input_buffer_addr    <= lsu_addr_i;
        input_buffer_data    <= lsu_data_i;
        input_buffer_regdest <= lsu_regdest_i;
end

assign selected_request_cmd     = use_buffered_data ? input_buffer_cmd     : lsu_cmd_i;
assign selected_request_addr    = use_buffered_data ? input_buffer_addr    : lsu_addr_i;
assign selected_request_data    = use_buffered_data ? input_buffer_data    : lsu_data_i;
assign selected_request_regdest = use_buffered_data ? input_buffer_regdest : lsu_regdest_i;

always_ff @(posedge clk_i) begin
  if (~rstn_i) begin
      output_buffer_cmd     <= 0;
      output_buffer_addr    <= 0;
      output_buffer_data    <= 0;
      output_buffer_regdest <= 0;
  end
  else if (output_buffer_clock_enable) begin
      output_buffer_cmd     <= selected_request_cmd;
      output_buffer_addr    <= selected_request_addr;
      output_buffer_data    <= selected_request_data;
      output_buffer_regdest <= selected_request_regdest;
  end
end

/*************************************
* Core Interface
*************************************/
assign lsu_fire = lsu_valid_i && lsu_ready_o;
always_ff @(posedge clk_i) begin
  if (~rstn_i)
    lsu_ready_o <= 1'b0;
  else
    lsu_ready_o <= (state_next != eFULL);
end

/*************************************
* Register File Interface
*************************************/
assign rf_data_o = data_rsp_data_buff;
assign rf_dest_o = data_rsp_regdest_buff;

always_ff @(posedge clk_i) begin
  if (~rstn_i)
    rf_wb_o <= 1'b0;
  else
    rf_wb_o <= instr_rsp_fire;
end

always_ff @(posedge clk_i) begin
  if (~rstn_i)
    data_rsp_regdest_buff <= 0;
  else if (data_req_fire)
    data_rsp_regdest_buff <= output_buffer_regdest;
end


/*************************************
* Data Memory Interface
*************************************/
assign data_req_fire = data_req_valid_o && data_req_ready_i;
assign data_rsp_fire = data_rsp_valid_i && data_rsp_ready_o;

assign data_req_addr_o   = output_buffer_addr;
assign data_req_data_o   = output_buffer_data;
assign data_req_strobe_o = 4'b1111; // TODO
assign data_req_write_o  = (output_buffer_cmd == LSU_STORE_BYTE ||
                            output_buffer_cmd == LSU_STORE_HALF_WORD ||
                            output_buffer_cmd == LSU_STORE_WORD);

always_ff @(posedge clk_i) begin
  if (~rstn_i) begin
    data_req_valid_o <= 1'b0;
    data_rsp_ready_o <= 1'b0;
  end
  else begin
    data_req_valid_o <= (state_next != eFULL);
    data_rsp_ready_o <= (state_next != eFULL); // TODO: je to prav? a lahko data_rsp_regdest_buff preplavi?
  end
end

always_ff @(posedge clk_i) begin
  if (~rstn_i)
    data_rsp_data_buff <= 0;
  else if (data_rsp_fire)
    data_rsp_data_buff <= data_rsp_data_i;
end

/*************************************
* Finite State Machine (FSM)
*************************************/
always_comb begin
    load   = (state == eEMPTY) &&  lsu_fire;
    flow   = (state == eBUSY)  &&  lsu_fire  &&  data_rsp_fire;
    fill   = (state == eBUSY)  &&  lsu_fire  && ~data_rsp_fire;
    unload = (state == eBUSY)  && ~lsu_fire  &&  data_rsp_fire;
    flush  = (state == eFULL)  && ~lsu_fire  &&  data_rsp_fire;
end

always_comb begin
    output_buffer_clock_enable = load || flow || flush;
    input_buffer_clock_enable  = fill                 ;
    use_buffered_data          = flush                ;
end

always_comb begin
    state_next = load   ? eBUSY  : state;
    state_next = flow   ? eBUSY  : state_next;
    state_next = fill   ? eFULL  : state_next;
    state_next = flush  ? eBUSY  : state_next;
    state_next = unload ? eEMPTY : state_next;
end
always_ff @(posedge clk_i) begin
    if (~rstn_i)
        state <= eEMPTY;
    else
        state <= state_next;
end
endmodule

