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

/* verilator lint_off IMPORTSTAR */
import rvj1_defines::*;

typedef struct packed {
  lsu_ctrl_e        cmd;
  logic [XLEN-1:0]  addr;
  logic [XLEN-1:0]  data;
  logic [RALEN-1:0] regdest;
} lsu_req_t;

typedef struct packed {
  lsu_ctrl_e        cmd;
  logic [XLEN-1:0]  addr;
  logic [RALEN-1:0] regdest;
} lsu_act_req_t;

typedef struct packed {
  logic [XLEN-1:0] data;
  logic            error;
} lsu_rsp_t;

typedef enum logic [1:0] {
  eLSU_RUN,   // waiting on requests
  eLSU_READ,  // stall to finnish read
  eLSU_STALL  // stall because buffer full
} lsu_state_e;

function automatic logic is_write_cmd(input lsu_ctrl_e cmd);
  return cmd[3];
endfunction

function automatic logic [XLEN-1:0] sign_extend(logic [XLEN-1:0] data, lsu_ctrl_e cmd);
  logic [XLEN-1:0] ret;
  case (cmd)
    LSU_LOAD_BYTE:        ret = {{(XLEN-8){data[7]}},   data[7:0]};
    LSU_LOAD_HALF_WORD:   ret = {{(XLEN-16){data[15]}}, data[15:0]};
    LSU_LOAD_WORD:        ret = data;
    LSU_LOAD_BYTE_U:      ret = {{(XLEN-8){1'b0}},      data[7:0]};
    LSU_LOAD_HALF_WORD_U: ret = {{(XLEN-16){1'b0}},     data[15:0]};
    default:              ret = 32'h0000_0000;
  endcase
  return ret;
endfunction

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
    output logic            exc_load_addr_misaligned_o,
    output logic            exc_load_access_fault_o,
    output logic            exc_store_addr_misaligned_o,
    output logic            exc_store_access_fault_o,
    output logic [XLEN-1:0] exc_addr_o,

    // Interface to data RAM
    output logic [XLEN-1:0]   data_req_addr_o,
    output logic [XLEN-1:0]   data_req_data_o,
    output logic [NBYTES-1:0] data_req_strobe_o,
    output logic              data_req_write_o,
    output logic              data_req_valid_o,
    input  logic              data_req_ready_i,

    output logic              data_ctrl_cancel_o,

    input  logic [XLEN-1:0] data_rsp_data_i,
    input  logic            data_rsp_error_i,
    input  logic            data_rsp_valid_i,
    output logic            data_rsp_ready_o
);

lsu_state_e state, state_next;

logic         req_buff_inp_ready;
lsu_req_t     req_buff_out_data;
logic         act_req_buff_out_valid;
lsu_act_req_t act_req_buff_out_data;
logic         act_req_buff_inp_ready;
logic         rsp_buff_out_valid;
lsu_rsp_t     rsp_buff_out_data;
logic         act_req_buff_empty;
logic         resp_buff_ready;
logic         exception;

logic [XLEN-1:0] byte_select_read_data;

logic retire_request;

logic data_req_fire, data_rsp_fire;
logic read_req, read_rsp, req_full, req_ready;
logic store_addr_misaligned, load_addr_misaligned, addr_misaligned;


/*************************************
* Address Check
*************************************/
  lsu_addr_check lsu_addr_check_instr(
  .lsu_cmd_i     (lsu_cmd_i),
  .valid_i       (lsu_valid_i),
  .eff_addr_i    (lsu_addr_i[1:0]),
  .write_error_o (store_addr_misaligned),
  .read_error_o  (load_addr_misaligned)
);
assign addr_misaligned = store_addr_misaligned || load_addr_misaligned;
assign exc_load_addr_misaligned_o = load_addr_misaligned  && lsu_valid_i && lsu_ready_o;
assign exc_store_addr_misaligned_o = store_addr_misaligned && lsu_valid_i && lsu_ready_o;

/*************************************
* Data Path
*************************************/
skidbuffer #(
  .WORD_WIDTH ($bits(lsu_req_t))
) request_buffer (
  .clk  (clk_i),
  .rstn (rstn_i),

  .input_valid  (lsu_valid_i && lsu_ready_o && ~addr_misaligned),
  .input_ready  (req_buff_inp_ready),
  .input_data   ({lsu_cmd_i, lsu_addr_i, lsu_data_i, lsu_regdest_i}),

  .output_valid (data_req_valid_o),
  .output_ready (data_req_ready_i && act_req_buff_inp_ready),
  .output_data  (req_buff_out_data),

  .empty        ()
);
assign data_req_addr_o  = {req_buff_out_data.addr[31:2], 2'b00};
byte_select_write bsw_inst(
  .data(req_buff_out_data.data),
  .cmd(req_buff_out_data.cmd),
  .byteaddr(req_buff_out_data.addr[1:0]),
  .data_out(data_req_data_o)
);
cmd_to_strobe cmd_to_strobe_inst (
  .cmd(req_buff_out_data.cmd),
  .addr(req_buff_out_data.addr[1:0]),
  .strobe(data_req_strobe_o)
);
assign data_req_write_o  = is_write_cmd(req_buff_out_data.cmd);
assign data_req_fire = data_req_valid_o && data_req_ready_i;
assign data_rsp_fire = data_rsp_valid_i && data_rsp_ready_o;

// There is no speculative data writing/reading, thus no need to invalidate any requests
assign data_ctrl_cancel_o = 1'b0;

skidbuffer #(
  .WORD_WIDTH ($bits(lsu_act_req_t))
) act_req_buffer (
  .clk  (clk_i),
  .rstn (rstn_i),

  .input_valid  (data_req_fire),
  .input_ready  (act_req_buff_inp_ready),
  .input_data   ({req_buff_out_data.cmd, req_buff_out_data.addr, req_buff_out_data.regdest}),

  .output_valid (act_req_buff_out_valid),
  .output_ready (rsp_buff_out_valid),
  .output_data  (act_req_buff_out_data),

  .empty        (act_req_buff_empty)
);
skidbuffer #(
  .WORD_WIDTH ($bits(lsu_rsp_t))
) response_buffer (
  .clk  (clk_i),
  .rstn (rstn_i),

  .input_valid  (data_rsp_valid_i),
  .input_ready  (resp_buff_ready),
  .input_data   ({data_rsp_data_i, data_rsp_error_i}),

  .output_valid (rsp_buff_out_valid),
  .output_ready (act_req_buff_out_valid),
  .output_data  (rsp_buff_out_data),

  .empty        ()
);
assign data_rsp_ready_o =  resp_buff_ready && ~act_req_buff_empty;

/*************************************
* Reg File
*************************************/
byte_select_read bsr_inst (
  .data(rsp_buff_out_data.data),
  .byteaddr(act_req_buff_out_data.addr[1:0]),
  .data_out(byte_select_read_data)
);
assign rf_data_o = sign_extend(byte_select_read_data, act_req_buff_out_data.cmd);
assign rf_dest_o = act_req_buff_out_data.regdest;
assign rf_wb_o   = (rsp_buff_out_valid &&
                    act_req_buff_out_valid &&
                    ~is_write_cmd(act_req_buff_out_data.cmd) &&
                    ~rsp_buff_out_data.error);

/*************************************
* Bus Errors
*************************************/
assign exc_store_access_fault_o = rsp_buff_out_data.error && is_write_cmd(act_req_buff_out_data.cmd);
assign exc_load_access_fault_o  = rsp_buff_out_data.error && ~is_write_cmd(act_req_buff_out_data.cmd);
assign exception = exc_store_access_fault_o || exc_load_access_fault_o;
assign exc_addr_o = exception ? act_req_buff_out_data.addr : '0;


/*************************************
* Control
*************************************/
assign retire_request = rsp_buff_out_valid && act_req_buff_out_valid;
assign lsu_ready_o = (state == eLSU_RUN) && req_buff_inp_ready && ~exception;

/*************************************
* FSM
*************************************/
always_comb begin
  read_req  = (state == eLSU_RUN)   && lsu_valid_i    && lsu_ready_o  && ~is_write_cmd(lsu_cmd_i) && ~load_addr_misaligned;
  read_rsp  = (state == eLSU_READ)  && retire_request && ~is_write_cmd(act_req_buff_out_data.cmd);
  req_full  = (state == eLSU_RUN)   && ~req_buff_inp_ready;
  req_ready = (state == eLSU_STALL) && req_buff_inp_ready;
end
always_comb begin
  state_next = read_req  ? eLSU_READ  : state;
  state_next = read_rsp  ? eLSU_RUN   : state_next;
  state_next = req_full  ? eLSU_STALL : state_next;
  state_next = req_ready ? eLSU_RUN   : state_next;
end
always_ff @(posedge clk_i) begin
  if (~rstn_i)
    state <= eLSU_RUN;
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
    if (lsu_valid_i && lsu_ready_o) begin
      // There should be no request if  req buffers is full.
      bad_req: assert(req_buff_inp_ready);
      // Requests can only be issued when in running state (no stall).
      state_r: assert(state == eLSU_RUN);
    end
  end
`endif

endmodule

/* verilator lint_off DECLFILENAME */
module cmd_to_strobe(
  input lsu_ctrl_e cmd,
  input logic [1:0] addr,
  output logic [3:0] strobe
);
  logic [3:0] aligned_strobe;
  logic btye, half, word;
  logic valid;
  assign valid = (cmd != LSU_NO_CMD);
  assign btye = 1'b1;
  assign half = cmd[0];
  assign word = cmd[1];
  assign aligned_strobe = {word & valid,
                           word & valid,
                           (half | word) & valid,
                           (btye | half | word) & valid};
  assign strobe = (aligned_strobe << addr);
endmodule

/* verilator lint_off DECLFILENAME */
module lsu_addr_check (
  input  lsu_ctrl_e  lsu_cmd_i,
  input  logic       valid_i,
  input  logic [1:0] eff_addr_i,
  output logic       write_error_o,
  output logic       read_error_o
);
  logic half, word;
  logic error;
  assign half = lsu_cmd_i[0];
  assign word = lsu_cmd_i[1];
  always_comb begin
    error = 1'b0;
    if (lsu_cmd_i != LSU_NO_CMD) begin
      if (word)
        error = ~(eff_addr_i == 2'b00);
      if (half)
        error = ~(eff_addr_i == 2'b00 || eff_addr_i == 2'b10);
    end
  end
  assign write_error_o = error &&  is_write_cmd(lsu_cmd_i) && valid_i;
  assign read_error_o  = error && ~is_write_cmd(lsu_cmd_i) && valid_i;
endmodule

/* verilator lint_off DECLFILENAME */
module byte_select_read(
  input logic [XLEN-1:0] data,
  input logic [1:0] byteaddr,
  output logic [XLEN-1:0] data_out
);
  always_comb begin
    data_out = 0;
    unique case (byteaddr)
      2'b00: data_out = data;
      2'b01: data_out = {24'b0, data[15:8]};
      2'b10: data_out = {16'b0, data[31:16]};
      2'b11: data_out = {24'b0, data[31:24]};
    endcase
  end
endmodule

/* verilator lint_off DECLFILENAME */
module byte_select_write(
  input logic [XLEN-1:0] data,
  input lsu_ctrl_e cmd,
  input logic [1:0] byteaddr,
  output logic [XLEN-1:0] data_out
);
  always_comb begin
    data_out = 32'b0;
    unique case (cmd)
      LSU_STORE_BYTE: begin
        unique case (byteaddr)
          2'b00:  data_out = data;
          2'b01:  data_out = {16'b0, data[7:0], 8'b0};
          2'b10:  data_out = {8'b0,  data[7:0], 16'b0};
          2'b11:  data_out = {data[7:0], 24'b0};
        endcase
      end
      LSU_STORE_HALF_WORD: begin
        unique case (byteaddr)
          2'b00:   data_out = data;
          2'b10:   data_out = {data[15:0], 16'b0};
          default:;
        endcase
      end
      LSU_STORE_WORD: data_out = data;
      default: data_out = 32'b0;
    endcase
  end
endmodule
