////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    ripple_carry_adder_Nb                                      //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    An implemenation of a (combinatorial) ripple carry adder.  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


module ripple_carry_adder_Nb #(parameter N = 32) (
	input  ci,
	input  [N-1:0] a,
	input  [N-1:0] b,
	output [N-1:0] s,
	output co
);

wire [N:0] c;


assign c[0] = ci; // The first 1-bit full adders cary in is usually zero.

genvar i;
for (i = 0; i < N; i = i + 1) begin
	full_adder_1b FA_1b(a[i], b[i], c[i], s[i], c[i+1]);
end

assign co = c[N];

endmodule
