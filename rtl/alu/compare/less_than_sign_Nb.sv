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

module less_than_sign_Nb #(parameter int N = 32) (
  input  logic [N-1:0] a,
  input  logic [N-1:0] b,
  output logic [N-1:0] r
);
logic [N-2:0]  res_abs;

// This comparator module compares all but the signed bit.
less_than_unsign_Nb #(.N(31)) ltu_31b (.a(a[N-2:0]), .b(b[N-2:0]), .r(res_abs));
always_comb
begin
  unique case ({a[N-1], b[N-1]})
    2'b10 :   r = 32'h0000_0001;
    2'b01 :   r = 32'h0000_0000;
    default : r = {1'b0, res_abs};
endcase
end

endmodule
