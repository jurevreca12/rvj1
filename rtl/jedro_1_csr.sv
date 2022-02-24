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

  // interrupt lines
  input logic sw_irq_i,
  input logic timer_irq_i,
  input logic ext_irq_i
);

logic [DATA_WIDTH-1:0] data_n;
logic [DATA_WIDTH-1:0] data_mod;
logic [DATA_WIDTH-1:0] data_mux;

// MSTATUS
logic csr_mstatus_mie_r;  // machine interrupt enable
logic csr_mstatus_mie_n;  
logic csr_mstatus_mpie_r; // previous machine interrupt enable
logic csr_mstatus_mpie_n; 

// MTVEC
logic [CSR_MTVEC_BASE_LEN-1:0] csr_mtvec_base_r;
logic [CSR_MTVEC_BASE_LEN-1:0] csr_mtvec_base_n;

// MIP
logic csr_mip_msip_r; // machine software interrupt pending
logic csr_mip_mtip_r; // machine timmer interrupt pending
logic csr_mip_meip_r; // machine external interrupt pending

// MIE
logic csr_mie_msie_r; // machine software interrupt enable
logic csr_mie_msie_n;
logic csr_mie_mtie_r; // machine timer interrupt enable
logic csr_mie_mtie_n;
logic csr_mie_meie_r; // machine external interrupt enable
logic csr_mie_meie_n;

// MSCRATCH
logic [DATA_WIDTH-1:0] csr_mscratch_r;
logic [DATA_WIDTH-1:0] csr_mscratch_n;

// MEPC
logic [DATA_WIDTH-1:0] csr_mepc_r;
logic [DATA_WIDTH-1:0] csr_mepc_n;

// MCAUSE
logic [DATA_WIDTH-1:0] csr_mcause_r;
logic [DATA_WIDTH-1:0] csr_mcause_n;

// MTVAL
logic [DATA_WIDTH-1:0] csr_mtval_r;
logic [DATA_WIDTH-1:0] csr_mtval_n;

logic [DATA_WIDTH-1:0] uimm_data_ext;


assign data_mux = uimm_we_i ? {27'b0, uimm_data_i} : data_i;
always_comb begin
    if (wmode_i == CSR_WMODE_NORMAL)
        data_mod = data_mux;
    else if (wmode_i == CSR_WMODE_SET_BITS)
        data_mod = data_ro | data_mux; // the old value is always read before writing
    else
        data_mod = data_ro & (~data_mux);
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
            if (we_i == 1'b1 || uimm_we_i == 1'b1) begin
                csr_mstatus_mie_n = data_mod[CSR_MSTATUS_BIT_MIE];
                csr_mstatus_mpie_n = data_mod[CSR_MSTATUS_BIT_MPIE];
            end
        end

        CSR_ADDR_MISA: begin
            data_n = CSR_DEF_VAL_MISA; // read-only
        end

        CSR_ADDR_MTVEC: begin
            data_n = {csr_mtvec_base_r, TRAP_VEC_MODE};
            if (we_i == 1'b1 || uimm_we_i == 1'b1) begin
                csr_mtvec_base_n = data_mod[DATA_WIDTH-1:DATA_WIDTH-1-CSR_MTVEC_BASE_LEN];
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

            if (we_i == 1'b1 || uimm_we_i == 1'b1) begin
                csr_mie_msie_n = data_mod[CSR_MIE_BIT_MSIE];
                csr_mie_mtie_n = data_mod[CSR_MIE_BIT_MTIE];
                csr_mie_meie_n = data_mod[CSR_MIE_BIT_MEIE];
            end
        end

        CSR_ADDR_MSCRATCH: begin
            data_n = csr_mscratch_r;
            if (we_i == 1'b1 || uimm_we_i == 1'b1) begin
                csr_mscratch_n = data_mod;
            end
        end

        CSR_ADDR_MEPC: begin
            data_n = csr_mepc_r;
            if (we_i == 1'b1 || uimm_we_i == 1'b1) begin
                csr_mepc_n = data_mod;
            end
        end

        CSR_ADDR_MCAUSE: begin
            data_n = csr_mcause_r; 
            if (we_i == 1'b1 || uimm_we_i == 1'b1) begin
                csr_mcause_n = data_mod;
            end
        end

        CSR_ADDR_MTVAL: begin
            data_n = csr_mtval_r;
            if (we_i == 1'b1 || uimm_we_i == 1'b1) begin
                csr_mtval_n = data_mod;
            end
        end

        default: begin
            // TODO
        end
    endcase
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
        csr_mstatus_mie_r <= csr_mstatus_mie_n;
        csr_mstatus_mpie_r <= csr_mstatus_mpie_n;
        csr_mtvec_base_r  <= csr_mtvec_base_n;
        csr_mip_meip_r <= ext_irq_i;
        csr_mip_mtip_r <= timer_irq_i;
        csr_mip_msip_r <= sw_irq_i;
        csr_mie_msie_r <= csr_mie_msie_n;
        csr_mie_mtie_r <= csr_mie_mtie_n;
        csr_mie_meie_r <= csr_mie_meie_n;
        csr_mscratch_r <= csr_mscratch_n;
        csr_mepc_r <= csr_mepc_n;
        csr_mcause_r <= csr_mcause_n;
        csr_mtval_r <= csr_mtval_n;
    end
end

endmodule

