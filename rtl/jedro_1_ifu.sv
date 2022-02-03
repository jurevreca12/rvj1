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
//                 |       | dout       |          |        |       |         //
//                 |       |----------->| dout_r   |------->|  M    |         //
//                 |_______|            |__________|  |     |  U    | instr_o //
//                                                    |     |  X    |-------> //
//                                    <_______________| |-->|       |         //
//                                   |                  |   |       |         //
//                          stall_r, after_stall_r_0/1  |-->|_______|         //
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
  output logic [DATA_WIDTH-1:0] instr_o,     // The current instruction (to be decoded)
  output logic [DATA_WIDTH-1:0] addr_o,      // Used by instructons that calculate on the PC.
  output logic                  valid_o,
  input  logic                  ready_i,     // Decoder ready to accept new instruction
  
  // Interface to the ROM memory
  ram_read_io.MASTER            instr_mem_if
);
localparam INSTR_SHIFTREG_DEPTH = 3;

typedef enum logic [4:0] {NV = 5'b00001, 
                          DV = 5'b00010,
                          S0 = 5'b00100,
                          S1 = 5'b01000,
                          S2 = 5'b10000,
                          XXX= 'x      } state_e;

typedef struct packed {
   logic [DATA_WIDTH-1:0] instr;
   logic [DATA_WIDTH-1:0] addr; 
} instr_addr_pair_t;

state_e state, next;

logic [DATA_WIDTH-1:0] pc_shift_r [INSTR_SHIFTREG_DEPTH-1:0];
logic [INSTR_SHIFTREG_DEPTH-1:0] instr_valid_shift_r;

instr_addr_pair_t out;     // the final muxed output (it gets comb assigned to instr_o and addr_o)
instr_addr_pair_t dout_r;  // buffered output from RAM
instr_addr_pair_t stall_r; // saves the instruciton causing the stall
instr_addr_pair_t after_stall_r0; // saves the first instruction after the stall
instr_addr_pair_t after_stall_r1; // saves the second instruction after the stall

logic stall_begin_pulse;   // generates a pulse event on the clock cycle at which the stall happened
logic stall_begin_pulse_r; // a pulse event one clock cycle later then the stall_begin_pulse
logic prev_ready;          // used to generate the stall_begin_pulse (ready low indicates stall)

logic stall_in_stall;       // an OR combination of stall_in_stall_r and stall_in_stall_pulse
logic stall_in_stall_r;     // gets set when stall_in_stall_pulse is 1, and gets deasserted when state=DV
logic stall_in_stall_pulse; // when a stall occurs when state!=DV then this gets triggered combinatorialy

/***************************************
* PROGRAM COUNTER LOGIC and VALID LOGIC
***************************************/
assign instr_mem_if.addr = pc_shift_r[0]; // The output address just follows pc_shift_r[0]

always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
     pc_shift_r[0] <= BOOT_ADDR;
     pc_shift_r[1] <= BOOT_ADDR;
     pc_shift_r[2] <= BOOT_ADDR;
     instr_valid_shift_r <= INSTR_SHIFTREG_DEPTH'('b001);
  end
  else begin
    if (jmp_instr_i == 1'b1) begin
        pc_shift_r[0] <= jmp_address_i;
        pc_shift_r[1] <= jmp_address_i;
        pc_shift_r[2] <= jmp_address_i;
        instr_valid_shift_r <= INSTR_SHIFTREG_DEPTH'('b001);
    end
    else if (stall_in_stall_pulse == 1'b1) begin
        pc_shift_r[0] <= pc_shift_r[1];
        pc_shift_r[1] <= pc_shift_r[1];
        pc_shift_r[2] <= pc_shift_r[1];
        instr_valid_shift_r <= INSTR_SHIFTREG_DEPTH'('b001);
    end
    else if ((stall_in_stall_r == 1'b1) ||
             (stall_in_stall_r == 1'b0 && ready_i == 1'b0)) begin
        pc_shift_r <= pc_shift_r;
        instr_valid_shift_r <= instr_valid_shift_r;
    end
    else begin
        pc_shift_r[0] <= pc_shift_r[0] + 4;
        pc_shift_r[1] <= pc_shift_r[0];
        pc_shift_r[2] <= pc_shift_r[1];
        instr_valid_shift_r <= instr_valid_shift_r << 1;
        instr_valid_shift_r[0] <= 1'b1;
    end
  end
end


/***************************************
* READING LOGIC
***************************************/
always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    dout_r <= {NOP_INSTR, 32'b0}; // we reset to the NOP operation
  end
  else begin
    dout_r <= {instr_mem_if.rdata, pc_shift_r[2]};
  end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        stall_r <= 0;
    end
    else begin
        if (ready_i == 1'b1) begin
            stall_r <= dout_r; 
        end
        else begin
            stall_r <= stall_r;
        end
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        after_stall_r0 <= 0;
    end
    else begin
        if (stall_begin_pulse == 1'b1 && state == DV) begin
            after_stall_r0 <= dout_r;
        end
        else begin
            after_stall_r0 <= after_stall_r0;
        end
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        after_stall_r1 <= 0;
    end
    else begin
        if (stall_begin_pulse_r == 1'b1 && state == S0) begin
            after_stall_r1 <= dout_r;
        end
        else begin
            after_stall_r1 <= after_stall_r1;
        end
    end
end


/***************************************
* CONTROL LOGIC 
***************************************/
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        prev_ready <= 1'b0;
    end
    else begin
        prev_ready <= ready_i;
    end
end

assign stall_begin_pulse = prev_ready  & (~ready_i) & valid_o;
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        stall_begin_pulse_r <= 1'b0;
    end
    else begin
        stall_begin_pulse_r <= stall_begin_pulse;
    end
end

assign stall_in_stall = stall_in_stall_r || stall_in_stall_pulse;
assign stall_in_stall_pulse = prev_ready & (~ready_i) & (state == S1 || state == S2);
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        stall_in_stall_r <= 0;
    end
    else begin
        if (stall_in_stall_pulse == 1'b1) stall_in_stall_r <= 1'b1;
        else if (next == NV)              stall_in_stall_r <= 1'b0;
        else                              stall_in_stall_r <= stall_in_stall_r;
    end
end

/***************************************
* FINITE STATE MACHINE/OUTPUT MUXING
***************************************/
assign instr_o = out.instr;
assign addr_o  = out.addr;

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) state <= NV;
    else                state <= next;
end

always_comb begin
    next = XXX;
    case (state)
        NV : if (instr_valid_shift_r[1] == 1'b1) next = DV;
             else                                next = NV;

        DV : if (jmp_instr_i == 1'b1)            next = NV;
             else if (ready_i == 1'b1)           next = DV;
             else                                next = S0;
                
        S0 : if (jmp_instr_i == 1'b1)            next = NV;
             else if (ready_i == 1'b0)           next = S0;
             else                                next = S1;

        S1 : if (jmp_instr_i == 1'b1)            next = NV;
             else if (ready_i == 1'b0)           next = S1;
             else                                next = S2;

        S2 : if (jmp_instr_i == 1'b1)            next = NV;
             else if (ready_i == 1'b0)           next = S2;
             else if (ready_i == 1'b1 && 
                      stall_in_stall == 1'b1)    next = NV;
             else                                next = DV;
        
        default :                                next = XXX;
    endcase 
end

always_comb begin
    out  = {NOP_INSTR, 32'b0};
    case (state)
        NV:                         out = {NOP_INSTR, 32'b0};

        DV: if (ready_i == 1'b1)    out = dout_r;
            else                    out = stall_r;

        S0: if (ready_i == 1'b0)    out = stall_r;
            else                    out = after_stall_r0;

        S1: if (ready_i == 1'b0)    out = after_stall_r0;
            else                    out = after_stall_r1;

        S2: if (ready_i == 1'b0)    out = after_stall_r1;
            else                    out = dout_r;

        default:                    out = {'x, 'x};
    endcase
end

always_comb begin
    if (state == NV || jmp_instr_i == 1'b1) valid_o = 1'b0;
    else                                    valid_o = 1'b1;
end

endmodule : jedro_1_ifu
