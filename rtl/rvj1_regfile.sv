////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_regfile                                               //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The register file and its interface.                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
import rvj1_defines::*;

module rvj1_regfile (
    input logic clk_i,
    input logic rstn_i,

    // Read port A
    input  logic [RALEN-1:0] rpa_addr_i,
    output logic [XLEN-1:0]  rpa_data_o,

    // Read port B
    input  logic [RALEN-1:0] rpb_addr_i,
    output logic [XLEN-1:0]  rpb_data_o,

    // Write port C
    input logic [RALEN-1:0] wpc_addr_i,
    input logic [XLEN-1:0]  wpc_data_i,
    input logic             wpc_we_i
);

  // Integer register file x0-x31
  logic [XLEN-1:0] regfile[NREG];

  /******************************
* WRITE LOGIC
******************************/
  // Write to the registers (register x0 should always be zero)
  integer i;
  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
      for (i = 0; i < NREG; i = i + 1) regfile[i] <= 32'b0;
    end else begin
      if (wpc_we_i == 1'b1 & wpc_addr_i != 0) regfile[wpc_addr_i] <= wpc_data_i;
    end
  end


  /******************************
* READ LOGIC
******************************/
  // Mux the appropriate register to the data_o line
  assign rpa_data_o = regfile[rpa_addr_i];
  assign rpb_data_o = regfile[rpb_addr_i];


endmodule

