////////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                             //
//                 Tadej Paris -                                                  //
//                                                                                //
//                                                                                //
// Design Name:    rvj1_ifu_rvc                                                   //
// Project Name:   riscv-jedro-1                                                  //
// Language:       System Verilog                                                 //
//                                                                                //
// Description:    The instruction fetch unit.                                    //
//                                                                                //
//                  +----------------------------------+                          //
//                  |                                  |                          //
//                  |                +-------+         |                          //
//    instr_req_if  |                | next  |         | jmp_addr_if              //
//  <----------------<---------------| insn  |<----------------------             //
//                  |         |      | logic |    |    |                          //
//                  |         |      +-------+    |    |                          //
//                  |         |                   |    |                          //
//                  |         |               rst |    |                          //
//                  |         |     +--------+ <--|    |                          //
//                  |         |     | act    |         |                          //
//                  |         |---->| id     |-----    |                          //
//                  |         |     | buff   |    |    |                          //
//                  |         |     +--------+    |    |                          //
//                  |         v                   |    |                          //
//                  |     +-------+               |    |                          //
//                  |     | act   |               |    |                          //
//                  |     | req   |--------+      |    |                          //
//                  |     | buff  |        |      |    |                          //
//                  |     +-------+        |      v    |   dec_if                 //
//                  |                      +----------->------------->            //
//   instr_rsp_if   |     +-------+        |           |                          //
//                  |     |rsp    |        |           |                          //
// ----------------->---->|buff   ---------+           |                          //
//                  |     |       |                    |                          //
//                  |     +-------+                    |                          //
//                  |                                  |                          //
//                  +----------------------------------+                          //
////////////////////////////////////////////////////////////////////////////////////

/* verilator lint_off IMPORTSTAR */

