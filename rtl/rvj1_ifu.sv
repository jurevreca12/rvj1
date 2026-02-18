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
  input  logic              instr_req_ready_i,

  output logic              instr_ctrl_cancel_o,

  input  logic [XLEN-1:0] instr_rsp_data_i,
  input  logic            instr_rsp_error_i,
  input  logic            instr_rsp_valid_i,
  output logic            instr_rsp_ready_o,

  // Interface to the decoder
  output logic [XLEN-1:0] dec_instr_o,  // The current instruction (to be decoded)
  output logic            dec_valid_o,
  input  logic            dec_ready_i,  // Decoder ready to accept new instruction (stall)

  input logic             jmp_addr_valid_i, // change PC to jmp_addr_i
  input logic [XLEN-3:0]  jmp_addr_i,       // The jump address

  output logic            error_valid_o, // Signal isntr fetch exception
  output logic [XLEN-1:0] error_addr_o   // the address that caused the exception
);
    typedef enum logic [1:0] {
        eIFU_RST,   // no address, wait for jmp (controller jumps to boot addr at boot)
        eIFU_JMP,   // any jump after the first jump
        eIFU_JMP2,  // wait state
        eIFU_BUSY   // normal operation
    } ifu_fsm_e;

    typedef struct packed {
        logic [XLEN-1:0] data;
        logic            error;
    } ifu_rsp_t;

    ifu_fsm_e state, state_next;

    logic [XLEN-1:0] instr_req_addr_next;
    logic            act_req_buff_inp_ready;
    logic            instr_rsp_fire;
    logic            instr_req_fire;
    logic            dec_fire;

    logic            bus_error;
    logic [XLEN-3:0] bus_fault_addr;

    logic boot;
    logic jmpi;
    logic jmpe; // error condition

    logic response_valid;
    logic response_ready;

    assign instr_rsp_fire = instr_rsp_ready_o && instr_rsp_valid_i;
    assign instr_req_fire = instr_req_ready_i && instr_req_valid_o;
    assign dec_fire = dec_ready_i && dec_valid_o;

    /*************************************
    * Instruction Memory Interface
    *************************************/
    assign instr_req_data_o    = 32'b0;
    assign instr_req_write_o   = 1'b0;  // read-only interface
    assign instr_req_strobe_o  = 4'b1111;
    assign instr_req_addr_next = (jmp_addr_valid_i) ? {jmp_addr_i, 2'b00} : (instr_req_addr_o + 4);
    register #(
        .WORD_WIDTH(XLEN),
        .RESET_VALUE(32'h0000_0000)
    ) instr_req_addr_reg (
        .clk  (clk_i),
        .rstn (rstn_i),
        .ce   (jmp_addr_valid_i || instr_req_fire),
        .in   (instr_req_addr_next),
        .out  (instr_req_addr_o)
    );
    assign instr_req_valid_o = (state == eIFU_BUSY) && act_req_buff_inp_ready;

    // Cancels invalidated outstanding request (e.g., on a jump)
    register cancel_reg (
        .clk (clk_i),
        .rstn(rstn_i),
        .ce  (1'b1),
        .in  (jmp_addr_valid_i),
        .out (instr_ctrl_cancel_o)
    );

    /*************************************
    * Response buffering
    *************************************/
    // Buffers active addreses (to report fault if necessary)
    skidbuffer #(
        .WORD_WIDTH (XLEN-2)
    ) active_request_buffer (
    .clk  (clk_i),
    .rstn (rstn_i && ~(state == eIFU_JMP)),

    .input_valid  (instr_req_fire),
    .input_ready  (act_req_buff_inp_ready),
    .input_data   (instr_req_addr_o[31:2]),

    .output_valid (),
    .output_ready (dec_ready_i),
    .output_data  (bus_fault_addr),

    .empty        ()
    );
    skidbuffer #(
        .WORD_WIDTH ($bits(ifu_rsp_t))
    ) response_buffer (
    .clk  (clk_i),
    .rstn (rstn_i && ~(state == eIFU_JMP)),

    .input_valid  (instr_rsp_valid_i),
    .input_ready  (instr_rsp_ready_o),
    .input_data   ({instr_rsp_data_i, instr_rsp_error_i}),

    .output_valid (response_valid),
    .output_ready (response_ready),
    .output_data  ({dec_instr_o, bus_error}),

    .empty        ()
    );
    assign response_ready = dec_ready_i;
    assign error_valid_o  = bus_error && response_valid && response_ready;
    assign error_addr_o = {bus_fault_addr, 2'b00};
    always_comb begin
        if (state == eIFU_BUSY)
            dec_valid_o = bus_error ? 1'b0 : response_valid;
        else
            dec_valid_o = 1'b0;
    end
    `ifdef ASSERTIONS
    always_ff @(posedge clk_i) begin
        if (instr_req_fire)
            assert(act_req_buff_inp_ready);
    end
    `endif

    /*************************************
    * Finite State Machine (FSM)
    *************************************/
    always_comb begin
        boot = (state == eIFU_RST)  && jmp_addr_valid_i;
        jmpi = (state == eIFU_BUSY) && jmp_addr_valid_i;
        jmpe = ((state == eIFU_JMP) || (state == eIFU_JMP2))  && jmp_addr_valid_i;
    end
    always_comb begin
        state_next = boot                 ? eIFU_JMP  : state;
        state_next = jmpi                 ? eIFU_JMP  : state_next;
        state_next = (state == eIFU_JMP)  ? eIFU_JMP2 : state_next;
        state_next = (state == eIFU_JMP2) ? eIFU_BUSY : state_next;
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
