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

module jedro_1_lsu (
    input logic clk_i,
    input logic rstn_i,

    // Interface to/from the decoder/ALU
    input logic                      ctrl_valid_i,
    input logic [LSU_CTRL_WIDTH-1:0] ctrl_i,
    input logic [    DATA_WIDTH-1:0] addr_i,        // Address of the memory to ready/write.
    input logic [    DATA_WIDTH-1:0] wdata_i,       // The data to write to memory.
    input logic [REG_ADDR_WIDTH-1:0] regdest_i,     // Writeback to which register?

    // Interface to the register file
    output logic [    DATA_WIDTH-1:0] rdata_ro,   // Goes to the register file.
    output logic                      rf_wb_ro,   // Enables the write pin of the logic file.
    output logic [REG_ADDR_WIDTH-1:0] regdest_ro,

    output logic                  misaligned_load_ro,
    output logic                  misaligned_store_ro,
    output logic                  bus_error_ro,
    output logic [DATA_WIDTH-1:0] exception_addr_ro,

    // Interface to data RAM
    output logic [DATA_WIDTH-1:0] data_req_addr_o,
    output logic [DATA_WIDTH-1:0] data_req_data_o,
    output logic [3:0]            data_req_strobe_o,
    output logic                  data_req_write_o,
    output logic                  data_req_valid_o,
    input  logic                  data_req_ready_i,

    input  logic [DATA_WIDTH-1:0] data_rsp_data_i,
    input  logic                  data_rsp_err_i,
    input  logic                  data_rsp_valid_i,
    output logic                  data_rsp_ready_o
);

  logic ram_ack;
  assign ram_ack = data_rsp_valid_i;

  logic [    DATA_WIDTH-1:0] data_r;  // stores unaligned data directly from memory
  logic [    DATA_WIDTH-1:0] byte_sign_extended_w;
  logic [    DATA_WIDTH-1:0] hword_sign_extended_w;
  logic [               7:0] active_byte;
  logic [              15:0] active_hword;
  logic [               1:0] byte_addr_r;
  logic                      ram_start_decode_r;
  logic [LSU_CTRL_WIDTH-1:0] ctrl_save_r;

  logic [              31:0] active_write_word;

  logic                      misaligned_load;
  logic                      misaligned_load_hold;
  logic                      misaligned_store;


  /**************************************
  * EXCEPTION CHECKING
  **************************************/
  always_comb begin
    if (ctrl_valid_i == 1'b1) begin
      misaligned_load  = 1'b0;
      misaligned_store = 1'b0;
      unique casez (ctrl_i)
        LSU_LOAD_BYTE:        misaligned_load = 1'b0;
        LSU_LOAD_BYTE_U:      misaligned_load = 1'b0;
        LSU_LOAD_HALF_WORD:   misaligned_load = addr_i[0];
        LSU_LOAD_HALF_WORD_U: misaligned_load = addr_i[0];
        LSU_LOAD_WORD:        misaligned_load = |addr_i[1:0];
        LSU_STORE_BYTE:       misaligned_store = 1'b0;
        LSU_STORE_HALF_WORD:  misaligned_store = addr_i[0];
        LSU_STORE_WORD:       misaligned_store = |addr_i[1:0];
      endcase
    end else begin
      misaligned_load  = 1'b0;
      misaligned_store = 1'b0;
    end
  end

  // Generate signals for the control (csr) unit
  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
      misaligned_load_ro  <= 1'b0;
      misaligned_store_ro <= 1'b0;
    end else begin
      misaligned_load_ro  <= misaligned_load;
      misaligned_store_ro <= misaligned_store;
    end
  end

  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
      misaligned_load_hold <= 0;
    end else begin
      if (ctrl_valid_i) misaligned_load_hold <= misaligned_load;
      else misaligned_load_hold <= misaligned_load_hold;
    end
  end

  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
      exception_addr_ro <= 0;
    end else begin
      if (ctrl_valid_i) exception_addr_ro <= addr_i;
      else exception_addr_ro <= exception_addr_ro;
    end
  end


  /**************************************
  * WRITE ENABLE SIGNAL / INPUT MUXING
  **************************************/
  logic is_write;  // Is the current ctrl input a write
  logic is_write_hold;
  logic [DATA_WIDTH/8 - 1:0] we;  // write enable signal

  assign is_write = ctrl_i[LSU_CTRL_WIDTH-1];

  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) is_write_hold <= 0;
    else begin
      if (ctrl_valid_i) is_write_hold <= is_write;
      else is_write_hold <= is_write_hold;
    end
  end

  always_comb begin
    active_write_word = 0;
    if (is_write == 1'b1) begin
      if (ctrl_i == LSU_STORE_BYTE) begin
        if (addr_i[1:0] == 2'b00) begin
          active_write_word = {24'b0, wdata_i[7:0]};
          we = 4'b0001;
        end else if (addr_i[1:0] == 2'b01) begin
          active_write_word = {16'b0, wdata_i[7:0], 8'b0};
          we = 4'b0010;
        end else if (addr_i[1:0] == 2'b10) begin
          active_write_word = {8'b0, wdata_i[7:0], 16'b0};
          we = 4'b0100;
        end else begin
          active_write_word = {wdata_i[7:0], 24'b0};
          we = 4'b1000;
        end
      end else if (ctrl_i == LSU_STORE_HALF_WORD) begin
        if (addr_i[1:0] == 2'b00) begin
          active_write_word = {16'b0, wdata_i[15:0]};
          we = 4'b0011;
        end else begin
          active_write_word = {wdata_i[15:0], 16'b0};
          we = 4'b1100;
        end
      end else begin
        active_write_word = wdata_i;
        we = 4'b1111;
      end
    end else begin
      we = 4'b0000;
    end
  end


  /**************************************
  * CONTROL SAVE
  **************************************/
  // We save the control information so we can
  // use it in later cycles.
  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
      ctrl_save_r <= 0;
    end else begin
      if (ctrl_valid_i == 1'b1) ctrl_save_r <= ctrl_i;
      else ctrl_save_r <= ctrl_save_r;
    end
  end


  /**************************************
* REGDEST
**************************************/
  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
      regdest_ro <= 0;
    end else begin
      regdest_ro <= regdest_i;
    end
  end


  /**************************************
  * BYTE_ADDR
  **************************************/
  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
      byte_addr_r <= 2'b00;
    end else begin
      if (ctrl_valid_i & (~is_write)) byte_addr_r <= addr_i[1:0];
      else byte_addr_r <= byte_addr_r;
    end
  end


  /**************************************
  * HANDLE MEM INTERFACE
  **************************************/
  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
      data_r <= 0;
    end else begin
      if (ram_ack & (~is_write_hold)) data_r <= data_rsp_data_i;
      else data_r <= data_r;
    end
  end

  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
      data_req_addr_o <= 0;
      data_req_strobe_o <= 0;
      data_req_data_o <= 0;
      data_req_valid_o <= 0;
    end else begin
      data_req_addr_o  <= addr_i;
      data_req_strobe_o <= we & {4{ctrl_valid_i&(~misaligned_store)}};
      data_req_write_o <= |we;
      data_req_data_o <= active_write_word;
      data_req_valid_o   <= ctrl_valid_i;
    end
  end


  /**************************************
  * RESULT MUXING
  **************************************/
  always_comb begin
    active_byte  = 8'b00000000;
    active_hword = 16'b00000000_00000000;
    if (ctrl_save_r == LSU_LOAD_BYTE || ctrl_save_r == LSU_LOAD_BYTE_U) begin
      if (byte_addr_r == 2'b00) active_byte = data_r[7:0];
      else if (byte_addr_r == 2'b01) active_byte = data_r[15:8];
      else if (byte_addr_r == 2'b10) active_byte = data_r[23:16];
      else active_byte = data_r[31:24];
    end else if (ctrl_save_r == LSU_LOAD_HALF_WORD || ctrl_save_r == LSU_LOAD_HALF_WORD_U) begin
      if (byte_addr_r == 2'b00) active_hword = data_r[15:0];
      else active_hword = data_r[31:16];
    end
  end

  sign_extender #(
      .N(DATA_WIDTH),
      .M(8)
  ) sign_extender_byte (
      .in_i (active_byte),
      .out_o(byte_sign_extended_w)
  );
  sign_extender #(
      .N(DATA_WIDTH),
      .M(16)
  ) sign_extender_halfword (
      .in_i (active_hword),
      .out_o(hword_sign_extended_w)
  );

  always_comb begin
    if (is_write == 1'b1) begin
      rdata_ro = 0;
    end else begin
      rdata_ro = 0;
      casez (ctrl_save_r)
        LSU_LOAD_BYTE:        rdata_ro = byte_sign_extended_w;
        LSU_LOAD_BYTE_U:      rdata_ro = {24'b0, active_byte};
        LSU_LOAD_HALF_WORD:   rdata_ro = hword_sign_extended_w;
        LSU_LOAD_HALF_WORD_U: rdata_ro = {16'b0, active_hword};
        LSU_LOAD_WORD:        rdata_ro = data_r;
        default:              rdata_ro = 0;
      endcase
    end
  end


  /**************************************
  * WRITEBACK & BUS ERRORS
  **************************************/
  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) rf_wb_ro <= 0;
    else rf_wb_ro <= ram_ack & (~is_write_hold) & (~misaligned_load_hold);
  end

  always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) bus_error_ro <= 0;
    else bus_error_ro <= data_rsp_err_i;
  end


endmodule

