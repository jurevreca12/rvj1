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
  input  logic [REG_ADDR_WIDTH-1:0] regdest_i,     // Writeback to which register?
 
  // Interface to the register file
  output logic [DATA_WIDTH-1:0]     rdata_ro,       // Goes to the register file.
  output logic                      rf_wb_ro,       // Enables the write pin of the reg file.
  output logic [REG_ADDR_WIDTH-1:0] regdest_ro,

  output logic                      misaligned_load_ro,
  output logic                      misaligned_store_ro,
  output logic [DATA_WIDTH-1:0]     misaligned_addr_ro,

  // Interface to data RAM
  ram_rw_io.MASTER                  data_mem_if
);

localparam READ_CYCLE_DELAY = 3;

logic [DATA_WIDTH-1:0]     data_r; // stores unaligned data directly from memory
logic [DATA_WIDTH-1:0]     byte_sign_extended_w;
logic [DATA_WIDTH-1:0]     hword_sign_extended_w;
logic                      read_enable;
logic [7:0]                active_byte;
logic [15:0]               active_hword;
logic [1:0]                byte_addr_r;
logic                      ram_start_decode_r;
logic [LSU_CTRL_WIDTH-1:0] ctrl_save_r;

logic [31:0]               active_write_word;

logic                      misaligned_load;
logic                      misaligned_store;


