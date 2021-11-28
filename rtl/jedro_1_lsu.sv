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
logic [3:0]                load_mask_shift_reg [READ_CYCLE_DELAY-1:0];
logic                      load_mask_shift_w;
logic [DATA_WIDTH-1:0]     load_mask_final_w;
logic                      is_unsigned_sign_ext_reg [READ_CYCLE_DELAY-2:0];
logic [DATA_WIDTH-1:0]     byte_sign_extended_w;
logic [DATA_WIDTH-1:0]     hword_sign_extended_w;


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
* READ MASKING
**************************************/
always_comb begin
    if (is_write == 1'b1) begin
        load_mask_shift_w = 4'b0000;
    end
    else begin
        if (ctrl_i[1:0] == 3'b10) begin
            load_mask_shift_w = 4'b1111; // word 
        end
        else if (ctrl_i[1:0] == 2'b01) begin
            load_mask_shift_w = 4'b0011; // half-word 
        end
        else if (ctrl_i[1:0] == 2'b00) begin
            load_mask_shift_w = 4'b0001; // byte write
        end
        else begin
            load_mask_shift_w = 4'b0000;
        end
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        is_unsigned_sign_ext_reg[0] <= 0;
        is_unsigned_sign_ext_reg[1] <= 0;
    end
    else begin
        is_unsigned_sign_ext_reg[0] <= ctrl_i[2] & ctrl_valid_i;
        is_unsigned_sign_ext_reg[1] <= is_unsigned_sign_ext_reg[0];
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        load_mask_shift_reg[0] = 4'b0000;
        load_mask_shift_reg[1] = 4'b0000;
        load_mask_shift_reg[2] = 4'b0000;
    end
    else begin
        load_mask_shift_reg[0] = load_mask_shift_w;
        load_mask_shift_reg[1] = load_mask_shift_reg[0];
        load_mask_shift_reg[2] = load_mask_shift_reg[1];
    end
end

always_comb begin
    if (load_mask_shift_reg[2] == 4'b0000) begin
        load_mask_final_w = 32'b00000000_00000000_00000000_00000000;
    end 
    else if (load_mask_shift_reg[2] == 4'b0001) begin
        load_mask_final_w = 32'b00000000_00000000_00000000_11111111;
    end 
    else if (load_mask_shift_reg[2] == 4'b0011) begin
        load_mask_final_w = 32'b00000000_00000000_11111111_11111111;
    end 
    else begin
        load_mask_final_w = 32'b11111111_11111111_11111111_11111111;
    end 
end

sign_extender #(.N(DATA_WIDTH), .M(8)) sign_extender_byte(.in_i(data_mem_if.rdata[7:0] & 
                                                                load_mask_final_w[7:0]),
                                                          .out_o(byte_sign_extended_w));
sign_extender #(.N(DATA_WIDTH), .M(16)) sign_extender_halfword(.in_i(data_mem_if.rdata[15:0] & 
                                                                load_mask_final_w[15:0]),
                                                               .out_o(hword_sign_extended_w));

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
assign rf_wb_ro = wb_shift_reg[2];

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
        if (is_unsigned_sign_ext_reg[1] == 1'b1) begin
            rdata_ro <= data_mem_if.rdata & load_mask_final_w;
        end
        else begin
            if (load_mask_shift_reg[2] == 4'b0001) begin
                rdata_ro <= byte_sign_extended_w;
            end
            else if (load_mask_shift_reg[2] == 4'b0011) begin
                rdata_ro <= hword_sign_extended_w;
            end
            else begin
                rdata_ro <= data_mem_if.rdata & load_mask_final_w;
            end
        end
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

