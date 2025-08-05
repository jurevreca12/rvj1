////////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                             //
//                                                                                //
//                                                                                //
//                                                                                //
// Design Name:    jedro_1_ifu                                                    //
// Project Name:   riscv-jedro-1                                                  //
// Language:       System Verilog                                                 //
//                                                                                //
// Description:    The instruction fetch unit for SPROM memory with               //
//                 a single cycle read delay. The jmp_addr_valid_i should only    //
//                 be asserted for a single clock cycle (for every jmp instr).    //
//                                                                                //
//                                      _________                                 //
//                 ________             |       |                                 //
//                 |       |<-----------| pc[0] |                                 //
//                 |       |            |_______|                                 //
//                 |  RAM  |                                                      //
//                 |       |            ____________        _________             //
//                 |       | dout       |          |        |       |             //
//                 |       |----------->| dout_r   |------->|  M    |             //
//                 |_______|            |__________|  |     |  U    | dec_instr_o //
//                                                    |     |  X    |------->     //
//                                    <_______________| |-->|       |             //
//                                   |                  |   |       |             //
//                          stall_r, after_stall_r_0/1  |-->|_______|             //
//                                                                                //
//                                                                                //
//                                                                                //
//                                                                                //
//                                                                                //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////

import jedro_1_defines::*;

module jedro_1_ifu #(
    parameter bit [31:0] BOOT_ADDR = 32'h8000_0000
)
(
  input logic clk_i,
  input logic rstn_i,

  // Interface to the ROM memory
  //output logic [DATA_WIDTH-1:0]  ram_addr,
  //input logic  [DATA_WIDTH-1:0]  ram_rdata,

  // Instruction memory interface
  output logic                  instr_req_o,
  input  logic                  instr_gnt_i,
  input  logic                  instr_rvalid_i,
  output logic [DATA_WIDTH-1:0] instr_addr_o,
  input  logic [DATA_WIDTH-1:0] instr_rdata_i,
  input  logic                  instr_err_i,

  // Interface to the decoder
  output logic [DATA_WIDTH-1:0] dec_instr_o,    // The current instruction (to be decoded)
  output logic [DATA_WIDTH-1:0] dec_pc_o,       // Used by instructons that calculate on the PC.
  output logic                  dec_valid_o,
  input  logic                  dec_ready_i,    // Decoder ready to accept new instruction

  input logic jmp_addr_valid_i,     // change PC to jmp_addr_i
  input logic [DATA_WIDTH-1:0] jmp_addr_i,    // The jump address

  output logic                  exception_ro,  // Signal isntr misaligned exception
  output logic [DATA_WIDTH-1:0] fault_addr_ro // the address that caused the misaligned exception
);

localparam int InstrShiftregDepth = 3;
localparam bit [5:0] NV  = 6'b000001;
localparam bit [5:0] DV  = 6'b000010;
localparam bit [5:0] S0  = 6'b000100;
localparam bit [5:0] S1  = 6'b001000;
localparam bit [5:0] S2  = 6'b010000;
localparam bit [5:0] EX  = 6'b100000;
localparam bit [5:0] XXX = 6'b000000;

logic [5:0] state, next;


logic [DATA_WIDTH-1:0] pc_shift_r0;
logic [DATA_WIDTH-1:0] pc_shift_r1;
logic [DATA_WIDTH-1:0] pc_shift_r2;
logic [InstrShiftregDepth-1:0] instr_valid_shift_r;

logic [DATA_WIDTH-1:0] out_instr; // the final muxed output
logic [DATA_WIDTH-1:0] out_addr;

logic [DATA_WIDTH-1:0] dout_r_instr;  // buffered output from RAM
logic [DATA_WIDTH-1:0] dout_r_addr;

logic [DATA_WIDTH-1:0] dout_r_instr_d; // saves the instruciton causing the stall
logic [DATA_WIDTH-1:0] dout_r_addr_d;
logic [DATA_WIDTH-1:0] dout_r_instr_d2; // saves the first instruction after the stall
logic [DATA_WIDTH-1:0] dout_r_addr_d2;
logic [DATA_WIDTH-1:0] dout_r_instr_d3; // saves the second instruction after the stall
logic [DATA_WIDTH-1:0] dout_r_addr_d3;

