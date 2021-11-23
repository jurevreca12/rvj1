`timescale 1ns/1ps

interface ram_rw_io #(
	parameter ADDR_WIDTH=32,
    parameter DATA_WIDTH=32
);	
	logic [DATA_WIDTH/8-1:0]        we;
	logic [ADDR_WIDTH-1:0]          addr;
	logic [DATA_WIDTH-1:0]          wdata;
	logic [DATA_WIDTH-1:0]          rdata;

	modport MASTER(input rdata,
				   output we, addr, wdata);
	modport SLAVE (output rdata,
				   input  we, addr, wdata);

endinterface: ram_rw_io

