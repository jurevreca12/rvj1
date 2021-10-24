`timescale 1ns/1ps

interface ram_read_io #(
		parameter ADDR_WIDTH=32,
		parameter DATA_WIDTH=32
	);

	logic [ADDR_WIDTH-1:0] addr;
	logic [DATA_WIDTH-1:0] rdata;

	modport MASTER (input  rdata, output addr);
	modport SLAVE  (output rdata, input  addr);
endinterface: ram_read_io

