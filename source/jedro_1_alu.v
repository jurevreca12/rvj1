////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_alu                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The arithmetic logic unit is defined here.                 //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


module jedro_1_regfile
#(
	parameter	DATA_WIDTH = 32,
	parameter	ADDR_WIDTH = $clog2(DATA_WIDTH)
)
(
	input 						clk_i,
	input						rstn_i,
	input 	[xx:xx]				func3,
	input 	[DATA_WIDTH-1:0]	opa_i,
	input   [DATA_WIDTH-1:0]	opb_i,
	output reg [DATA_WIDTH-1:0]	res_o
);




`ifdef COCOTB_SIM
initial begin
	$dumpfile("jedro_1_regfile.vcd");
	$dumpvars(0, jedro_1_regfile);
	#1;
end
`endif

endmodule

