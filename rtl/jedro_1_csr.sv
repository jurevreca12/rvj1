////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_csr                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The control and status registers.                          //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import jedro_1_defines::*;

module jedro_1_csr
#(
  parameter DATA_WIDTH = 32
)
(
  input logic clk_i,
  input logic rstn_i,

  // Read/write port
  input logic [CSR_ADDR_WIDTH-1:0]  addr_i,
  input logic [DATA_WIDTH-1:0]      data_i,
  input logic [CSR_UIMM_WIDTH-1:0]  uimm_data_i,
  input logic                       uimm_we_i,
  output logic [DATA_WIDTH-1:0]     data_ro,
  input logic                       we_i,
  input logic [CSR_WMODE_WIDTH-1:0] wmode_i,
 
  // IFU interface main
  input  logic [DATA_WIDTH-1:0] curr_pc_i,
  output logic [DATA_WIDTH-1:0] traphandler_addr_ro,
  output logic                  trap_ro,

  // IFU exception interface
  input  logic                  ifu_exception_i,
  input  logic [DATA_WIDTH-1:0] ifu_mtval_i,

  // LSU exception iterface
  input logic                   lsu_exception_load_i,
  input logic                   lsu_exception_store_i,
  input logic [DATA_WIDTH-1:0]  lsu_exception_addr_i,

  input logic                   decoder_exc_illegal_instr_i,
  input logic                   decoder_exc_ecall_i,
  input logic                   decoder_exc_ebreak_i,

  // interrupt lines
  input logic                   sw_irq_i,
  input logic                   timer_irq_i,
  input logic                   ext_irq_i,

  input logic                   mret_i
);

logic [DATA_WIDTH-1:0] data_n;
logic [DATA_WIDTH-1:0] data_mod;
logic [DATA_WIDTH-1:0] data_mux;

// MSTATUS
logic csr_mstatus_mie_r, csr_mstatus_mie_n, csr_mstatus_mie_exc;  // machine interrupt enable
logic csr_mstatus_mpie_r, csr_mstatus_mpie_n, csr_mstatus_mpie_exc; // previous machine interrupt enable

// MTVEC
logic [CSR_MTVEC_BASE_LEN-1:0] csr_mtvec_base_r, csr_mtvec_base_n;

// MIP
logic csr_mip_msip_r; // machine software interrupt pending
logic csr_mip_mtip_r; // machine timmer interrupt pending
logic csr_mip_meip_r; // machine external interrupt pending

// MIE
logic csr_mie_msie_r, csr_mie_msie_n; // machine software interrupt enable
logic csr_mie_mtie_r, csr_mie_mtie_n; // machine timer interrupt enable
logic csr_mie_meie_r, csr_mie_meie_n; // machine external interrupt enable

// MSCRATCH
logic [DATA_WIDTH-1:0] csr_mscratch_r, csr_mscratch_n;

// MEPC
logic [DATA_WIDTH-1:0] csr_mepc_r, csr_mepc_n, csr_mepc_exc;

// MCAUSE
logic [DATA_WIDTH-1:0] csr_mcause_r, csr_mcause_n, csr_mcause_exc;

// MTVAL
logic [DATA_WIDTH-1:0] csr_mtval_r, csr_mtval_n, csr_mtval_exc;

// Other signals
logic [DATA_WIDTH-1:0] uimm_data_ext;
logic                  is_exception;
logic                  is_write;
logic [DATA_WIDTH-1:0] exception_code;
logic [DATA_WIDTH-1:0] exception_mtval;

