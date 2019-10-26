////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
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

`include "jedro_1_defines.v"

module jedro_1_alu
(
	input 						clk_i,
	input						rstn_i,

	input [ALU_OP_WIDTH-1:0]	alu_op_sel_i,

	input						op_ready_i,
	input 	[DATA_WIDTH-1:0]	opa_i,
	input   [DATA_WIDTH-1:0]	opb_i,
	output reg [DATA_WIDTH-1:0]	res_o,
	output reg 					res_ready_o
);


// Ripple-carry adder
ripple_carry_adder_Nb #(DATA_WIDTH) ripple_carry_adder_32 (
	.ci (1'b0),
	.a  (opa_i),
	.b  (opb_i),
	.s  (res_o),
	.co ()
);


// Handle ready single
always@(posedge clk_i)
begin
	if (rstn_i == 1'b0) begin
		res_ready_o <= 1'b0;
	end
	else begin
		if (op_ready_i == 1'b1) begin
			res_ready_o <= 1'b1;
		end
		else begin
			res_ready_o <= 1'b0;
		end
	end
end





`ifdef COCOTB_SIM
initial begin
	$dumpfile("jedro_1_alu.vcd");
	$dumpvars(0, jedro_1_alu);
	#1;
end
`endif

endmodule