module rvj1_ifu_rvc import rvj1_pkg::*;(
  input logic clk_i,
  input logic rstn_i,

  output logic [XLEN-1:0]   instr_req_addr_o,
  output logic [XLEN-1:0]   instr_req_data_o,
  output logic [NBYTES-1:0] instr_req_strobe_o,
  output logic              instr_req_write_o,
  output logic              instr_req_valid_o,
  output logic [IDLEN-1:0]  instr_req_id_o,
  input  logic              instr_req_ready_i,

  input  logic [XLEN-1:0]  instr_rsp_data_i,
  input  logic             instr_rsp_error_i,
  input  logic             instr_rsp_valid_i,
  input  logic [IDLEN-1:0] instr_rsp_id_i,
  output logic             instr_rsp_ready_o,

  // Interface to the decoder
  output logic [XLEN-1:0] dec_instr_o,  // The current instruction (to be decoded)
  output logic            dec_valid_o,
  input  logic            dec_ready_i,  // Decoder ready to accept new instruction (stall)
  output logic            dec_error_o,  // signal a instruction fetch error on next insn
  output logic            dec_compr_o,  // was compressed?
  `ifdef RVFI
  output logic [XLEN-1:0] dec_org_instr_o, // the original instruction (before decompression)
  `endif

  input logic             jmp_addr_valid_i, // change PC to jmp_addr_i
  input logic [XLEN-2:0]  jmp_addr_i        // The jump address
);
    typedef enum logic {
        eSTROBE_FULL  = 1'b0,  // strobe == 1111
        eSTROBE_HALF  = 1'b1   // strobe == 1100 // when jumping unaligned
    } ifu_strobe_e;

    typedef struct packed {
        logic [IDLEN-1:0]  id;
        ifu_strobe_e       strobe;
    } ifu_act_req_t;

    typedef struct packed {
        logic [IDLEN-1:0] id;
        logic [XLEN-1:0]  data;
        logic             error;
    } ifu_rsp_t;

    typedef enum logic [1:0] {
        eIFU_RST,   // no address, wait for jmp (controller jumps to boot addr at boot)
        eIFU_JMP,   // any jump after the first jump
        eIFU_BUSY   // normal operation
    } ifu_fsm_e;

    ifu_fsm_e state, state_next;

    logic [XLEN-1:0] instr_req_addr_next;
    logic            instr_req_fire;
    logic            instr_rsp_fire;

    logic boot;
    logic jmpi;
    logic jmpe; // error condition

    logic act_req_buff_inp_ready;
    logic act_req_buff_out_valid;
    logic act_id_buff_inp_ready;
    logic act_id_buff_out_valid;
    logic rsp_buff_inp_ready;
    logic rsp_buff_out_valid;

    logic id_match;

    ifu_strobe_e      rsp_strobe;
    logic [IDLEN-1:0] next_id;
    logic [IDLEN-1:0] next_exp_id;
    logic [IDLEN-1:0] rsp_id;
    logic             consume_id;
    logic             consume_rsp;
    logic             buffers_valid;

    ifu_strobe_e instr_req_strobe_next, instr_req_strobe_q;

    logic fifo_write_ready;
    logic [XLEN-1:0] fifo_write_data;
    logic [XLEN-1:0] fifo_read_data;

    /*************************************
    * Instruction Memory Interface
    *************************************/
    assign instr_req_fire        = instr_req_ready_i && instr_req_valid_o;
    assign instr_req_data_o      = 32'b0; // read-only interface
    assign instr_req_write_o     = 1'b0;  // read-only interface
    assign instr_req_addr_next   = (jmp_addr_valid_i) ? {jmp_addr_i[XLEN-2:1], 2'b00} : (instr_req_addr_o + 4); // word-align jmp address
    assign instr_req_strobe_next = (jmp_addr_valid_i && jmp_addr_i[0]) ? eSTROBE_HALF : eSTROBE_FULL;
    assign instr_req_strobe_o    = (instr_req_strobe_q == eSTROBE_HALF) ? 4'b1100 : 4'b1111;
    register #(
        .DTYPE(logic [XLEN-1:0]),
        .RESET_VALUE('0)
    ) instr_req_addr_reg (
        .clk  (clk_i),
        .rstn (rstn_i),
        .ce   (jmp_addr_valid_i || instr_req_fire),
        .in   (instr_req_addr_next),
        .out  (instr_req_addr_o)
    );

    register #(
        .DTYPE(ifu_strobe_e),
        .RESET_VALUE(eSTROBE_FULL)
    ) instr_req_strobe_reg (
        .clk  (clk_i),
        .rstn (rstn_i),
        .ce   (jmp_addr_valid_i || instr_req_fire),
        .in   (instr_req_strobe_next),
        .out  (instr_req_strobe_q)
    );
    cntr #(.WORD_WIDTH(IDLEN)) instr_id_counter (
        .clk  (clk_i),
        .rstn (rstn_i),
        .ce   (instr_req_fire),
        .count(instr_req_id_o)
    );

    assign instr_req_valid_o = (act_req_buff_inp_ready &&
                                act_id_buff_inp_ready &&
                                (state == eIFU_BUSY));
    assign instr_rsp_ready_o = (rsp_buff_inp_ready &&
                                act_req_buff_out_valid &&
                                (state == eIFU_BUSY));
    assign instr_rsp_fire = instr_rsp_valid_i && instr_rsp_ready_o;


    /*************************************
    * Active request buffering
    *************************************/
    skidbuffer #(
        .DTYPE(ifu_act_req_t)
    ) act_req_buff (
        .clk  (clk_i),
        .rstn (rstn_i),

        .input_valid  (instr_req_fire),
        .input_ready  (act_req_buff_inp_ready),
        .input_data   ({instr_req_strobe_q, instr_req_id_o}),

        .output_valid (act_req_buff_out_valid),
        .output_ready (consume_rsp),
        .output_data  ({rsp_strobe, next_id}),

        // verilator lint_off PINCONNECTEMPTY
        .empty        (),
        .clear        ()
        // verilator lint_on PINCONNECTEMPTY
    );
    skidbuffer #(
        .DTYPE(logic [IDLEN-1:0])
    ) next_id_buff (
        .clk  (clk_i),
        .rstn (rstn_i),
        .clear(jmp_addr_valid_i),

        .input_valid  (instr_req_fire),
        .input_ready  (act_id_buff_inp_ready),
        .input_data   (instr_req_id_o),

        .output_valid (act_id_buff_out_valid),
        .output_ready (consume_id),
        .output_data  (next_exp_id),

        // verilator lint_off PINCONNECTEMPTY
        .empty        ()
        // verilator lint_on PINCONNECTEMPTY
    );

    `ifdef ASSERTIONS
        always_ff @(posedge clk_i) begin
            if (instr_req_fire) begin
                req_dropped: assert(act_req_buff_inp_ready);
                id_dropped: assert(act_id_buff_inp_ready);
            end
            if (instr_rsp_fire) begin
                rsp_dropped: assert(act_req_buff_out_valid);
                rsp_ready: assert(rsp_buff_inp_ready);
            end
        end
    `endif

    /*************************************
    * Response buffering
    *************************************/
    logic rsp_err;
    logic [XLEN-1:0] rsp_data;
    skidbuffer #(
        .DTYPE(ifu_rsp_t)
    ) rsp_buff (
    .clk  (clk_i),
    .rstn (rstn_i),
    .clear(1'b0),

    .input_valid  (instr_rsp_fire),
    .input_ready  (rsp_buff_inp_ready),
    .input_data   ({instr_rsp_data_i, instr_rsp_error_i, instr_rsp_id_i}),

    .output_valid (rsp_buff_out_valid),
    .output_ready (consume_rsp),
    .output_data  ({rsp_data, rsp_err, rsp_id}),

    // verilator lint_off PINCONNECTEMPTY
    .empty        ()
    // verilator lint_on PINCONNECTEMPTY
    );

    `ifdef ASSERTIONS
        always_ff @(posedge clk_i) begin
            if (instr_rsp_valid_i && rsp_buff_inp_ready) begin
                inorder_ids: assert(instr_rsp_id_i == next_id);
            end
            if (consume_id) begin
                valid_consume: assert(rsp_buff_out_valid && act_id_buff_out_valid);
            end
        end
    `endif

    /*************************************
    * FIFO
    *************************************/
    assign fifo_write_data = (rsp_strobe == eSTROBE_HALF) ? {16'b0, rsp_data[31:16]} : rsp_data;
    fifo_comp fifo (
    .clk_i  (clk_i),
    .rstn_i (rstn_i),
    .flush_i(jmp_addr_valid_i),

    .write_ready_o  (fifo_write_ready),
    .write_valid_i  (consume_id),
    .write_data_i   (fifo_write_data),

    .read_ready_i   (dec_ready_i),
    .read_valid_o   (dec_valid_o),
    .read_data_o    (fifo_read_data),

    .input_err_i    (rsp_err),
    .output_err_o   (dec_error_o),

    .half_strobe_i  (rsp_strobe == eSTROBE_HALF)
    );
 
    rvc_decomp decomp (
        .instr_i (fifo_read_data),
        .instr_o (dec_instr_o),
        .compr_o (dec_compr_o)

    );

    /*************************************
    * FIFO and Decoder Interface
    *************************************/
    assign buffers_valid = rsp_buff_out_valid && act_req_buff_out_valid && (state == eIFU_BUSY); 
    assign consume_rsp   = buffers_valid  && fifo_write_ready;
    assign id_match      = (rsp_id == next_exp_id);
    assign consume_id    = consume_rsp && id_match && act_id_buff_out_valid;

    `ifdef RVFI
    assign dec_org_instr_o = fifo_read_data;
    `endif

    /*************************************
    * Finite State Machine (FSM)
    *************************************/
    always_comb begin
        boot    = (state == eIFU_RST)  && jmp_addr_valid_i;
        jmpi    = (state == eIFU_BUSY) && jmp_addr_valid_i;
        jmpe    = (state == eIFU_JMP)  && jmp_addr_valid_i;
    end
    always_comb begin
        state_next = boot                 ? eIFU_JMP  : state;
        state_next = jmpi                 ? eIFU_JMP  : state_next;
        state_next = (state == eIFU_JMP)  ? eIFU_BUSY : state_next;
    end
    register #(
        .DTYPE(ifu_fsm_e),
        .RESET_VALUE(eIFU_RST)
    ) state_reg (
        .clk  (clk_i),
        .rstn (rstn_i),
        .ce   (1'b1),
        .in   (state_next),
        .out  (state)
    );
    `ifdef ASSERTIONS
    always_ff @(posedge clk_i)
        assert(~jmpe);
    `endif

endmodule
