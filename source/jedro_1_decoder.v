////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro-1_decoder		                                      //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    Decoder for the RV32I instructions.	         		      //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`include "jedro_1_defines.v"

module riscv_jedro_1 
(
	input [31:0] 	instr_rdata_i,		// Instructions coming in from memory/cache
	output reg   	illegal_insn_o		// Illegal instruction encountered
);

always @(*)
begin
	case (instr_rdata_i[6:0])
		OPCODE_LOAD: begin

		end

		OPCODE_MISCMEM: begin
		
		end

		OPCODE_OPIMM: begin
		
		end

		OPCODE_AUIPC: begin

		end

		OPCODE_STORE: begin

		end

		OPCODE_LUI: begin

		end

		OPCODE_BRANCH: begin

		end

		OPCODE_JALR: begin

		end

		OPCODE_JAL: begin

		end

		OPCODE_SYSTEM: begin

		end

		default: begin
			illegal_insn_o = 1'b1;
		end
	endcase
end

endmodule // riscv_jedro_1
