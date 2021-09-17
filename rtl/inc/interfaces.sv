package interfaces;
	interface if_ram_oneway #(
			parameter ADDR_WIDTH=32,
			parameter DATA_WIDTH=32
		);

		logic		 		 					 ram_req;
		logic		 		 					 ram_gnt;
		logic [ADDR_WIDTH-1:0] ram_addr;
		logic [DATA_WIDTH-1:0] ram_rdata;
	endinterface: if_ram_oneway

	interface if_ram_twoway #(
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
	endinterface: if_ram_twoway

endpackage	
