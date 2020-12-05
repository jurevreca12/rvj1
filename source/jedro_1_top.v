////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_top                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The top file of the jedro_1 riscv core.	                  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
  
`include "jedro_1_defines.v"


module jedro_1_top
(
	input clk_i,
	input rstn_i,
	input en_i,

 // Instruction interface
	output reg			instr_req_o,
	input				instr_gnt_i,
	input				instr_rvalid_i,
	output reg [31:0]	instr_addr_o,
	input [31:0]		instr_rdata_i,	

 // Data interface
	output reg 			data_req_o,
	input 	   			data_gnt_i,
	input	   			data_rvalid_i,
	output reg  		data_we_o,
	output reg [3:0]	data_be_o,
	output reg [31:0]	data_addr_o,
	output reg [31:0]	data_wdata_o,
	input  [31:0]		data_rdata_i,
	input				data_err_i

 // IRQ interface


 // Debug interface

);

reg  [31:0] pc_r; // program counter
reg  [31:0] cinstr_r; // current instruction
wire illegal_instr;
reg  illegal_instr_r = 0;
wire [`ALU_OP_WIDTH-1:0] alu_op_sel;
wire alu_reg_op_a;
wire alu_reg_op_b;
wire [`REG_ADDR_WIDTH-1:0] alu_reg_op_a_addr;
wire [`REG_ADDR_WIDTH-1:0] alu_reg_op_b_addr;
wire [`DATA_WIDTH-1:0] reg_op_a_data;
wire [`DATA_WIDTH-1:0] reg_op_b_data;
wire [`DATA_WIDTH-1:0] alu_result_data;

// Reset program counter to zero.
// Because an instruction can be executed every cycle we can decode a new
// instruction each cycle as long as the core is enabled.
always @(posedge clk_i) begin
	if (rstn_i == 1'b0 || illegal_instr_r == 1'b1)	begin
		pc_r <= 32'b0;
	end
	else if (illegal_instr_r == 1'b1) begin
		illegal_instr_r <= 1'b1;
	end
	else begin
		pc_r <= pc_r + 4;
	end
end


jedro_1_instr	instr_inst 	 (.clk_i			   (clk_i),
							  .rstn_i			   (rstn_i),
							  .instr_req_o		   (instr_req_o),
							  .instr_addr_o		   (instr_addr_o),
							  .instr_gnt_i		   (instr_rvalid_i),
							  .instr_rdata_i	   (isntr_rdata_i));
								


jedro_1_decoder decoder_inst (.clk_i 		   	   (clk_i),
    						  .rstn_i 	   	   	   (rstn_i),
    						  .instr_rdata_i   	   (cinstr_r),
							  .illegal_instr_o 	   (illegal_instr),            
    						  .alu_op_sel_o    	   (alu_op_sel), 
    						  .alu_reg_op_a_o  	   (alu_reg_op_a), 
    						  .alu_reg_op_b_o  	   (alu_reg_op_b), 
   							  .alu_reg_op_a_addr_o (alu_reg_op_a_addr), 
    						  .alu_reg_op_b_addr_o (alu_reg_op_b_addr));



jedro_1_regfile #(.DATA_WIDTH(32)) regfile_inst (.clk_i   	 (clk_i),
    											 .rstn_i	 (rstn_i),
    											 .rpa_addr_i (alu_reg_op_a_addr),
    											 .rpa_data_o (reg_op_a_data),
    											 .rpb_addr_i (alu_reg_op_b_addr),
    											 .rpb_data_o (reg_op_b_data),
    											 .wpc_addr_i (4'b0),			// TODO
    											 .wpc_data_i (alu_result_data), // TODO
    											 .wpc_we_i   (1'b0));			// TODO



sign_extender #(.N(32), .M(12)) sign_extender_inst (.in_i(12'b0),
												    .out_o(32'b0));


jedro_1_alu alu_inst (.clk_i 		(clk_i),
    				  .rstn_i		(rstn_i),
					  .alu_op_sel_i (alu_op_sel),
    				  .opa_i		(reg_op_a_data),
    				  .opb_i		(reg_op_b_data),
    				  .res_o		(alu_result_data));

endmodule
