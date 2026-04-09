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
    parameter type DTYPE = logic,
    parameter DTYPE RESET_VALUE = 0
)
(
    input  logic clk,
    input  logic rstn,
    input  logic ce,   // clock-enable
    input  DTYPE in,
    output DTYPE out
);

    always_ff @(posedge clk) begin
        if (~rstn)
            out <= RESET_VALUE;
        else if (ce)
            out <= in;
    end
endmodule