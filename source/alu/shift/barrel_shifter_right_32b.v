////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    barrel_shifter_Nb                                          //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    A combinatorial circuit that performs shifting of 32-bit   //
//                 values. This is a logarithmic barrel shifter. 			  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module barrel_shifter_right_32b  (
    input  [32-1:0] inp,
    input  [5-1:0] cntrl,	 // The amount to shift by
	input		   right,	 // By default the shifter shifts left, this forces it to shift right.
	input		   arith, 	 // Should the shift be arithmetic? By default it is logical.
    output [32-1:0] r
);


endmodule