assign data_mux = uimm_we_i ? {27'b0, uimm_data_i} : data_i;
always_comb begin
    if (wmode_i == CSR_WMODE_NORMAL)
        data_mod = data_mux;
    else if (wmode_i == CSR_WMODE_SET_BITS)
        data_mod = data_ro | data_mux; // the old value is always read before writing
    else
        data_mod = data_ro & (~data_mux);
end


assign is_exception = ifu_exception_i | 
                      lsu_exception_load_i | 
                      lsu_exception_store_i |
                      decoder_exc_illegal_instr_i |
                      decoder_exc_ecall_i |
                      decoder_exc_ebreak_i;

assign is_write = (!is_exception) && (we_i || uimm_we_i);

always_comb begin
    if      (decoder_exc_illegal_instr_i) exception_code = CSR_MCAUSE_ILLEGAL_INSTRUCTION;
    else if (ifu_exception_i)             exception_code = CSR_MCAUSE_INSTR_ADDR_MISALIGNED;
    else if (decoder_exc_ecall_i)         exception_code = CSR_MCAUSE_ECALL_M_MODE;
    else if (decoder_exc_ebreak_i)        exception_code = CSR_MCAUSE_EBREAK;
    else if (lsu_exception_store_i)       exception_code = CSR_MCAUSE_STORE_ADDR_MISALIGNED;
    else if (lsu_exception_load_i)        exception_code = CSR_MCAUSE_LOAD_ADDR_MISALIGNED;
    else                                  exception_code = 'x;
end

always_comb begin
    if      (decoder_exc_illegal_instr_i) exception_mtval = curr_pc_i;
    else if (ifu_exception_i)             exception_mtval = ifu_mtval_i;
    else if (decoder_exc_ecall_i)         exception_mtval = 0;
    else if (decoder_exc_ebreak_i)        exception_mtval = curr_pc_i;
    else if (lsu_exception_store_i)       exception_mtval = lsu_exception_addr_i;
    else if (lsu_exception_load_i)        exception_mtval = lsu_exception_addr_i;
    else                                  exception_mtval = 'x;
end

always_comb begin
    data_n = 0;
    csr_mstatus_mie_n = csr_mstatus_mie_r;
    csr_mstatus_mpie_n = csr_mstatus_mpie_r;
    csr_mtvec_base_n = csr_mtvec_base_r;
    csr_mie_msie_n = csr_mie_msie_r;
    csr_mie_mtie_n = csr_mie_mtie_r;
    csr_mie_meie_n = csr_mie_meie_r;
    csr_mscratch_n = csr_mscratch_r;
    csr_mepc_n = csr_mepc_r;
    csr_mcause_n = csr_mcause_r;
    csr_mtval_n = csr_mtval_r;
    unique casez (addr_i)
        CSR_ADDR_MVENDORID: begin
            data_n = CSR_DEF_VAL_MVENDORID; // read-only
        end

        CSR_ADDR_MARCHID: begin
            data_n = CSR_DEF_VAL_MARCHID; // read-only
        end

        CSR_ADDR_MIMPID: begin
            data_n = CSR_DEF_VAL_MIMPID; // read-only
        end

        CSR_ADDR_MHARTID: begin
            data_n = CSR_DEF_VAL_MHARTID; // read-only
        end
        
        CSR_ADDR_MSTATUS: begin
            // CSR_DEF_VAL_MSTATUS is all zeros
            data_n = CSR_DEF_VAL_MSTATUS | 
                     (csr_mstatus_mie_r << CSR_MSTATUS_BIT_MIE) |
                     (csr_mstatus_mpie_r << CSR_MSTATUS_BIT_MPIE);
            if (is_write) begin
                csr_mstatus_mie_n = data_mod[CSR_MSTATUS_BIT_MIE];
                csr_mstatus_mpie_n = data_mod[CSR_MSTATUS_BIT_MPIE];
            end
        end

        CSR_ADDR_MISA: begin
            data_n = CSR_DEF_VAL_MISA; // read-only
        end

        CSR_ADDR_MTVEC: begin
            data_n = {csr_mtvec_base_r, TRAP_VEC_MODE};
            if (is_write) begin
                csr_mtvec_base_n = data_mod[DATA_WIDTH-1:DATA_WIDTH-CSR_MTVEC_BASE_LEN];
            end
        end

        CSR_ADDR_MIP: begin
            data_n = {20'b0, 
                      csr_mip_meip_r, 3'b0, 
                      csr_mip_mtip_r, 3'b0, 
                      csr_mip_msip_r, 3'b0}; // read-only
        end

        CSR_ADDR_MIE: begin
            data_n = {20'b0,
                      csr_mie_meie_r, 3'b0,
                      csr_mie_mtie_r, 3'b0,
                      csr_mie_msie_r, 3'b0};

            if (is_write) begin
                csr_mie_msie_n = data_mod[CSR_MIE_BIT_MSIE];
                csr_mie_mtie_n = data_mod[CSR_MIE_BIT_MTIE];
                csr_mie_meie_n = data_mod[CSR_MIE_BIT_MEIE];
            end
        end

        CSR_ADDR_MSCRATCH: begin
            data_n = csr_mscratch_r;
            if (is_write) begin
                csr_mscratch_n = data_mod;
            end
        end

        CSR_ADDR_MEPC: begin
            data_n = csr_mepc_r;
            if (is_write) begin
                csr_mepc_n = data_mod;
            end
        end

        CSR_ADDR_MCAUSE: begin
            data_n = csr_mcause_r; 
            if (is_write) begin
                csr_mcause_n = data_mod;
            end
        end

        CSR_ADDR_MTVAL: begin
            data_n = csr_mtval_r;
            if (is_write) begin
                csr_mtval_n = data_mod;
            end
        end

        default: begin
            // TODO
        end
    endcase
end

// Exception value generation
always_comb begin
    csr_mepc_exc = 0;
    csr_mcause_exc = 0;
    csr_mtval_exc = 0;
    csr_mstatus_mie_exc = 0;
    csr_mstatus_mpie_exc = 0;
    if (is_exception) begin 
        csr_mepc_exc = curr_pc_i;
        csr_mcause_exc = exception_code;
        csr_mtval_exc = exception_mtval;
        csr_mstatus_mie_exc = 1'b0;
        csr_mstatus_mpie_exc = csr_mstatus_mie_r;  
    end
    else if (mret_i) begin
        csr_mstatus_mie_exc = csr_mstatus_mpie_r;
    end
end


always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        data_ro <= 0;
        csr_mstatus_mie_r <= 0;
        csr_mstatus_mpie_r <= 0;
        csr_mtvec_base_r  <= TRAP_VEC_BASE_ADDR;
        csr_mip_meip_r <= 1'b0;
        csr_mip_mtip_r <= 1'b0;
        csr_mip_msip_r <= 1'b0;
        csr_mie_msie_r <= 1'b0;
        csr_mie_mtie_r <= 1'b0;
        csr_mie_meie_r <= 1'b0;
        csr_mscratch_r <= CSR_DEF_VAL_MSCRATCH;
        csr_mepc_r <= CSR_DEF_VAL_MEPC;
        csr_mcause_r <= CSR_DEF_VAL_MCAUSE;
        csr_mtval_r <= CSR_DEF_VAL_MTVAL;
    end
    else begin
        data_ro <= data_n;
        csr_mtvec_base_r  <= csr_mtvec_base_n;
        csr_mip_meip_r <= ext_irq_i;
        csr_mip_mtip_r <= timer_irq_i;
        csr_mip_msip_r <= sw_irq_i;
        csr_mie_msie_r <= csr_mie_msie_n;
        csr_mie_mtie_r <= csr_mie_mtie_n;
        csr_mie_meie_r <= csr_mie_meie_n;
        csr_mscratch_r <= csr_mscratch_n;
        if (is_exception | mret_i) begin
            csr_mepc_r <= csr_mepc_exc;
            csr_mcause_r <= csr_mcause_exc;
            csr_mtval_r <= csr_mtval_exc;
            csr_mstatus_mie_r <= csr_mstatus_mie_exc;
            csr_mstatus_mpie_r <= csr_mstatus_mpie_exc;
        end
        else begin
            csr_mepc_r <= csr_mepc_n;
            csr_mcause_r <= csr_mcause_n;
            csr_mtval_r <= csr_mtval_n;
            csr_mstatus_mie_r <= csr_mstatus_mie_n;
            csr_mstatus_mpie_r <= csr_mstatus_mpie_n;
        end
    end
end


always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin
        trap_ro <= 1'b0;
        traphandler_addr_ro <= 0;
    end
    else begin
        trap_ro <= is_exception | mret_i;
        if (is_exception)
            traphandler_addr_ro <= {csr_mtvec_base_r, 2'b00};
        else if (mret_i)
            traphandler_addr_ro <= csr_mepc_r;
        else
            traphandler_addr_ro <= 0;
    end
end

endmodule

