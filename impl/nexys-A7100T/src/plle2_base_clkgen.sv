// Based on: 
// https://github.com/open-design/riscv-soc-cores/blob/master/systems/arty/rtl/verilog/plle2_base_wb_clkgen.v

module plle2_base_clkgen #(
	parameter INPUT_FREQUENCY_MHZ = 100,
	parameter DIVCLK_DIVIDE = 1,
	parameter CLKFBOUT_MULT = 1
) (
	input  sys_clk_pad_i, // Main clocks in, depending on board
	input  rst_pad_i,     // Asynchronous, active high reset in
	output async_rstn_o,  // Asynchronous, active low reset out
  output clk_o,         // synthesized clock out
  output rstn_o         // synchronous reset
	);
	assign async_rstn_o = ~rst_pad_i;
  assign rstn_o = ~rst_pad_i;

  localparam RESETCNT_BITS = 8;
  localparam RESETCNT_VAL  = (2 << RESETCNT_BITS) - 1;

	// PLL stuff
	wire clk_in1_clk_gen_sys;
	IBUF clkin1_ibufg (.O (clk_in1_clk_gen_sys), .I (sys_clk_pad_i));

	wire clk_out1_clk_gen_sys;
	wire clkfbout_clk_gen_sys;
	wire clkfbout_buf_clk_gen_sys;
  
	PLLE2_BASE #(
		.BANDWIDTH ("OPTIMIZED"),
		.STARTUP_WAIT ("FALSE"),
		.DIVCLK_DIVIDE (DIVCLK_DIVIDE),
		.CLKFBOUT_MULT (CLKFBOUT_MULT),
		.CLKFBOUT_PHASE (0.000),
		.CLKOUT0_PHASE (0.000),
		.CLKOUT0_DUTY_CYCLE (0.500),
		.CLKIN1_PERIOD (1000.000 / INPUT_FREQUENCY_MHZ)
	) plle2_base_inst (
		.CLKFBIN(clkfbout_buf_clk_gen_sys),
		.CLKIN1(clk_in1_clk_gen_sys),
		.CLKFBOUT(clkfbout_clk_gen_sys),
		.CLKOUT0(clk_out1_clk_gen_sys),
		.LOCKED(),
		.PWRDWN(1'b0),
		.RST(rst_pad_i)
	);

	BUFG clkf_buf (.O (clkfbout_buf_clk_gen_sys), .I (clkfbout_clk_gen_sys));
	BUFG clkout1_buf (.O (clk_o), .I (clk_out1_clk_gen_sys));

endmodule
