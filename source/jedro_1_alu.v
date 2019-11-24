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

	input [`ALU_OP_WIDTH-1:0]	alu_op_sel_i,

	input 	[`DATA_WIDTH-1:0]		opa_i,
	input   [`DATA_WIDTH-1:0]		opb_i,
	output reg [`DATA_WIDTH-1:0]	res_o
);


wire [`DATA_WIDTH-1:0] adder_res;

// Ripple-carry adder
ripple_carry_adder_Nb #(`DATA_WIDTH) ripple_carry_adder_32 (
	.ci (1'b0),
	.a  (opa_i),
	.b  (opb_i),
	.inv_b (alu_op_sel_i[3]),
	.s  (adder_res),
	.co ()
);



// Result muxing
always@(*)
begin
	case (alu_op_sel_i)
		`ALU_OP_ADD: begin
			res_o <= adder_res; 
		end

		`ALU_OP_SUB: begin
			res_o <= adder_res;
		end

		`ALU_OP_SLL: begin
			res_o <= 
		end

		`ALU_OP_SLT: begin
			res_o <=
		end

		`ALU_OP_SLTU: begin
			res_o <= 
		end

		`ALU_OP_XOR: begin
			res_o <= 
		end

		`ALU_OP_SRL: begin
			res_o <=
		end

		`ALU_OP_SRA: begin
			res_O <=
		end

		`ALU_OP_OR: begin
			res_o <=
		end

		`ALU_OP_ANDI: begin
			res_o <= 
		end
		default: begin
			res_o <= 32'b0;
		end
	endcase
end


`ifdef COCOTB_SIM
initial begin
	$dumpfile("jedro_1_alu.vcd");
	$dumpvars(0, jedro_1_alu);
	#1;
end
`endif

endmodule

