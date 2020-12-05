////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    full_adder_1b.v                                            //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    A 1 bit full adder circuit.                                //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////



module full_adder_1b(
	input a,
	input b,
	input ci,
	output s,
	output co
	);

	wire sum;

	assign sum = a ^ b;
	assign s   = sum ^ ci;
	assign co  = (ci & sum) | (a & b);

endmodule