logic stall_begin_pulse;   // generates a pulse event on the clock cycle at which the stall happened
logic  stall_begin_pulse_r; // a pulse event one clock cycle later then the stall_begin_pulse
logic  prev_ready;          // used to generate the stall_begin_pulse (ready low indicates stall)

logic stall_in_stall;       // an OR combination of stall_in_stall_r and stall_in_stall_pulse
logic stall_in_stall_r;     // set when stall_in_stall_pulse is 1, and deasserted when state=DV
logic stall_in_stall_pulse; // when a stall occurs when state!=DV then  triggered
logic  [DATA_WIDTH-1:0] after_stall_addr;  // address to continue from if stall_in_stall event

logic jmp_instr; // this signal filters incorrect jumps
logic is_exception;

/***************************************
* MISALIGNED JUMPS EXCEPTION GENERATION
***************************************/
always_comb begin
    if (jmp_addr_valid_i == 1'b1) begin
        if (jmp_addr_i[1:0] == 2'b00) begin
            jmp_instr = 1'b1;
            is_exception = 1'b0;
        end
        else begin
            jmp_instr = 1'b0;
            is_exception = 1'b1;
        end
    end
    else begin
        jmp_instr = 1'b0;
        is_exception = 1'b0;
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        exception_ro <= 0;
        fault_addr_ro <= 0;
    end
    else begin
        exception_ro <= is_exception;
        fault_addr_ro <= jmp_addr_i;
    end
end

/***************************************
* PROGRAM COUNTER LOGIC and VALID LOGIC
***************************************/
assign instr_addr_o = pc_shift_r0; // The output address just follows pc_shift_r0

always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
     pc_shift_r0 <= BOOT_ADDR;
     pc_shift_r1 <= BOOT_ADDR;
     pc_shift_r2 <= BOOT_ADDR;
     instr_valid_shift_r <= 3'b001;
  end
  else begin
    if (jmp_instr == 1'b1) begin
        pc_shift_r0 <= jmp_addr_i;
        pc_shift_r1 <= jmp_addr_i;
        pc_shift_r2 <= jmp_addr_i;
        instr_valid_shift_r <= 3'b001;
    end
    else if (stall_in_stall_pulse == 1'b1) begin
        pc_shift_r0 <= after_stall_addr;
        pc_shift_r1 <= after_stall_addr;
        pc_shift_r2 <= after_stall_addr;
        instr_valid_shift_r <= 3'b001;
    end
    else if ((stall_in_stall_r == 1'b1) ||
             (stall_in_stall_r == 1'b0 && dec_ready_i == 1'b0)) begin
        pc_shift_r0 <= pc_shift_r0;
        pc_shift_r1 <= pc_shift_r1;
        pc_shift_r2 <= pc_shift_r2;
        instr_valid_shift_r <= instr_valid_shift_r;
    end
    else begin
        pc_shift_r0 <= pc_shift_r0 + 4;
        pc_shift_r1 <= pc_shift_r0;
        pc_shift_r2 <= pc_shift_r1;
        instr_valid_shift_r <= instr_valid_shift_r << 1;
        instr_valid_shift_r[0] <= 1'b1;
    end
  end
end
assign instr_req_o = 1'b1;

/***************************************
* READING LOGIC
***************************************/
always_ff @(posedge clk_i) begin
  if (rstn_i == 1'b0) begin
    {dout_r_instr, dout_r_addr} <= {NOP_INSTR, 32'b0}; // we reset to the NOP operation
  end
  else begin
    {dout_r_instr, dout_r_addr} <= {instr_rdata_i, pc_shift_r1};
  end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        {dout_r_instr_d, dout_r_addr_d} <= {32'b0, 32'b0};
    end
    else begin
        if (dec_ready_i == 1'b1) begin
            {dout_r_instr_d, dout_r_addr_d} <= {dout_r_instr, dout_r_addr};
        end
        else begin
            {dout_r_instr_d, dout_r_addr_d} <= {dout_r_instr_d, dout_r_addr_d};
        end
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        {dout_r_instr_d2, dout_r_addr_d2} <= 0;
    end
    else begin
        if (stall_begin_pulse == 1'b1 && state == DV) begin
            {dout_r_instr_d2, dout_r_addr_d2} <= {dout_r_instr, dout_r_addr};
        end
        else begin
            {dout_r_instr_d2, dout_r_addr_d2} <= {
                dout_r_instr_d2,dout_r_addr_d2
            };
        end
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        {dout_r_instr_d3, dout_r_addr_d3} <= {32'b0, 32'b0};
    end
    else begin
        if (stall_begin_pulse_r == 1'b1 && state == S0) begin
            {dout_r_instr_d3, dout_r_addr_d3} <= {dout_r_instr, dout_r_addr};
        end
        else begin
            {dout_r_instr_d3, dout_r_addr_d3} <= {
                dout_r_instr_d3, dout_r_addr_d3
            };
        end
    end
end

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        after_stall_addr <= 0;
    end
    else begin
        if (state == DV && dec_ready_i == 1'b0) begin
            after_stall_addr <= pc_shift_r0;
        end
        else begin
            after_stall_addr <= after_stall_addr;
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
        prev_ready <= dec_ready_i;
    end
end

assign stall_begin_pulse = prev_ready  & (~dec_ready_i) & dec_valid_o;
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        stall_begin_pulse_r <= 1'b0;
    end
    else begin
        stall_begin_pulse_r <= stall_begin_pulse;
    end
end

assign stall_in_stall = stall_in_stall_r || stall_in_stall_pulse;
assign stall_in_stall_pulse = prev_ready &
                              (~dec_ready_i) &
                              (state == S1 || state == S2) &
                              (~stall_in_stall_r);
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
assign dec_instr_o = out_instr;
assign dec_pc_o  = out_addr;

always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) state <= NV;
    else                state <= next;
end

always_comb begin
    next = XXX;
    case (state)
        NV : if (instr_valid_shift_r[1] == 1'b1) next = DV;
             else                                next = NV;

        DV : if      (is_exception)              next = EX;
             else if (jmp_instr == 1'b1)         next = NV;
             else if (dec_ready_i == 1'b1)           next = DV;
             else                                next = S0;

        S0 : if      (is_exception)              next = EX;
             else if (jmp_instr == 1'b1)         next = NV;
             else if (dec_ready_i == 1'b0)           next = S0;
             else                                next = S1;

        S1 : if      (is_exception)              next = EX;
             else if (jmp_instr == 1'b1)         next = NV;
             else if (dec_ready_i == 1'b0)           next = S1;
             else                                next = S2;

        S2 : if      (is_exception)              next = EX;
             else if (jmp_instr == 1'b1)         next = NV;
             else if (dec_ready_i == 1'b0)           next = S2;
             else if (dec_ready_i == 1'b1 &&
                      stall_in_stall == 1'b1)    next = NV;
             else                                next = DV;

        EX : if    (jmp_instr)                   next = NV;
             else                                next = EX;

        default :                                next = XXX;
    endcase
end

always_comb begin
    {out_instr, out_addr}  = {NOP_INSTR, 32'b0};
    case (state)
        NV: {out_instr, out_addr} = {NOP_INSTR, 32'b0};

        DV: if (dec_ready_i == 1'b1) {out_instr, out_addr} = {dout_r_instr, dout_r_addr};
            else                     {out_instr, out_addr} = {dout_r_instr_d, dout_r_addr_d};

        S0: if (dec_ready_i == 1'b0) {out_instr, out_addr} = {dout_r_instr_d, dout_r_addr_d};
            else                     {out_instr, out_addr} = {dout_r_instr_d2, dout_r_addr_d2};

        S1: if (dec_ready_i == 1'b0) {out_instr, out_addr} = {dout_r_instr_d2, dout_r_addr_d2};
            else                     {out_instr, out_addr} = {dout_r_instr_d3, dout_r_addr_d3};

        S2: if (dec_ready_i == 1'b0) {out_instr, out_addr} = {dout_r_instr_d3, dout_r_addr_d3};
            else if (dec_ready_i == 1'b1 &&
                     stall_in_stall == 1'b1) {out_instr, out_addr} = {NOP_INSTR, 32'b0};
            else                             {out_instr, out_addr} = {dout_r_instr, dout_r_addr};

        EX: {out_instr, out_addr} = {dout_r_instr, dout_r_addr};

        default: {out_instr, out_addr} = {32'b0, 32'b0};
    endcase
end

always_comb begin
    if ((state == NV) ||
        (jmp_instr == 1'b1) ||
        (state == S2 && dec_ready_i == 1'b1 &&
         stall_in_stall == 1'b1) ||
        (state == EX))                                             dec_valid_o = 1'b0;
    else                                                           dec_valid_o = 1'b1;
end

endmodule