/**************************************
* EXCEPTION CHECKING
**************************************/
always_comb begin
    if (ctrl_valid_i == 1'b1) begin
        misaligned_load  = 1'b0;
        misaligned_store = 1'b0;
        unique casez (ctrl_i)
            LSU_LOAD_BYTE        : misaligned_load = 1'b0;
            LSU_LOAD_BYTE_U      : misaligned_load = 1'b0;
            LSU_LOAD_HALF_WORD   : misaligned_load = addr_i[0];
            LSU_LOAD_HALF_WORD_U : misaligned_load = addr_i[0];
            LSU_LOAD_WORD        : misaligned_load = |addr_i[1:0];
            LSU_STORE_BYTE       : misaligned_store = 1'b0;
            LSU_STORE_HALF_WORD  : misaligned_store = addr_i[0];
            LSU_STORE_WORD       : misaligned_store = |addr_i[1:0];
        endcase
    end
    else begin
        misaligned_load  = 1'b0;
        misaligned_store = 1'b0;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        misaligned_load_ro  <= 1'b0;
        misaligned_store_ro <= 1'b0;
    end
    else begin
        misaligned_load_ro  <= misaligned_load;
        misaligned_store_ro <= misaligned_store;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        misaligned_addr_ro <= 0;
    end
    else begin
        if (ctrl_valid_i)   misaligned_addr_ro <= addr_i;
        else                misaligned_addr_ro <= misaligned_addr_ro;
    end
end

/**************************************
* WRITE ENABLE SIGNAL / INPUT MUXING
**************************************/
logic is_write; // Is the current ctrl input a write
logic [DATA_WIDTH/8 - 1:0] we; // write enable signal

assign is_write = ctrl_i[LSU_CTRL_WIDTH-1];

always_comb begin
    active_write_word = 0;
    if (is_write == 1'b1) begin
        if      (ctrl_i == LSU_STORE_BYTE) begin
            if      (addr_i[1:0] == 2'b00) begin      
                active_write_word = {24'b0, wdata_i[7:0]};
                we = 4'b0001;
            end
            else if (addr_i[1:0] == 2'b01) begin
                active_write_word = {16'b0, wdata_i[7:0], 8'b0};
                we = 4'b0010;
            end
            else if (addr_i[1:0] == 2'b10) begin
                active_write_word = {8'b0, wdata_i[7:0], 16'b0};
                we = 4'b0100;
            end
            else begin
                active_write_word = {wdata_i[7:0], 24'b0};
                we = 4'b1000;
            end
        end
        else if (ctrl_i == LSU_STORE_HALF_WORD) begin
            if (addr_i[1:0] == 2'b00) begin
                active_write_word = {16'b0, wdata_i[15:0]};
                we = 4'b0011; 
            end
            else begin
                active_write_word = {wdata_i[15:0], 16'b0};
                we = 4'b1100; 
            end
        end
        else begin
            active_write_word = wdata_i;
            we = 4'b1111;
        end
    end
    else begin
        we = 4'b0000;
    end
end


/**************************************
* CONTROL SAVE
**************************************/
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        ctrl_save_r <= 0;
    end
    else begin
        if (ctrl_valid_i == 1'b1)
            ctrl_save_r <= ctrl_i;
        else
            ctrl_save_r <= ctrl_save_r;
    end
end


/**************************************
* REGDEST
**************************************/
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        regdest_ro <= 0;
    end
    else begin
        regdest_ro <= regdest_i;
    end
end


/**************************************
* READ_ENABLE / REGISTER WRITEBACK / BYTE_ADDR
**************************************/
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        ram_start_decode_r <= 1'b0;
    end
    else begin
        if (ctrl_valid_i == 1'b1 && 
            is_write == 1'b0 && 
            read_enable == 1'b0 &&
            misaligned_load == 1'b0) 
            ram_start_decode_r <= 1'b1;
        else
            ram_start_decode_r <= 1'b0;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        read_enable <= 1'b0;
    end
    else begin
        read_enable <= ram_start_decode_r;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        rf_wb_ro <= 0;
    end
    else begin
        rf_wb_ro <= read_enable;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        byte_addr_r <= 2'b00;
    end
    else begin
        if (ctrl_valid_i == 1'b1 && is_write == 1'b0 && read_enable == 1'b0) 
            byte_addr_r <= addr_i[1:0];
        else
            byte_addr_r <= byte_addr_r;
    end
end


/**************************************
* HANDLE MEM INTERFACE
**************************************/
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        data_r <= 0;
    end
    else begin
        if (read_enable == 1'b1)
            data_r <= data_mem_if.rdata;
        else
            data_r <= data_r;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
       data_mem_if.addr <= 0;
       data_mem_if.we <= 0;
       data_mem_if.wdata <= 0; 
    end
    else begin
       data_mem_if.addr  <= addr_i;
       data_mem_if.we    <= we & {4{ctrl_valid_i&(~misaligned_store)}};
       data_mem_if.wdata <= active_write_word;
       data_mem_if.stb   <= ctrl_valid_i; 
    end
end


/**************************************
* RESULT MUXING
**************************************/
always_comb begin
    active_byte  = 8'b00000000;
    active_hword = 16'b00000000_00000000;
    if (ctrl_save_r == LSU_LOAD_BYTE ||
        ctrl_save_r == LSU_LOAD_BYTE_U) begin
        if      (byte_addr_r == 2'b00) 
            active_byte = data_r[7:0];
        else if (byte_addr_r == 2'b01)
            active_byte = data_r[15:8];
        else if (byte_addr_r == 2'b10)
            active_byte = data_r[23:16];
        else
            active_byte = data_r[31:24];
    end
    else if (ctrl_save_r == LSU_LOAD_HALF_WORD ||
             ctrl_save_r == LSU_LOAD_HALF_WORD_U) begin
        if (byte_addr_r == 2'b00)
            active_hword = data_r[15:0];
        else 
            active_hword = data_r[31:16];
    end
end

sign_extender #(.N(DATA_WIDTH), .M(8)) sign_extender_byte(.in_i(active_byte),
                                                          .out_o(byte_sign_extended_w));
sign_extender #(.N(DATA_WIDTH), .M(16)) sign_extender_halfword(.in_i(active_hword),
                                                               .out_o(hword_sign_extended_w));

always_comb begin
    if (is_write == 1'b1) begin
        rdata_ro = 0;
    end 
    else begin
        rdata_ro = 0;
        unique casez (ctrl_save_r)
            LSU_LOAD_BYTE:        rdata_ro = byte_sign_extended_w;
            LSU_LOAD_BYTE_U:      rdata_ro = {24'b0, active_byte};
            LSU_LOAD_HALF_WORD:   rdata_ro = hword_sign_extended_w;
            LSU_LOAD_HALF_WORD_U: rdata_ro = {16'b0, active_hword};
            LSU_LOAD_WORD:        rdata_ro = data_r;
            default:              rdata_ro = 0;
        endcase
    end
end


endmodule : jedro_1_lsu

