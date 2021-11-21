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
  input  [DATA_WIDTH-1:0]     addr_i,        // Address of the memory to ready/write.
  input  [DATA_WIDTH-1:0]     wdata_i,       // The data to write to memory.
 
  // Interface to the register file
  output [DATA_WIDTH-1:0]     rdata_o,       // Goes to the register file.
  output                      rf_wb_o,       // Enables the write pin of the reg file.
  input  [REG_ADDR_WIDTH-1:0] regdest_i,     // Writeback to which register?
  output [REG_ADDR_WIDTH-1:0] regdest_o,

  // Interface to data RAM
  ram_rw_io.MASTER            data_mem_if
);

/**************************************
* SIGNAL DECLARATION & SHORTHANDS
**************************************/
logic is_write; // Is the current ctrl input a writei

assign is_write = ctrl_i[LSU_CTRL_WIDTH-1];


/**************************************
* DESTINATIONAL ADDRESS BUFFERING
**************************************/
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        regdest_o <= 0;
    end
    else begin
        regdest_o <= regdest_i;
    end
end


/**************************************
* REGISTER WRITEBACK
**************************************/


/**************************************
* HANDLE MEM INTERFACE
**************************************/
assign data_mem_if.addr  = addr_i;
assign data_mem_if.we    = is_write;
assign data_mem_if.wdata = wdata_i;

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        rdata_o <= 0;
    end
    else begin
        rdata_o <= data_mem_if.rdata;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        
    end
    else begin
    
    end
end

endmodule : jedro_1_lsu

