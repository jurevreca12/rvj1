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
  parameter DATA_WIDTH = 32,
  parameter REG_ADDR_WIDTH = $clog2(DATA_WIDTH)
)
(
  input logic clk_i,
  input logic rstn_i,

  // Read port A
  input logic [REG_ADDR_WIDTH-1:0] rpa_addr_i,
  output logic [DATA_WIDTH-1:0]     rpa_data_o,

  // Read port B
  input logic [REG_ADDR_WIDTH-1:0] rpb_addr_i,
  output logic [DATA_WIDTH-1:0]     rpb_data_o,

  // Write port C
  input logic [REG_ADDR_WIDTH-1:0]  wpc_addr_i,
  input logic [DATA_WIDTH-1:0]      wpc_data_i,
  input logic                       wpc_we_i,

  // Destination address register stage
  input logic [REG_ADDR_WIDTH-1:0] reg_alu_dest_i,
  output logic [REG_ADDR_WIDTH-1:0] reg_alu_dest_o,
  
  // Write enable buffering
  input logic reg_alu_wb_i,
  output logic reg_alu_wb_o
);

localparam NUM_REGISTERS = 2 ** (REG_ADDR_WIDTH);

// Integer register file x0-x31
logic [DATA_WIDTH-1:0] regfile [NUM_REGISTERS-1:0];


// Mux the appropriate register to the data_o line
assign rpa_data_o = regfile[rpa_addr_i];
assign rpb_data_o = regfile[rpb_addr_i];

// Write to the registers (register x0 should always be zero)
always_ff@(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    for (int i=0; i < NUM_REGISTERS; i=i+1)
      regfile[i] <= 32'b0;
  end
  else begin
  if (wpc_we_i == 1'b1 & wpc_addr_i != 0) 
    regfile[wpc_addr_i] <= wpc_data_i;
  end
end

// Destination address register buffering
// and writeback buffering
always_ff@(posedge clk_i) begin
  if(rstn_i == 1'b0) begin
    reg_alu_dest_o <= 0;
    reg_alu_wb_o   <= 0;
  end
  else begin
    reg_alu_dest_o <= reg_alu_dest_i;
    reg_alu_wb_o   <= reg_alu_wb_i;
  end
end

endmodule

