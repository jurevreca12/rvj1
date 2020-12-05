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
	
	output						 rsta_o
	output reg					 en_o,	
	output     [`DATA_WIDTH-1:0] addr_o,
	input 	   [`DATA_WIDTH-1:0] data_i
);

reg [`DATA_WIDTH-1:0] pc_r;
reg [`DATA_WIDTH-1:0] cinstr;

// COMBINATIAL LOGIC
// The output address just follows pc_r
assign addr_o = pc_r;
assign rsta_o = ~rstn_i;

// SEQUENTIAL LOGIC
// Synchronous reset
always @(posedge clk_i) begin
	if (rstn_i == 1'b0) begin
		pc_r <= `BOOT_ADDR;
		en_o <= 1'b1;
	end
	if begin
		cinstr <= data_i;
		pc_r   <= pc_r + 4; // TODO add suport for jump instructions
	end
end








