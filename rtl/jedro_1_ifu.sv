////////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                             //
//                                                                                //
//                                                                                //
//                                                                                //
// Design Name:    jedro_1_ifu                                                    //
// Project Name:   riscv-jedro-1                                                  //
// Language:       System Verilog                                                 //
//                                                                                //
// Description:    The instruction fetch unit.                                    //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////

import jedro_1_defines::*;

module jedro_1_ifu #(
    parameter bit [31:0] BOOT_ADDR = 32'h8000_0000
)
(
  input logic clk_i,
  input logic rstn_i,

  output logic [DATA_WIDTH-1:0] instr_req_addr_o,
  output logic [DATA_WIDTH-1:0] instr_req_data_o,
  output logic [3:0]            instr_req_strobe_o,
  output logic                  instr_req_write_o,
  output logic                  instr_req_valid_o,
  input  logic                  instr_req_ready_i,

  input  logic [DATA_WIDTH-1:0] instr_rsp_data_i,
  input  logic                  instr_rsp_error_i,
  input  logic                  instr_rsp_valid_i,
  output logic                  instr_rsp_ready_o,

  // Interface to the decoder
  output logic [DATA_WIDTH-1:0] dec_instr_o,  // The current instruction (to be decoded)
  output logic [DATA_WIDTH-1:0] dec_pc_o,     // Used by instructons that calculate on the PC.
  output logic                  dec_valid_o,
  input  logic                  dec_ready_i,  // Decoder ready to accept new instruction (stall)

  input logic                  jmp_addr_valid_i, // change PC to jmp_addr_i
  input logic [DATA_WIDTH-1:0] jmp_addr_i,       // The jump address

  output logic                  exception_ro, // Signal isntr misaligned exception
  output logic [DATA_WIDTH-1:0] fault_addr_ro // the address that caused the misaligned exception
);
    logic [DATA_WIDTH-1:0] next_fetch_addr; // Which instruction to fetch next
    logic [DATA_WIDTH-1:0] prog_cnt; // What is the address of the currently obtained instruction


    always_ff @(posedge clk_i) begin : fetch_addr_logic
        if (rstn_i == 1'b0) begin
            next_fetch_addr <= BOOT_ADDR;
        end
        else begin
            if (jmp_addr_valid_i)
                next_fetch_addr <= jmp_addr_i;
            else if (instr_req_valid_o & instr_req_ready_i)
                next_fetch_addr <= next_fetch_addr + 4;
        end
    end

    /***************************************
    * Instruction Memory Interface
    ***************************************/
    assign instr_req_data_o   = 32'b0;
    assign instr_req_write_o  = 1'b0;  // read-only interface
    assign instr_req_addr_o   = next_fetch_addr;
    always_ff @(posedge clk_i) begin: instr_req_if_logic
        if (rstn_i == 1'b0) begin
            instr_req_valid_o <= 1'b0;
            instr_req_strobe_o <= 4'b0000;
        end
        else begin
            instr_req_valid_o <= 1'b1;
            instr_req_strobe_o <= 4'b1111;
        end
    end
    assign instr_rsp_ready_o = 1'b1;

    /***************************************
    * Decoder Interface
    ***************************************/
    assign dec_pc_o = prog_cnt;
    always_ff @(posedge clk_i) begin: pc_logic
        if (rstn_i == 1'b0) begin
            prog_cnt <= BOOT_ADDR;
        end
        else begin
            if (jmp_addr_valid_i)
                prog_cnt <= jmp_addr_i;
            else if (dec_valid_o & dec_ready_i)
                prog_cnt <= prog_cnt + 4;
        end
    end
    always_ff @(posedge clk_i) begin: dec_if_logic
        if (rstn_i == 1'b0) begin
            dec_valid_o <= 1'b0;
            dec_instr_o <= 32'b0;
        end
        else begin
            dec_valid_o <= instr_rsp_valid_i & !instr_rsp_error_i;
            dec_instr_o <= instr_rsp_data_i;
        end
    end

endmodule
