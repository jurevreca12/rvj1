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
//                 a single cycle read delay.                                 //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

import jedro_1_defines::*;

`include "interfaces.sv"


module jedro_1_ifu 
(
  input clk_i,
  input rstn_i,

  input   get_next_instr_i, // A signal that specifys that we can get the next isntruction (controlled by the cores FSM)
  input   jmp_instr_i,      // specify that we encountered a jump instruction and the program counter should be changed to jmp_address_i
  
  // This address comes from the ALU (actually it comes from a mux after the ALU)
  input [DATA_WIDTH-1:0] jmp_address_i,   // The address to jump to, after we had encountered a jump instruction
  
  // Interface to the decoder
  output [DATA_WIDTH-1:0] cinstr_o,    // The current instruction (to be decoded)
  output                  cinstr_valid_o,
  
  // Interface to the ROM memory
  if_ram_1way.MASTER      if_instr_mem
);

logic [DATA_WIDTH-1:0] pc_r;
logic [DATA_WIDTH-1:0] cinstr_reg;
logic cinstr_valid_reg_0;
logic cinstr_valid_reg_1;
logic cinstr_valid_reg_2;

// The output address just follows pc_r
assign if_instr_mem.ram_addr = pc_r;
assign cinstr_valid_o = cinstr_valid_reg_2;

// Program Counter logic
always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    pc_r <= BOOT_ADDR;
    cinstr_valid_reg_0 <= 1'b0;
    cinstr_valid_reg_1 <= 1'b0;
    cinstr_valid_reg_2 <= 1'b0;
  end
  else begin
    cinstr_valid_reg_1 <= cinstr_valid_reg_0;
    cinstr_valid_reg_2 <= cinstr_valid_reg_1;

    // We change the program counter only when the get_next_instr_i signal is
    // aserted and the output on the cinstr_o bus is valid (for the previous
    // instruction).
    if (get_next_instr_i == 1'b1 & cinstr_valid_reg_0 == 1'b1) begin 
      if (jmp_instr_i == 1'b1) begin
        pc_r <= jmp_address_i;
        cinstr_valid_reg_0 <= 1'b0;
        cinstr_valid_reg_1 <= 1'b0;
        cinstr_valid_reg_2 <= 1'b0;
      end
      else begin 
        pc_r <= pc_r + 4;
      end
    end
    else begin
      cinstr_valid_reg_0 <= 1'b1;
    end
  end
end

// Reading logic
assign cinstr_o = cinstr_reg;

always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    cinstr_reg <= 32'b0;
  end
  else begin
    cinstr_reg <= if_instr_mem.ram_rdata;
  end
end

endmodule




