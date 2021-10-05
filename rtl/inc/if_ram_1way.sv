`timescale 1ns/1ps

interface if_ram_1way #(
		parameter ADDR_WIDTH=32,
		parameter DATA_WIDTH=32
	);

	logic [ADDR_WIDTH-1:0] ram_addr;
	logic [DATA_WIDTH-1:0] ram_rdata;

	modport MASTER (input  ram_rdata, output ram_addr);
	modport SLAVE  (output ram_rdata, input  ram_addr);
endinterface: if_ram_1way

