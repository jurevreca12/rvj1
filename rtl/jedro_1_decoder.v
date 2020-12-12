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
	output reg [`REG_ADDR_WIDTH-1:0]	alu_reg_dest_addr,		// So the ALU knows where to store the result after computing it.
	output reg [`DATA_WIDTH:0]			alu_immediate_ext_o,	// sign extended

	// Interface to the load-store unit
	output reg 							lsu_new_cntrl_o,	
	output reg [3:0]					lsu_ctrl_o,
	output reg [`REG_ADDR_WIDTH-1:0]	lsu_regdest_o
);

// Helpfull shorthands for sections of the instruction (see riscv specifications)
wire [6:0]   opcode   = instr_rdata_i[6:0];
wire [11:7]  regdest  = instr_rdata_i[11:7];
wire [11:7]  imm4_0   = instr_rdata_i[11:7];
wire [31:12] imm31_12 = instr_rdata_i[31:12]; // U-type immediate 
wire [31:20] imm11_0  = instr_rdata_i[31:20]; // I-type immediate
wire [14:12] funct3   = instr_rdata_i[14:12];
wire [19:15] regs1	  = instr_rdata_i[19:15];
wire [24:20] regs2	  = instr_rdata_i[24:20];
wire [31:25] funct7   = instr_rdata_i[31:25];


// Other signal definitions
wire [`DATA_WIDTH-1:0] I_immediate_sign_extended_w;
wire [`DATA_WIDTH-1:0] J_immediate_sign_extended_w;
wire [`DATA_WIDTH-1:0] B_immediate_sign_extended_w;


// COMBINATIONAL LOGIC
// For the I instruction type immediate
sign_extender #(.N(`DATA_WIDTH), .M(12)) sign_extender_inst_I (.in_i(imm11_0),
								 	                         .out_o(I_immediate_sign_extended_w));

// For the J instruction type immediate
sign_extender #(.N(`DATA_WIDTH), .M(12)) sign_extender_inst_J (.in_i({instr_rdata_i[31], instr_rdata_i[19:12], instr_rdata_i[20], instr_rdata_i[10:1], 1'b0}),
								 	                         .out_o(J_immediate_sign_extended_w));

// For the B instruction type immediate
sign_extender #(.N(`DATA_WIDTH), .M(12)) sign_extender_inst_B (.in_i({instr_rdata_i[31], instr_rdata_i[7], instr_rdata_i[30:25], instr_rdata_i[11:8], 1'b0}),
								 	                         .out_o(B_immediate_sign_extended_w));
// Reset
always @(posedge clk_i)
begin
	if (rstn_i == 1'b0) begin
		alu_op_sel_o 		<= {`ALU_OP_WIDTH{1'b0}};
		alu_reg_op_a_o   	<= 1'b0;
		alu_reg_op_b_o   	<= 1'b0;
		alu_reg_op_a_addr_o <= {`REG_ADDR_WIDTH{1'b0}};
		alu_reg_op_b_addr_o <= {`REG_ADDR_WIDTH{1'b0}}; 
		alu_immediate_ext_o <= 0;
		illegal_instr_o 	<= 1'b0;
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
			alu_immediate_ext_o <= I_immediate_sign_extended_w;		
		end

		`OPCODE_MISCMEM: begin	
			alu_immediate_ext_o <= I_immediate_sign_extended_w;		
		end

		`OPCODE_OPIMM: begin	
			alu_immediate_ext_o <= I_immediate_sign_extended_w;		
		end

		`OPCODE_AUIPC: begin
			alu_immediate_ext_o <= {imm31_12, 12'b0};
		end

		`OPCODE_STORE: begin
			lsu_new_cntrl_o 	<= 1;
			lsu_ctrl_o			<= {opcode[6], funct3};
			alu_reg_op_a_o		<= 1'b1;	
			alu_reg_op_a_addr_o	<= regs1;	
			alu_immediate_ext_o	<= {instr_rdata_i[31:25], instr_rdata_i[11:7]};
		end
		
		`OPCODE_OP: begin
			alu_op_sel_o <= {instr_rdata_i[30], funct3};
			alu_reg_op_a_o <= 1;
			alu_reg_op_b_o <= 1;
			alu_reg_op_a_addr_o <= regs1;
			alu_reg_op_b_addr_o <= regs2;
			alu_immediate_ext_o <= 32'b0;
		end

		`OPCODE_LUI: begin
			alu_immediate_ext_o <= {imm31_12, 12'b0};
		end

		`OPCODE_BRANCH: begin
			alu_immediate_ext_o <= B_immediate_sign_extended_w;		
		end

		`OPCODE_JALR: begin
			alu_immediate_ext_o <= I_immediate_sign_extended_w;		
		end

		`OPCODE_JAL: begin
			alu_immediate_ext_o <= J_immediate_sign_extended_w;		
		end

		`OPCODE_SYSTEM: begin
			// TODO kaj s alu_immediate_ext_o?
		end

		default: begin
			illegal_instr_o <= 1'b1;
			alu_immediate_ext_o <= 32'b0;
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
