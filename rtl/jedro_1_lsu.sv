////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_lsu                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The load-store unit of the jedro-1 riscv core. The LSU     //
//                 assumes a single cycle delay write, with no-change on      //
//                 the read port when writing (Xilinx 7 Series Block RAM in   //
//                 no-change mode using only a single port.                   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
  
import jedro_1_defines::*;

module jedro_1_lsu
(
  input clk_i,
  input rstn_i,
  
  // Inputs from the decoder/ALU
  input                       ctrl_valid_i,
  input  [LSU_CTRL_WIDTH-1:0] ctrl_i,
  input  [ADDR_WIDTH-1:0]     addr_i,        // Address of the memory to ready/write.
  input  [DATA_WIDTH-1:0]     wdata_i,       // The data to write to memory.
 
  // Interface to the register file
  output [DATA_WIDTH-1:0]     rdata_o,       // Goes to the register file.
  output                      rf_wb_o,       // Enables the write pin of the reg file.
  input  [REG_ADDR_WIDTH-1:0] regdest_i,     // Writeback to which register?

  // Interface to data RAM
  ram_rw_io.MASTER            data_mem_if
);


endmodule : jedro_1_lsu
