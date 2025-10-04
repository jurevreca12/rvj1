////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_lsu                                                   //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The load-store unit.                                       //
//                                                                            //
//        |                      |                                            //
//        |     +---------+      |                                            //
// lsu_if |     | request |      | data_req_if                                //
//      --|---->| buffer  |---|----->                                         //
//        |     |         |   |  |                                            //
//        |     +---------+   |  |                                            //
//        |                   |  |                                            //
//        |     +----------+  |  |                                            //
//  rf_if |     | active   |  |  |                                            //
//      <---+<--| request  |<-+  |                                            //
//        | |   | buffer   |     |                                            //
//        | |   +----------+     |                                            //
//        | |                    |                                            //
//        | |   +----------+     |                                            //
//        | |   | response |     | data_rsp_if                                //
//        | +---- buffer   |<--------                                         //
//        |     |          |     |                                            //
//        |     +----------+     |                                            //
//        |                      |                                            //
//                                                                            //
// The LSU handles read and write requests in order.                          //
//                                                                            //
// The core should always be ready to handle responses. In case of writes     //
// that is not a big problem. In case of reads the core needs to stall.       //
//                                                                            //
// The data request and response interfaces, on the other hand, have no such  //
// restriction. This means that the LSU needs to be able to buffer the        //
// requests and stall the core while waiting for the responses.               //
//                                                                            //
// The risc-v spec allows fatal exceptions (e.g., bus errors) to be           //
// imprecise. This means we do not have to wait for each request on the bus   //
// to finnish, before issuing further requests.                               //
////////////////////////////////////////////////////////////////////////////////

import rvj1_defines::*;

module rvj1_lsu (
    input logic clk_i,
    input logic rstn_i,

    // Interface to/from the decoder/ALU/ctrl
    input  logic             lsu_valid_i,
    output logic             lsu_ready_o,
    input  lsu_ctrl_e        lsu_cmd_i,
    input  logic [XLEN-1:0]  lsu_addr_i,
    input  logic [XLEN-1:0]  lsu_data_i,
    input  logic [RALEN-1:0] lsu_regdest_i,

    // Interface to the register file
    output logic [XLEN-1:0]  rf_data_o,
    output logic             rf_wb_o,    // write-back
    output logic [RALEN-1:0] rf_dest_o,

    // Interface to the core controller
    output logic            ctrl_misaligned_load_o,
    output logic            ctrl_misaligned_store_o,
    output logic            ctrl_bus_error_o,
    output logic [XLEN-1:0] ctrl_exception_addr_o,

    // Interface to data RAM
    output logic [XLEN-1:0]   data_req_addr_o,
    output logic [XLEN-1:0]   data_req_data_o,
    output logic [NBYTES-1:0] data_req_strobe_o,
    output logic              data_req_write_o,
    output logic              data_req_valid_o,
    input  logic              data_req_ready_i,

    input  logic [XLEN-1:0] data_rsp_data_i,
    input  logic            data_rsp_error_i,
    input  logic            data_rsp_valid_i,
    output logic            data_rsp_ready_o
);

typedef struct packed {
  lsu_ctrl_e        cmd;
  logic [XLEN-1:0]  addr;
  logic [XLEN-1:0]  data;
  logic [RALEN-1:0] regdest;
} lsu_req_t;

typedef struct packed {
  lsu_ctrl_e        cmd;
  logic [RALEN-1:0] regdest;
} lsu_act_req_t;

typedef struct packed {
  logic [XLEN-1:0] data;
  logic            error;
} lsu_rsp_t;

typedef enum logic [1:0] {
  eRUN,   // waiting on requests
  eREAD,  // stall to finnish read
  eSTALL  // stall because buffer full
} lsu_state_e;
lsu_state_e state, state_next;

function automatic logic [3:0] cmd_to_strobe(input lsu_ctrl_e cmd);
  begin
    logic [3:0] strobe = {cmd[2], cmd[2], cmd[1], cmd[0]};
    return strobe;
  end
endfunction

function automatic logic is_write(input lsu_ctrl_e cmd);
  begin
      return cmd[4];
  end
endfunction

logic         req_buff_inp_ready;
lsu_req_t     req_buff_out_data;
logic         act_req_buff_out_valid;
lsu_act_req_t act_req_buff_out_data;
logic         act_req_buff_inp_ready;
logic         rsp_buff_out_valid;
lsu_rsp_t     rsp_buff_out_data;

logic retire_request;

