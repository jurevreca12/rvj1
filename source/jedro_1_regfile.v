////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_regfile                                            //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The register file and its interface.                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


module jedro_1_regfile
#(
	parameter	DATA_WIDTH = 32,
	parameter	ADDR_WIDTH = $clog2(DATA_WIDTH)
)
(
	input 						clk_i,
	input						rstn_i,
	input 	[ADDR_WIDTH-1:0] 	addr_i,
	input 	[DATA_WIDTH-1:0]	data_i,
	input 						we_i,
	output reg [DATA_WIDTH-1:0]	data_o
);

localparam NUM_REGISTERS = 2 ** (ADDR_WIDTH);

// Integer register file x0-x31
reg [DATA_WIDTH-1:0] reg_file [NUM_REGISTERS-1:0];


// data_o line
always@(posedge clk_i)
begin
	if (rstn_i == 1'b0) begin
		data_o = 32'b0;
	end
	else begin
		data_o = reg_file[addr_i];
	end
end


// Rexister x0-x31 reset
genvar i;
for (i=0; i < NUM_REGISTERS; i=i+1) begin
always@(posedge clk_i)
begin
	if (rstn_i == 1'b0)	begin
			reg_file[i] = 32'b0;
	end
end
end

// Write to the registers (register x0 should always be zero)
always@(posedge clk_i)
begin
	if (we_i == 1'b1 && rstn_i != 1'b0) begin
		if (addr_i != 0) begin
			reg_file[addr_i] = data_i;
		end
	end
end


`ifdef COCOTB_SIM
initial begin
	$dumpfile("jedro_1_regfile.vcd");
	$dumpvars(0, jedro_1_regfile);
	#1;
end
`endif

endmodule

