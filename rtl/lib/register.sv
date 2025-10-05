////////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                             //
//                                                                                //
//                                                                                //
//                                                                                //
// Design Name:    register                                                       //
// Project Name:   riscv-jedro-1                                                  //
// Language:       System Verilog                                                 //
//                                                                                //
// Description:    Implements a simple register.                                  //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////
module register
#(
    parameter int WORD_WIDTH = 0,
    parameter logic [WORD_WIDTH-1:0] RESET_VALUE = 0
)
(
    input  logic                  clk,
    input  logic                  rstn,
    input  logic                  ce,   // clock-enable
    input  logic [WORD_WIDTH-1:0] in,
    output logic [WORD_WIDTH-1:0] out
);

    always_ff @(posedge clk) begin
        if (~rstn)
            out <= RESET_VALUE;
        else if (ce)
            out <= in;
    end
endmodule

module pipeline_register
#(
    parameter int WORD_WIDTH = 0,
    parameter logic [WORD_WIDTH-1:0] RESET_VALUE = 0
)
(
    input  logic                  clk,
    input  logic                  ce,   // clock-enable
    input  logic [WORD_WIDTH-1:0] in,
    output logic [WORD_WIDTH-1:0] out
);

    always_ff @(posedge clk) begin
        if (ce)
            out <= in;
        else if (~ce)
            out <= RESET_VALUE;
    end
endmodule

