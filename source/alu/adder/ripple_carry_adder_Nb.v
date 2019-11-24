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
	input  inv_b, 		// Should input b be inverted?
	output [N-1:0] s,
	output co
);

wire [N:0] c;
wire [N-1:0] b_mod;

reg ci_mod; // Used to implement substraction (

assign c[0] = ci_mod; // The first 1-bit full adders cary in is usually zero.


// Inverting for subtraction
always@(*)
begin
	if (inv_b == 1'b1) begin
		b_mod <= ~b;
		ci_mod <= ~ci;
	end
	else begin
		b_mod <= b;
		ci_mod <= ci;
	end
end

genvar i;
for (i = 0; i < N; i = i + 1) begin
	full_adder_1b FA_1b(a[i], b_mod[i], c[i], s[i], c[i+1]);
end

assign co = c[N];

endmodule