logic data_req_fire, data_rsp_fire;
logic read_req, read_rsp, req_full, req_ready, rsp_full;

/*************************************
* Data Path
*************************************/
skidbuffer #(
  .WORD_WIDTH ($bits(lsu_req_t))
) request_buffer (
  .clk  (clk_i),
  .rstn (rstn_i),

  .input_valid  (lsu_valid_i && lsu_ready_o),
  .input_ready  (req_buff_inp_ready),
  .input_data   ({lsu_cmd_i, lsu_addr_i, lsu_data_i, lsu_regdest_i}),

  .output_valid (data_req_valid_o),
  .output_ready (data_req_ready_i),
  .output_data  (req_buff_out_data)
);
assign data_req_addr_o   = req_buff_out_data.addr;
assign data_req_data_o   = req_buff_out_data.data;
assign data_req_strobe_o = cmd_to_strobe(req_buff_out_data.cmd);
assign data_req_write_o  = req_buff_out_data.cmd[4];

assign data_req_fire = data_req_valid_o && data_req_ready_i;

assign data_rsp_ready_o = 1'b1;
assign data_rsp_fire = data_rsp_valid_i && data_rsp_ready_o;

skidbuffer #(
  .WORD_WIDTH ($bits(lsu_act_req_t))
) act_req_buffer (
  .clk  (clk_i),
  .rstn (rstn_i),

  .input_valid  (data_req_fire),
  .input_ready  (act_req_buff_inp_ready),
  .input_data   ({req_buff_out_data.cmd, req_buff_out_data.regdest}),

  .output_valid (act_req_buff_out_valid),
  .output_ready (retire_request),
  .output_data  (act_req_buff_out_data)
);
skidbuffer #(
  .WORD_WIDTH ($bits(lsu_rsp_t))
) response_buffer (
  .clk  (clk_i),
  .rstn (rstn_i),

  .input_valid  (data_rsp_valid_i),
  .input_ready  (data_rsp_ready_o),
  .input_data   ({data_rsp_data_i, data_rsp_error_i}),

  .output_valid (rsp_buff_out_valid),
  .output_ready (retire_request),
  .output_data  (rsp_buff_out_data)
);

/*************************************
* Reg File
*************************************/
assign rf_data_o = rsp_buff_out_data.data;
assign rf_dest_o = act_req_buff_out_data.regdest;
assign rf_wb_o   = (rsp_buff_out_valid &&
                    act_req_buff_out_valid &&
                    retire_request &&
                    ~is_write(act_req_buff_out_data.cmd));

/*************************************
* Control
*************************************/
register #(
  .WORD_WIDTH  (1),
  .RESET_VALUE (0)
) data_rsp_delay(
  .clk  (clk_i),
  .rstn (rstn_i),
  .ce   (1'b1),
  .in   (data_rsp_fire),
  .out  (retire_request)
);
assign lsu_ready_o = (state == eRUN) && req_buff_inp_ready && act_req_buff_inp_ready;

/*************************************
* FSM
*************************************/
always_comb begin
  read_req  = (state == eRUN)   && lsu_valid_i    && ~is_write(lsu_cmd_i);
  read_rsp  = (state == eREAD)  && retire_request && ~is_write(act_req_buff_out_data.cmd);
  req_full  = (state == eRUN)   && ~req_buff_inp_ready;
  rsp_full  = (state == eRUN)   && ~act_req_buff_inp_ready;
  req_ready = (state == eSTALL) && req_buff_inp_ready;
end
always_comb begin
  state_next = read_req  ? eREAD  : state;
  state_next = read_rsp  ? eRUN   : state_next;
  state_next = req_full  ? eSTALL : state_next;
  state_next = req_ready ? eRUN   : state_next;
end
always_ff @(posedge clk_i) begin
  if (~rstn_i)
    state <= eRUN;
  else
    state <= state_next;
end

`ifdef ASSERTIONS
  // There should be no response without a request.
  always_ff @(posedge clk_i) begin
    if (rsp_buff_out_valid)
      ghost_rsp: assert(act_req_buff_out_valid);
  end

  always_ff @(posedge clk_i) begin
    if (lsu_valid_i) begin
      // There should be no request if either req or act_req buffers are full.
      bad_req: assert(req_buff_inp_ready);
      bad_act: assert(act_req_buff_inp_read);
      // Requests can only be issued when in running state (no stall).
      state_r: assert(state == eRUN);
    end
  end
`endif

endmodule

