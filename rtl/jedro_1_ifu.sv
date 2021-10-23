////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_ifu                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The instruction fetch unit for SPROM memory with           //
//                 a single cycle read delay. The jmp_instr_i should only be  //
//                 asserted for a single clock cycle (for every jmp instr).   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

import jedro_1_defines::*;

`include "if_ram_1way.sv"


module jedro_1_ifu 
(
  input logic clk_i,
  input logic rstn_i,

  input logic get_next_instr_i, // A signal that specifys that we can get the next isntruction 
  input logic jmp_instr_i,      // specify that we encountered a jump instruction and the program 
                            // counter should be changed to jmp_address_i.
  
  input logic [DATA_WIDTH-1:0] jmp_address_i,   // The address to jump to, after we had encountered a jump instruction
  
  // Interface to the decoder
  output logic [DATA_WIDTH-1:0] cinstr_o,    // The current instruction (to be decoded)
  output logic                  cinstr_valid_o,
  
  // Interface to the ROM memory
  if_ram_1way.MASTER      if_instr_mem
);
localparam CINSTR_SHIFTREG_DEPTH = 2;

logic [DATA_WIDTH-1:0] pc_r;
logic [DATA_WIDTH-1:0] cinstr_reg;
logic [DATA_WIDTH-1:0] stall_save_reg;
logic after_stall; // are we one cycle after the stall happened?
logic [CINSTR_SHIFTREG_DEPTH-1:0] cinstr_valid_shiftreg;


// The output address just follows pc_r
assign if_instr_mem.ram_addr = pc_r;

always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    pc_r <= BOOT_ADDR;
  end
  else begin
    if (get_next_instr_i == 1'b1) begin 
      if (jmp_instr_i == 1'b1)
        pc_r <= jmp_address_i;
      else
        pc_r <= pc_r + 4;
    end
    else begin
      pc_r <= pc_r;
    end
  end
end

// VALID SIGNAL GENERATION
assign cinstr_valid_o = cinstr_valid_shiftreg[CINSTR_SHIFTREG_DEPTH-1];

always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    cinstr_valid_shiftreg <= CINSTR_SHIFTREG_DEPTH'('b00);
  end
  else begin
    if (get_next_instr_i == 1'b1) begin
        cinstr_valid_shiftreg <= cinstr_valid_shiftreg << 1;
        if (jmp_instr_i == 1'b1)
          cinstr_valid_shiftreg[0] <= 1'b0;
        else
          cinstr_valid_shiftreg[0] <= 1'b1;
    end
    else begin
      cinstr_valid_shiftreg <= cinstr_valid_shiftreg;
    end
  end
end

// READING LOGIC
assign cinstr_o = cinstr_reg;

always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    cinstr_reg <= 32'b000000000001_00000_000_00000_0010011; // we reset to the NOP operationi
  end
  else begin
    if (get_next_instr_i == 1'b1 && cinstr_valid_shiftreg[0] == 1'b1) begin
        if (after_stall == 1'b0) begin
            cinstr_reg <= if_instr_mem.ram_rdata;
        end
        else begin
            cinstr_reg <= stall_save_reg;
        end
    end
    else begin
        cinstr_reg <= cinstr_reg;
    end
  end
end

// STALL SAVE LOGIC
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        stall_save_reg <= 32'b000000000001_00000_000_00000_0010011;
    end
    else begin
        stall_save_reg <= if_instr_mem.ram_rdata;
    end
end

// After stall signal
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        after_stall <= 1'b0;
    end
    else begin
        if (get_next_instr_i == 1'b0) begin
            after_stall <= 1'b1;
        end
        else begin
            after_stall <= 1'b0;
        end
    end
end

endmodule : jedro_1_ifu
