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
	input rstn_i

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


jedro_1_decoder decoder_inst (.clk_i 		   	   (clk_i),
    						  .rstn_i 	   	   	   (rstn_i),
    						  .instr_rdata_i   	   (instr_rdata_i),
							  .illegal_instr_o 	   (TODO),           
    						  .alu_op_sel_o    	   (TODO),
    						  .alu_reg_op_a_o  	   (TODO),
    						  .alu_reg_op_b_o  	   (TODO),
   							  .alu_reg_op_a_addr_o (TODO),
    						  .alu_reg_op_b_addr_o (TODO));



jedro_1_regfile #(.DATA_WIDTH(32)) regfile_inst (.clk_i   	 (clk_i),
    											 .rstn_i	 (rstn_i),
    											 .rpa_addr_i (TODO),
    											 .rpa_data_o (TODO),
    											 .rpb_addr_i (TODO),
    											 .rpb_data_o (TODO),
    											 .wpc_addr_i (TODO),
    											 .wpc_data_i (TODO), 
    											 .wpc_we_i   (TODO));



sign_extender #(.N(32), .M(12)) sign_extender_inst (.in_i(TODO),
												    .out_o(TODO));


jedro_1_alu alu_inst (.clk_i 		(clk_i),
    				  .rstn_i		(rstn_i),
					  .alu_op_sel_i (TODO),
    				  .opa_i		(TODO),
    				  .opb_i		(TODO),
    				  .res_o		(TODO));
);


endmodule
