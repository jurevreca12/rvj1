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

  input  logic [XLEN-1:0] instr_rsp_data_i,
  input  logic            instr_rsp_error_i,
  input  logic            instr_rsp_valid_i,
  output logic            instr_rsp_ready_o,

  // Interface to the decoder
  output logic [XLEN-1:0] dec_instr_o,  // The current instruction (to be decoded)
  output logic            dec_valid_o,
  input  logic            dec_ready_i,  // Decoder ready to accept new instruction (stall)

  input logic             jmp_addr_valid_i, // change PC to jmp_addr_i
  input logic [XLEN-1:0]  jmp_addr_i,       // The jump address

  output logic            instr_fetch_err_o, // Signal isntr fetch exception
  output logic [XLEN-1:0] instr_fault_addr_o // the address that caused the misaligned exception
);
    logic [XLEN-1:0] input_buffer;
    logic [XLEN-1:0] output_buffer;
    logic [XLEN-1:0] selected_data;
    logic input_buffer_clock_enable, output_buffer_clock_enable, use_buffered_data;

    logic boot, load, flow, fill, flush, unload, jmpi, jmpn;
    typedef enum logic [2:0] {
        eIFU_WAIT,   // no address, wait for jmp (controller jumps to boot addr at boot)
        eIFU_EMPTY,  // Output and buffer registers empty
        eIFU_BUSY,   // Output register holds data
        eIFU_FULL,   // Both output and buffer registers full,
        eIFU_JMP     // load address
    } ifu_fsm_e;
    ifu_fsm_e state, state_next;

    logic instr_rsp_fire, instr_req_fire, dec_fire;
    assign instr_rsp_fire = instr_rsp_ready_o && instr_rsp_valid_i;
    assign instr_req_fire = instr_req_ready_i && instr_req_valid_o;
    assign dec_fire = dec_ready_i && dec_valid_o;

    /*************************************
    * Skid Buffer the incoming data
    *************************************/
    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            input_buffer <= 0;
        else if(input_buffer_clock_enable)
            input_buffer <= instr_rsp_data_i;
    end

    assign selected_data = use_buffered_data ? input_buffer : instr_rsp_data_i;
    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            output_buffer <= 0;
        else if(output_buffer_clock_enable)
            output_buffer <= selected_data;
    end

    /*************************************
    * Instruction Memory Interface
    *************************************/
    assign instr_req_data_o   = 32'b0;
    assign instr_req_write_o  = 1'b0;  // read-only interface
    assign instr_req_strobe_o = 4'b1111;
    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            instr_req_addr_o <= 32'h0000_0000;
        else begin
            if (jmp_addr_valid_i)
                instr_req_addr_o <= jmp_addr_i;
            else if (instr_req_fire)
                instr_req_addr_o <= instr_req_addr_o + 4;
        end
    end
    always_ff @(posedge clk_i) begin
        if (~rstn_i) begin
            instr_req_valid_o <= 1'b0;
            instr_rsp_ready_o <= 1'b0;
        end
        else begin
            instr_req_valid_o <= (state_next != eIFU_FULL) && (state_next != eIFU_WAIT);
            instr_rsp_ready_o <= (state_next != eIFU_FULL) && (state_next != eIFU_WAIT);
        end
    end

    /*************************************
    * Decoder Interface
    *************************************/
    assign dec_instr_o = output_buffer;
    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            dec_valid_o <= 1'b0;
        else
            dec_valid_o <= ~((state_next == eIFU_EMPTY) ||
                             (state_next == eIFU_JMP)   ||
                             (state_next == eIFU_WAIT));
    end

    /*************************************
    * Finite State Machine (FSM)
    *************************************/
    always_comb begin
        boot   = (state == eIFU_WAIT)  &&  jmp_addr_valid_i;
        load   = (state == eIFU_EMPTY) &&  instr_rsp_fire;
        flow   = (state == eIFU_BUSY)  &&  instr_rsp_fire  &&  dec_fire;
        fill   = (state == eIFU_BUSY)  &&  instr_rsp_fire  && ~dec_fire;
        unload = (state == eIFU_BUSY)  && ~instr_rsp_fire  &&  dec_fire;
        flush  = (state == eIFU_FULL)  && ~instr_rsp_fire  &&  dec_fire;
        jmpi   = (state != eIFU_WAIT)  &&  jmp_addr_valid_i;
        jmpn   = (state == eIFU_JMP)   &&  instr_req_fire;
    end

    always_comb begin
        output_buffer_clock_enable = load || flow || flush;
        input_buffer_clock_enable  = fill                 ;
        use_buffered_data          = flush                ;
    end

    always_comb begin
        state_next = boot   ? eIFU_EMPTY : state;
        state_next = load   ? eIFU_BUSY  : state_next;
        state_next = flow   ? eIFU_BUSY  : state_next;
        state_next = fill   ? eIFU_FULL  : state_next;
        state_next = flush  ? eIFU_BUSY  : state_next;
        state_next = unload ? eIFU_EMPTY : state_next;
        state_next = jmpi   ? eIFU_JMP   : state_next;
        state_next = jmpn   ? eIFU_EMPTY  : state_next;
    end
    always_ff @(posedge clk_i) begin
        if (~rstn_i)
            state <= eIFU_WAIT;
        else
            state <= state_next;
    end

endmodule
