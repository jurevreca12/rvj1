////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    sign_extender                                              //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    Sign extension circuit for 2s complement numbers.          //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module sign_extender #(parameter N=32, parameter M = 12) (
	input  [M-1:0] in_i,
	output [N-1:0] out_o
);

	assign out_o = { {(N-M){in_i[M-1]}}, in_i[M-1:0]};

endmodule
