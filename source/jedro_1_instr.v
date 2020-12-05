////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_instr                                              //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The instruction interface to the RAM memory.               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`include "jedro_1_defines.v"

module jedro_1_instr 
(
	input					 	 clk_i,
	input						 rstn_i,
	
	output reg					 en_o,	
	output reg [`ADDR_WIDTH-1:0] addr_o,
	input 	   [`DATA_WIDTH-1:0] data_i
);


