////////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                             //
//                                                                                //
//                                                                                //
//                                                                                //
// Design Name:    skidbuffer                                                     //
// Project Name:   riscv-jedro-1                                                  //
// Language:       System Verilog                                                 //
//                                                                                //
// Description:    Implements a skidbuffer which separates two sides of a         //
//                 ready-valid handshake. In other words a FIFO with 2 elements.  //
//                 (based on https://fpgacpu.ca/fpga/Pipeline_Skid_Buffer.html)   //                                                                          //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////

module skidbuffer
#(
    parameter int WORD_WIDTH = 0
)
(
    input  logic                  clk,
    input  logic                  rstn,

    input  logic                  input_valid,
    output logic                  input_ready,
    input  logic [WORD_WIDTH-1:0] input_data,

    output logic                  output_valid,
    input  logic                  output_ready,
    output logic [WORD_WIDTH-1:0] output_data
);
    logic [WORD_WIDTH-1:0] selected_data;
    logic [WORD_WIDTH-1:0] input_buffer_out;
    logic input_buffer_ce, output_buffer_ce, use_buffered_data;
    logic load, flow, fill, flush, unload;
    logic insert, remove;

    typedef enum logic [1:0] {
        eEMPTY, // Output and buffer registers empty
        eBUSY,  // Output register holds data
        eFULL   // Both output and buffer registers full
    } sb_fsm_e;
    sb_fsm_e state, state_next;

    /*************************************
    * Data Path
    *************************************/
    register #(
        .WORD_WIDTH  (WORD_WIDTH),
        .RESET_VALUE (0)
    ) input_buffer (
        .clk  (clk),
        .rstn (rstn),
        .ce   (input_buffer_ce),
        .in   (input_data),
        .out  (input_buffer_out)
    );
    assign selected_data = use_buffered_data ? input_buffer_out : input_data;
    register #(
        .WORD_WIDTH  (WORD_WIDTH),
        .RESET_VALUE (0)
    ) output_buffer (
        .clk  (clk),
        .rstn (rstn),
        .ce   (output_buffer_ce),
        .in   (selected_data),
        .out  (output_data)
    );

    /*************************************
    * Control Logic
    *************************************/
    register #(
        .WORD_WIDTH  (1),
        .RESET_VALUE (1'b1)
    ) input_ready_reg (
        .clk  (clk),
        .rstn (rstn),
        .ce   (1'b1),
        .in   ((state_next != eFULL)),
        .out  (input_ready)
    );
    register #(
        .WORD_WIDTH  (1),
        .RESET_VALUE (1'b0)
    ) output_valid_reg
    (
        .clk  (clk),
        .rstn (rstn),
        .ce   (1'b1),
        .in   (state_next != eEMPTY),
        .out  (output_valid)
    );
    assign insert = input_valid  && input_ready;
    assign remove = output_valid && output_ready;
    always_comb begin
        load    = (state == eEMPTY) &&  insert && ~remove;
        flow    = (state == eBUSY)  &&  insert &&  remove;
        fill    = (state == eBUSY)  &&  insert && ~remove;
        unload  = (state == eBUSY)  && ~insert &&  remove;
        flush   = (state == eFULL)  && ~insert &&  remove;
    end

    assign input_buffer_ce   = fill;
    assign output_buffer_ce  = load || flow || flush;
    assign use_buffered_data = flush;

    always_comb begin
        state_next = load   ? eBUSY  : state;
        state_next = flow   ? eBUSY  : state_next;
        state_next = fill   ? eFULL  : state_next;
        state_next = flush  ? eBUSY  : state_next;
        state_next = unload ? eEMPTY : state_next;
    end
    always_ff @(posedge clk) begin
        if (~rstn)
            state <= eEMPTY;
        else
            state <= state_next;
    end
endmodule
