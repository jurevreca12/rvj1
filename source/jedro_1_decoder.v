////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_decoder		                                      //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    Decoder for the RV32I instructions.	         		      //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`include "jedro_1_defines.v"

module jedro_1_decoder
(
	input 								clk_i,
	input								rstn_i,

	// Interface to instruction LSU 
	input 		[31:0] 					instr_rdata_i,		// Instructions coming in from memory/cache
	input								instr_next_avail_i,	// Signals that the next instruction is available
	output reg							instr_next_en_o,	// Get the next instruction

	// Interface to the control unit
	output reg 							illegal_instr_o,	// Illegal instruction encountered			

	// ALU interface
	output reg [`ALU_OP_WIDTH-1:0]   	alu_op_sel_o,		// Combination of funct3 + 6-th bit of funct7
	output reg						 	alu_en,				
	output reg [`DATA_WIDTH-1:0]		alu_op_a_o,
	output reg [`DATA_WIDTH-1:0]		alu_op_b_o,

	// Register file interface
	input  [`DATA_WIDTH-1:0]			reg_a_data_i,
	output [`ADDR_WIDTH-1:0]			reg_a_addr_o,
	input  [`DATA_WIDTH-1:0]			reg_b_data_i,
	output [`ADDR_WIDTH-1:0]			reg_b_addr_o
);

// Helpfull shorthands for sections of the instruction (see riscv specifications)
wire [6:0]   opcode   = instr_rdata_i[6:0];
wire [11:7]  regdest  = instr_rdata_i[11:7];
wire [11:7]  imm4_0   = instr_rdata_i[11:7];
wire [31:12] imm31_12 = instr_rdata_i[31:12]; 
wire [31:20] imm11_0  = instr_rdata_i[31:20];
wire [14:12] funct3   = instr_rdata_i[14:12];
wire [19:15] regs1	  = instr_rdata_i[19:15];
wire [24:20] regs2	  = instr_rdata_i[24:20];
wire [31:25] funct7   = instr_rdata_i[31:25];

// Holds the currently decoded instruction
reg [`DATA_WIDTH-1:0] instr_current;


// Handle the interface to the instruction load store unit
always @(posedge clk_i)
begin
	if (rstn_i == 1'b0) begin
		instr_next_en_o <= 1'b0;
		instr_current <= 32'b0;
	end
	else begin
		// Fetch next instr, if it is available and we are done with previous instructions
		if (instr_next_avail_i == 1'b1) begin
			instr_next_en_o <= 1'b0;
			instr_current 	<= instr_rdata_i;
		end
	end
end



// Start decoding a new instruction
always @(instr_current)
begin
	case (opcode)
		`OPCODE_LOAD: begin

		end

		`OPCODE_MISCMEM: begin
		
		end

		`OPCODE_OPIMM: begin
		
		end

		`OPCODE_AUIPC: begin

		end

		`OPCODE_STORE: begin

		end
		
		`OPCODE_OP: begin
			//reg_a_addr_o <= regs1;
			//reg_b_addr_o <= regs2;
			//@ (posedge clk);
		    //alu_op_a_o <= reg_a_data_i;
			//alu_op_b_o <= reg_b_data_i;
			//alu_op_sel_o = 1;
			//alu_en = 1;
		end

		`OPCODE_LUI: begin

		end

		`OPCODE_BRANCH: begin

		end

		`OPCODE_JALR: begin

		end

		`OPCODE_JAL: begin

		end

		`OPCODE_SYSTEM: begin

		end

		default: begin
			illegal_instr_o = 1'b1;
		end
	endcase
end


`ifdef COCOTB_SIM
initial begin
    $dumpfile("jedro_1_decoder.vcd");
    $dumpvars(0, jedro_1_decoder);
    #1;
end
`endif


endmodule // jedro_1_decoder
