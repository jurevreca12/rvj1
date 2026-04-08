////////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                             //
//                                                                                //
//                                                                                //
//                                                                                //
// Design Name:    rvj1_ifu                                                       //
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
import rvj1_defines::*;


module rvj1_ifu(
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

  input logic             jmp_addr_valid_i, // change PC to jmp_addr_i
  input logic [XLEN-3:0]  jmp_addr_i        // The jump address
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
        ifu_strobe_e      strobe;
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

    logic response_valid;
    logic response_ready;

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

    ifu_strobe_e      next_strobe;
    ifu_strobe_e      dec_strobe;
    logic [IDLEN-1:0] next_id;
    logic [IDLEN-1:0] next_exp_id;
    logic [IDLEN-1:0] dec_id;
    logic             dec_fire;
    logic             consume_id;
    logic             consume_rsp;


    /*************************************
    * Instruction Memory Interface
    *************************************/
    assign instr_req_fire = instr_req_ready_i && instr_req_valid_o;
    assign instr_req_data_o    = 32'b0;
    assign instr_req_write_o   = 1'b0;  // read-only interface
    assign instr_req_strobe_o  = 4'b1111;
    assign instr_req_addr_next = (jmp_addr_valid_i) ? {jmp_addr_i, 2'b00} : (instr_req_addr_o + 4);
    register #(
        .WORD_WIDTH(XLEN),
        .RESET_VALUE('0)
    ) instr_req_addr_reg (
        .clk  (clk_i),
        .rstn (rstn_i),
        .ce   (jmp_addr_valid_i || instr_req_fire),
        .in   (instr_req_addr_next),
        .out  (instr_req_addr_o)
    );
    counter #(.WORD_WIDTH(IDLEN)) instr_id_counter (
        .clk  (clk_i),
        .rstn (rstn_i),
        .ce   (instr_req_fire),
        .count(instr_req_id_o)
    );

    assign instr_req_valid_o = (act_req_buff_inp_ready &&
                                act_id_buff_inp_ready &&
                                (state == eIFU_BUSY));

    assign instr_rsp_fire = instr_rsp_valid_i && instr_rsp_ready_o;
    assign instr_rsp_ready_o = (rsp_buff_inp_ready &&
                                (state == eIFU_BUSY));

    /*************************************
    * Active request buffering
    *************************************/
    skidbuffer #(
        .WORD_WIDTH($bits(ifu_act_req_t))
    ) act_req_buff (
        .clk  (clk_i),
        .rstn (rstn_i),

        .input_valid  (instr_req_fire),
        .input_ready  (act_req_buff_inp_ready),
        .input_data   ({eSTROBE_FULL, instr_req_id_o}),

        .output_valid (act_req_buff_out_valid),
        .output_ready (instr_rsp_fire),
        .output_data  ({next_strobe, next_id}),

        // verilator lint_off PINCONNECTEMPTY
        .empty        ()
        // verilator lint_on PINCONNECTEMPTY
    );
    skidbuffer #(
        .WORD_WIDTH(IDLEN)
    ) next_id_buff (
        .clk  (clk_i),
        .rstn (rstn_i && ~jmp_addr_valid_i),

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
    skidbuffer #(
        .WORD_WIDTH ($bits(ifu_rsp_t))
    ) rsp_buff (
    .clk  (clk_i),
    .rstn (rstn_i),

    .input_valid  (instr_rsp_valid_i),
    .input_ready  (rsp_buff_inp_ready),
    .input_data   ({next_strobe, instr_rsp_data_i, instr_rsp_error_i, instr_rsp_id_i}),

    .output_valid (rsp_buff_out_valid),
    .output_ready (consume_rsp),
    .output_data  ({dec_strobe, dec_instr_o, dec_error_o, dec_id}),

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
    * Decoder Interface
    *************************************/
    assign consume_rsp = (rsp_buff_out_valid &&
                          act_id_buff_out_valid &&
                          (state == eIFU_BUSY) &&
                          dec_ready_i);
    assign id_match = (dec_id == next_exp_id);
    assign consume_id = (rsp_buff_out_valid &&
                         act_id_buff_out_valid &&
                         (state == eIFU_BUSY) &&
                         dec_ready_i &&
                         id_match);
    assign dec_valid_o = (rsp_buff_out_valid &&
                          act_id_buff_out_valid &&
                          (state == eIFU_BUSY) &&
                          id_match);
    assign dec_fire = dec_ready_i && dec_valid_o;

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
        .WORD_WIDTH($bits(ifu_fsm_e)),
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
