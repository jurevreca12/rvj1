`timescale 1ns/1ps

interface ram_rw_io #(
	parameter ADDR_WIDTH=32,
    parameter DATA_WIDTH=32
);	
	logic 				            we;
	logic [$clog2(DATA_WIDTH)-1:0]  be;
	logic [ADDR_WIDTH-1:0]          addr;
	logic [DATA_WIDTH-1:0]          wdata;
	logic [DATA_WIDTH-1:0]          rdata;

	modport MASTER(input rdata,
				   output we, be, addr, wdata);
	modport SLAVE (output rdata,
				   input  we, be, addr, wdata);

endinterface: ram_rw_io

