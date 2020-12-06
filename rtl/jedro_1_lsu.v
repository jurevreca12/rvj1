////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_lsu                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The load-store unit of the jedro-1 riscv core.             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
  
`include "jedro_1_defines.v"


module jedro_1_lsu
(
	input clk_i,
	input rstn_i,
	
	input lsu_new_ctrl_i, // signals if the control signal is valid (i.e. new instruction)
	input [`LSU_CTRL_WIDTH-1:0] lsu_ctrl_i,

	// Decoded signals from the decoder
	input [`REG_ADDR_WIDTH-1:0] lsu_regdest_i,
	input [`REG_ADDR_WIDTH-1:0] lsu_regsrc1_i,
	input [11:0]				lsu_offset_i,
	input [`REG_ADDR_WIDTH-1:0] lsu_regsrc2_i	
);


endmodule
