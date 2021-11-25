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
  input logic clk_i,
  input logic rstn_i,
  
  // Inputs from the decoder/ALU
  input logic                       ctrl_valid_i,
  input logic  [LSU_CTRL_WIDTH-1:0] ctrl_i,
  input logic  [DATA_WIDTH-1:0]     addr_i,        // Address of the memory to ready/write.
  input logic  [DATA_WIDTH-1:0]     wdata_i,       // The data to write to memory.
 
  // Interface to the register file
  output logic [DATA_WIDTH-1:0]     rdata_ro,       // Goes to the register file.
  output logic                      rf_wb_ro,       // Enables the write pin of the reg file.
  input  logic [REG_ADDR_WIDTH-1:0] regdest_i,     // Writeback to which register?
  output logic [REG_ADDR_WIDTH-1:0] regdest_ro,

  // Interface to data RAM
  ram_rw_io.MASTER                  data_mem_if
);

localparam READ_CYCLE_DELAY = 3;

logic [REG_ADDR_WIDTH-1:0] regdest_shift_reg [READ_CYCLE_DELAY-1:0];
logic                      wb_shift_reg [READ_CYCLE_DELAY-1:0];


/**************************************
* WRITE ENABLE SIGNAL
**************************************/
logic is_write; // Is the current ctrl input a write
logic [DATA_WIDTH/8 -1:0] we; // write enable signal

assign is_write = ctrl_i[LSU_CTRL_WIDTH-1];

always_comb begin
    if (is_write == 1'b1) begin
        if (ctrl_i[LSU_CTRL_WIDTH-2:0] == 3'b010) begin
            we = 4'b1111; // word write
        end
        else if (ctrl_i[LSU_CTRL_WIDTH-2:0] == 3'b001) begin
            we = 4'b0011; // half-word write
        end
        else if (ctrl_i[LSU_CTRL_WIDTH-2:0] == 3'b000) begin
            we = 4'b0001; // byte write
        end
        else begin
            we = 4'b0000;
        end
    end
    else begin
        we = 4'b0000;
    end
end


/**************************************
* DESTINATIONAL ADDRESS BUFFERING
**************************************/
assign regdest_ro = regdest_shift_reg[READ_CYCLE_DELAY-1];

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        regdest_shift_reg[0] <= 0;
        regdest_shift_reg[1] <= 0;
        regdest_shift_reg[2] <= 0;
    end
    else begin
        regdest_shift_reg[0] <= regdest_i;
        regdest_shift_reg[1] <= regdest_shift_reg[0];
        regdest_shift_reg[2] <= regdest_shift_reg[1];
    end
end


/**************************************
* REGISTER WRITEBACK
**************************************/
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        wb_shift_reg[0] <= 0;
        wb_shift_reg[1] <= 0;
        wb_shift_reg[2] <= 0;
    end
    else begin
        wb_shift_reg[0] <= ctrl_valid_i & ~is_write;
        wb_shift_reg[1] <= wb_shift_reg[0];
        wb_shift_reg[2] <= wb_shift_reg[1];
    end
end


/**************************************
* HANDLE MEM INTERFACE
**************************************/
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        rdata_ro <= 0;
    end
    else begin
        rdata_ro <= data_mem_if.rdata;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
       data_mem_if.addr <= 0;
       data_mem_if.we <= 0;
       data_mem_if.wdata <= 0; 
    end
    else begin
       data_mem_if.addr <= addr_i;
       data_mem_if.we <= we & {4{ctrl_valid_i}};
       data_mem_if.wdata <= wdata_i; 
    end
end

endmodule : jedro_1_lsu

