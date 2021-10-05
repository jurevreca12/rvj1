`timescale 1ns/1ps

interface if_ram_2way_32b_data #(
	parameter ADDR_WIDTH=32
);	
	logic 								 ram_we;
	logic [3:0] 					 ram_be;
	logic [ADDR_WIDTH-1:0] ram_addr;
	logic [31:0]					 ram_wdata;
	logic [31:0]					 ram_rdata;
	logic									 ram_err;

	modport MASTER(input  ram_rdata, ram_err,
								 output	ram_we, ram_be, ram_addr, ram_wdata);
	modport SLAVE (output ram_rdata, ram_err,
								 input	ram_we, ram_be, ram_addr, ram_wdata);

endinterface: if_ram_2way_32b_data 

