////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_ifu                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The instruction fetch unit for SPROM memory with           //
//                 a single cycle read delay. The jmp_instr_i should only be  //
//                 asserted for a single clock cycle (for every jmp instr).   //
//                                                                            //
//                                      _________                             //
//                 ________             |       |                             //
//                 |       |<-----------| pc[0] |                             //
//                 |       |            |_______|                             //
//                 |  RAM  |                                                  //
//                 |       |            ____________        _________         //
//                 |       |            |          |        |       |         //
//                 |       |----------->| rdata_r  |------->|  M    |         //
//                 |_______|            |__________|  |     |  U    | instr_o //
//                                                    |     |  X    |-------> //
//                                    <_______________| |-->|       |         //
//                                   |                  |   |       |         //
//                           stalled_instr_save_reg,----| |>|_______|         //
//                           after_stall_instr_save_reg---|                   //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps

import jedro_1_defines::*;

module jedro_1_ifu 
(
  input logic clk_i,
  input logic rstn_i,

  input logic jmp_instr_i,     // Specifes that we encountered a jump instruction and the program 
                               // counter should be changed to jmp_address_i.
  
  input logic [DATA_WIDTH-1:0] jmp_address_i,    // The address to jump to, after we had encountered a jump instruction.

  // Interface to the decoder
  output logic [DATA_WIDTH-1:0] instr_o,         // The current instruction (to be decoded)
  output logic [DATA_WIDTH-1:0] instr_addr_ro,    // Used by instructons that calculate on the PC.
  output logic                  instr_valid_ro,
  input  logic                  decoder_ready_i, // Decoder ready to accept new instruction
  
  // Interface to the ROM memory
  ram_read_io.MASTER            instr_mem_if
);
localparam INSTR_SHIFTREG_DEPTH = 3;

logic [DATA_WIDTH-1:0] pc_shift_reg [INSTR_SHIFTREG_DEPTH-1:0];
logic [INSTR_SHIFTREG_DEPTH-1:0] instr_valid_shiftreg;

logic [DATA_WIDTH-1:0] rdata_r; // buffered output from RAM
logic [DATA_WIDTH-1:0] stall_instr_save_reg; // saves the instruciton causing the stall
logic [DATA_WIDTH-1:0] after_stall_instr_save_reg; // saves the instruction after the stall

logic stall_begin_pulse; // generates a pulse event on the clock cycle at which the stall happened
logic stall_end_pulse; // generates a pulse event on the clock ycle at which the stalling instr ended
logic prev_ready; // used to generate the stall_begin_pulse (ready low indicates stall)
logic is_first_cycle; // used to make sure no stall pullses are generated on reset.
logic process_after_stall_instr; // control signal that indicates the processing of the after stall instr

/***************************************
* PROGRAM COUNTER LOGIC and VALID LOGIC
***************************************/
assign instr_mem_if.addr = pc_shift_reg[0]; // The output address just follows pc_shift_reg[0]
assign instr_addr_ro = pc_shift_reg[INSTR_SHIFTREG_DEPTH-1];
assign instr_valid_ro = instr_valid_shiftreg[INSTR_SHIFTREG_DEPTH-1];

always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
     pc_shift_reg[0] <= BOOT_ADDR;
     pc_shift_reg[1] <= BOOT_ADDR;
     pc_shift_reg[2] <= BOOT_ADDR;
     instr_valid_shiftreg <= INSTR_SHIFTREG_DEPTH'('b001);
  end
  else begin
    if (jmp_instr_i == 1'b1) begin
        pc_shift_reg[0] <= jmp_address_i;
        pc_shift_reg[1] <= jmp_address_i;
        pc_shift_reg[2] <= jmp_address_i;
        instr_valid_shiftreg <= INSTR_SHIFTREG_DEPTH'('b001);
    end
    else if (decoder_ready_i == 1'b1 || instr_valid_shiftreg[2] == 1'b0) begin
        pc_shift_reg[0] <= pc_shift_reg[0] + 4;
        pc_shift_reg[1] <= pc_shift_reg[0];
        pc_shift_reg[2] <= pc_shift_reg[1];
        instr_valid_shiftreg <= instr_valid_shiftreg << 1;
        instr_valid_shiftreg[0] <= 1'b1;
    end
    else begin
        pc_shift_reg <= pc_shift_reg;
        instr_valid_shiftreg <= instr_valid_shiftreg;
    end
  end
end


/***************************************
* READING LOGIC
***************************************/
always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    rdata_r <= 32'b000000000001_00000_000_00000_0010011; // we reset to the NOP operation
  end
  else begin
    rdata_r <= instr_mem_if.rdata;
  end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        stall_instr_save_reg <= 32'b0;
    end
    else begin
        if (decoder_ready_i == 1'b1 || instr_valid_shiftreg[2] == 1'b0) begin
            stall_instr_save_reg <= rdata_r; 
        end
        else begin
            stall_instr_save_reg <= stall_instr_save_reg;
        end
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        after_stall_instr_save_reg <= 32'b0;
    end
    else begin
        if (stall_begin_pulse == 1'b1) begin
            after_stall_instr_save_reg <= rdata_r;
        end
        else begin
            after_stall_instr_save_reg <= after_stall_instr_save_reg;
        end
    end
end


/***************************************
* OUTPUT MUX and CONTROL LOGIC
***************************************/
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        prev_ready <= 1'b0;
    end
    else begin
        prev_ready <= decoder_ready_i;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        is_first_cycle <= 1'b1;
    end
    else begin
        is_first_cycle <= 1'b0;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        process_after_stall_instr <= 1'b0;
    end
    else begin
        if (stall_end_pulse == 1'b1) begin
            process_after_stall_instr <= 1'b1;
        end
        else if (instr_valid_ro == 1'b1 && decoder_ready_i == 1'b1) begin
            process_after_stall_instr <= 1'b0;
        end
        else begin
            process_after_stall_instr <= process_after_stall_instr;
        end
    end
end

assign stall_begin_pulse = prev_ready  & (~decoder_ready_i) & (~is_first_cycle) & instr_valid_ro;
assign stall_end_pulse = (~prev_ready) & decoder_ready_i & (~is_first_cycle) & instr_valid_ro;

always_comb 
begin
    if ( (process_after_stall_instr == 1'b0 && stall_end_pulse == 1'b1) ||
         (process_after_stall_instr == 1'b1 && ~(decoder_ready_i == 1'b1 && instr_valid_ro == 1'b1))
       ) 
    begin
        instr_o = after_stall_instr_save_reg;
    end
    else if (decoder_ready_i == 1'b0 && ~is_first_cycle) begin
        instr_o = stall_instr_save_reg;
    end
    else begin
        instr_o = rdata_r;
    end
end

endmodule : jedro_1_ifu
