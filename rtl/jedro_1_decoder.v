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

	// Interface to instruction interface 
	input 		[`DATA_WIDTH-1:0]		instr_rdata_i,		// Instructions coming in from memory/cache

	// Interface to the control unit
	output reg 							illegal_instr_o,	// Illegal instruction encountered			

	// ALU interface
	output reg [`ALU_OP_WIDTH-1:0]   	alu_op_sel_o,		// Combination of funct3 + 6-th bit of funct7
	output reg 							alu_reg_op_a_o,
	output reg 							alu_reg_op_b_o,
	output reg [`REG_ADDR_WIDTH-1:0]	alu_reg_op_a_addr_o,
	output reg [`REG_ADDR_WIDTH-1:0]	alu_reg_op_b_addr_o,
	
	output reg [11:0]					alu_immediate_o,	// to be sign extended
	output reg 							lsu_new_cntrl_o,	
	output reg [3:0]					lsu_ctrl_o,
	output reg [`REG_ADDR_WIDTH-1:0]	lsu_regdest_o
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


// Interface to the contol unit
always @(posedge clk_i)
begin
	if (rstn_i == 1'b0) begin
		illegal_instr_o <= 1'b0;
	end
end

// ALU interface
always @(posedge clk_i)
begin
	if (rstn_i == 1'b0) begin
		alu_op_sel_o 		<= {`ALU_OP_WIDTH{1'b0}};
		alu_reg_op_a_o   	<= 1'b0;
		alu_reg_op_b_o   	<= 1'b0;
		alu_reg_op_a_addr_o <= {`REG_ADDR_WIDTH{1'b0}};
		alu_reg_op_b_addr_o <= {`REG_ADDR_WIDTH{1'b0}}; 
	end
end

// Start decoding a new instruction
always @(posedge clk_i)
begin
	case (opcode)
		`OPCODE_LOAD: begin
			lsu_new_cntrl_o 	<= 1'b1;
			lsu_ctrl_o			<= {opcode[6], funct3};
			lsu_regdest_o		<= regdest;
			alu_reg_op_a_o		<= 1'b1;
			alu_reg_op_a_addr_o	<= regs1;
			alu_immediate_o		<= imm11_0;
		end

		`OPCODE_MISCMEM: begin
		
		end

		`OPCODE_OPIMM: begin
		
		end

		`OPCODE_AUIPC: begin

		end

		`OPCODE_STORE: begin
			lsu_new_cntrl_o 	<= 1;
			lsu_ctrl_o			<= {opcode[6], funct3};
			alu_reg_op_a_o		<= 1'b1;	
			alu_reg_op_a_addr_o	<= regs1;	
			alu_immediate_o		<= {instr_rdata_i[31:25], instr_rdata_i[11:7]};
		end
		
		`OPCODE_OP: begin
			alu_op_sel_o <= {instr_rdata_i[30], funct3};
			alu_reg_op_a_o <= 1;
			alu_reg_op_b_o <= 1;
			alu_reg_op_a_addr_o <= regs1;
			alu_reg_op_b_addr_o <= regs2;
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
