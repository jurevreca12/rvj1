////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    less_than_sign_Nb                                          //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The module checks if a is less than b (a < b).             //
//                 This is for signed (2's complement numbers)                //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module less_than_sign_Nb #(parameter N = 32) (
	input  [N-1:0] a,
	input  [N-1:0] b,
	output         r
);

wire [N-2:0] res_abs;


// This comparator module compares all but the signed bit.
less_than_unsign_Nb ( a[N-2:0], b[N-2:0], res_abs);

always@ (*)
begin
    if ( a[N-1] == 0 && b[N-1] == 1 )   // +a and -b
        r = 0;
    else if ( a[N-1] == 1 && b[N-1] == 0) // -a and +b
        r = 1;
    else  // +a and +b OR -a and -b
        r = res_abs; 
end

endmodule