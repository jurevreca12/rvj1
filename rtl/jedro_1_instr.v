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
	input 						 get_next_instr_i,	// A signal that specifys that we can get the next isntruction (controlled by the cores FSM)
	input						 jmp_instr_i,		// specify that we encountered a jump instruction and the program counter should be changed to jmp_address_i
	input	   [`DATA_WIDTH-1:0] jmp_address_i,		// The address to jump to, after we had encountered a jump instruction
	
	// Interface to the ROM memory
	output  					 rsta_o,	// Reset the memory
	output reg					 en_o,		// Enable the memory
	output     [`DATA_WIDTH-1:0] addr_o,	// The relevant address of the isntruction
	input 	   [`DATA_WIDTH-1:0] data_i,	// The instruction

	// Interface to the decoder
	output reg [`DATA_WIDTH-1:0] cinstr_o		// The current instruction (to be decoded)
);

reg [`DATA_WIDTH-1:0] pc_r;

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
		cinstr_o <= 0;
	end
	else if (get_next_instr_i == 1'b1) begin
		if (jmp_instr_i == 1'b1) begin
			pc_r <= jmp_address_i;
		end
		else begin
			pc_r <= pc_r + 4;
		end 
	end
	
	cinstr_o <= data_i;
	
end

`ifdef COCOTB_SIM
initial begin
	$dumpfile ("jedro_1_instr_test.vcd");
	$dumpvars (0, jedro_1_instr);
end
`endif

endmodule




