package interfaces;
	interface if_ram_1way #(
			parameter ADDR_WIDTH=32,
			parameter DATA_WIDTH=32
		) (input clk, input reset);

		logic		 		 					 ram_req;
		logic		 		 					 ram_gnt;
		logic									 ram_rvalid;
		logic [ADDR_WIDTH-1:0] ram_addr;
		logic [DATA_WIDTH-1:0] ram_rdata;

		modport MASTER(input ram_gnt, ram_rvalid, ram_rdata, output ram_req, ram_addr)
		modport SLAVE(output ram_gnt, ram_rvalid, ram_rdata, input  ram_req, ram_addr)
	endinterface: if_ram_oneway

	interface if_ram_2way_32b_data #(
		parameter ADDR_WIDTH=32,
	);
		
		logic 								 ram_req;
		logic 								 ram_gnt;
		logic 								 ram_rvalid;
		logic 								 ram_we;
		logic [3:0] 					 ram_be;
		logic [ADDR_WIDTH-1:0] ram_addr;
		logic [31:0]					 ram_wdata;
		logic [31:0]					 ram_rdata;
		logic									 ram_err;

		modport MASTER(input  ram_gnt, ram_rvalid, ram_rdata, ram_err,
									 output	ram_req, ram_we, ram_be, ram_addr, ram_wdata)
		modport SLAVE (output ram_gnt, ram_rvalid, ram_rdata, ram_err,
									 input	ram_req, ram_we, ram_be, ram_addr, ram_wdata)

	endinterface: if_ram_twoway

endpackage	
