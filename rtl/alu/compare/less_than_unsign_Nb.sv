////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    less_than_unsign_Nb                                        //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The module checks if a is less than b (a < b).             //
//                 This is for unsigned binary numbers.                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module less_than_unsign_Nb #(parameter int N = 32) (
  input  logic [N-1:0] a,
  input  logic [N-1:0] b,
  output logic [N-1:0] r
);
  logic lt;
  assign lt = a < b;
  assign r = { {N-1{1'b0}}, lt};
endmodule
