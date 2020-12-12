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

 // Instruction interface
 	output	 					 ifu_rsta_o,
	output 						 ifu_en_o,
	output 	   [`DATA_WIDTH-1:0] ifu_addr_o,
	input wire [`DATA_WIDTH-1:0] ifu_data_i,				

 // Data interface
	output reg 						data_req_o,
	input 	   						data_gnt_i,
	input	   						data_rvalid_i,
	output reg  					data_we_o,
	output reg [3:0]				data_be_o,
	output reg [`DATA_WIDTH-1:0]	data_addr_o,
	output reg [`DATA_WIDTH-1:0]	data_wdata_o,
	input  	   [`DATA_WIDTH-1:0]	data_rdata_i,
	input							data_err_i

 // IRQ interface


 // Debug interface

);

wire [`ALU_OP_WIDTH-1:0] alu_op_sel;
wire alu_reg_op_a;
wire alu_reg_op_b;
wire [`REG_ADDR_WIDTH-1:0] alu_reg_op_a_addr;
wire [`REG_ADDR_WIDTH-1:0] alu_reg_op_b_addr;
wire [`DATA_WIDTH-1:0] reg_op_a_data;
wire [`DATA_WIDTH-1:0] reg_op_b_data;
wire [`DATA_WIDTH-1:0] alu_result_data;
wire [`DATA_WIDTH-1:0] decoder_immediate_extended;
wire [`DATA_WIDTH-1:0] mux_alu_operand_b;
wire alu_is_immediate;
wire ifu_current_instr;
wire alu_overflow;
wire next_instr_lock;
wire alu_reg_dest_addr;

jedro_1_ifu		ifu_inst 	 (.clk_i			   (clk_i),
							  .rstn_i			   (rstn_i),

							  // The interface to the FSM
							  .get_next_instr_i	   (1'b1), // TODO
							  .next_instr_lock_o   (next_instr_lock), // This signal should probably go to the FSM 
							  .jmp_instr_i		   (1'b0),
							  
							  .jmp_address_i	   (32'b0),

							  // The instruction interface
							  .rsta_o			   (ifu_rsta_o),
							  .en_o				   (ifu_en_o),
							  .addr_o			   (ifu_addr_o),
							  .data_i			   (ifu_data_i),
							  
							  // The decoder interface
							  .cinstr_o			   (ifu_current_instr));	


jedro_1_decoder decoder_inst (.clk_i 		   	       (clk_i),
    						  .rstn_i 	   	   	       (rstn_i),
    						  
							  .instr_rdata_i   	       (ifu_current_instr),
							  .illegal_instr_o 	       (illegal_instr),
            
    						  .alu_op_sel_o    	       (alu_op_sel), 
    						  .alu_reg_op_a_o  	       (alu_reg_op_a), 
    						  .alu_reg_op_b_o  	       (alu_reg_op_b), 
   							  .alu_reg_op_a_addr_o 	   (alu_reg_op_a_addr), 
    						  .alu_reg_op_b_addr_o 	   (alu_reg_op_b_addr),
							  .alu_reg_dest_addr_o	   (alu_reg_dest_addr),
							  .alu_immediate_ext_o 	   (decoder_immediate_extended));



jedro_1_regfile #(.DATA_WIDTH(32)) regfile_inst (.clk_i   	 (clk_i),
    											 .rstn_i	 (rstn_i),
    											 .rpa_addr_i (alu_reg_op_a_addr),
    											 .rpa_data_o (reg_op_a_data),
    											 .rpb_addr_i (alu_reg_op_b_addr),
    											 .rpb_data_o (reg_op_b_data),
    											 .wpc_addr_i (4'b0),			// TODO
    											 .wpc_data_i (alu_result_data), // TODO
    											 .wpc_we_i   (1'b0));			// TODO


// alu_is_immediate signal tells if an operation is between 2 registers or an
// register and an immediate. Based on this the 2:1 MUX bellow selects the 
// mux_alu_operand_b
assign alu_is_immediate = ~(alu_reg_op_a & alu_reg_op_b);
assign mux_alu_operand_b = alu_is_immediate ? reg_op_b_data : decoder_immediate_extended;

jedro_1_alu alu_inst (.clk_i 		(clk_i),
    				  .rstn_i		(rstn_i),
					  .alu_op_sel_i (alu_op_sel),
    				  .opa_i		(reg_op_a_data),
    				  .opb_i		(mux_alu_operand_b),
    				  .res_o		(alu_result_data),
					  .overflow_o	(alu_overflow)); // overflow signal should probably go to the FSM

endmodule
