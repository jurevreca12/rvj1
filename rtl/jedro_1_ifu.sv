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
  
  // Interface to the ROM memory
  if_ram_1way.MASTER      if_instr_mem
);

logic [DATA_WIDTH-1:0] pc_r;
logic [DATA_WIDTH-1:0] cinstr_reg;
logic clock_cnt;

// COMBINATIAL LOGIC

// The output address just follows pc_r
assign if_instr_mem.ram_addr = pc_r;


// SEQUENTIAL LOGIC

// Program Counter logic
always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    pc_r <= BOOT_ADDR;
  end
  else begin
    if (get_next_instr_i == 1'b1 & clock_cnt == 1'b0) begin 
      if (jmp_instr_i == 1'b1) begin
        pc_r <= jmp_address_i;
      end
      else begin
        pc_r <= pc_r + 4;
      end 
    end
  end
end

assign cinstr_o = cinstr_reg;

always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    cinstr_reg <= 0;
  end
  else begin
    cinstr_reg <= clock_cnt ? cinstr_reg : if_instr_mem.ram_rdata;
  end
end

// Handle the instruction memory interface
always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    clock_cnt <= 0; 
  end
  else begin
    clock_cnt <= ~clock_cnt;  // We count only to one, hence the negation.  
  end 
end

endmodule




