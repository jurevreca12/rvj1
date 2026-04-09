 // RISCV-FORMAL Configuration
`define RISCV_FORMAL
`define RISCV_FORMAL_NRET 1
`define RISCV_FORMAL_XLEN 32
`define RISCV_FORMAL_ILEN 32
`define RISCV_FORMAL_ALIGNED_MEM
`define RISCV_FORMAL_CSR_MSTATUS
`define RISCV_FORMAL_CSR_MIE
`define RISCV_FORMAL_CSR_MIP
`define RISCV_FORMAL_CSR_MTVEC
`define RISCV_FORMAL_CSR_MEPC
`define RISCV_FORMAL_CSR_MCAUSE
`define RISCV_FORMAL_CSR_MTVAL
`define RISCV_FORMAL_CSR_MSCRATCH
//`define RISCV_FORMAL_CSR_MVENDORID
//`define RISCV_FORMAL_CSR_MARCHID
//`define RISCV_FORMAL_CSR_MIMPID
//`define RISCV_FORMAL_CSR_MHARTID
//`define RISCV_FORMAL_CSR_MSTATUSH
//`define RISCV_FORMAL_CSR_MISA
//`define RISCV_FORMAL_CSR_MEDELEG
//`define RISCV_FORMAL_CSR_MEDELEGH
//`define RISCV_FORMAL_CSR_MIDELEG
//`define RISCV_FORMAL_CSR_MCOUNTEREN

`define RVFI_STAGE_CONN(reg) \
    assign rvfi_csr_``reg``_rmask = retired_stage.csr_rmask.``reg``; \
    assign rvfi_csr_``reg``_rdata = retired_stage.csr_rdata.``reg``; \
    assign rvfi_csr_``reg``_wmask = retired_stage.csr_wmask.``reg``; \
    assign rvfi_csr_``reg``_wdata = retired_stage.csr_wdata.``reg``;


`define ASSERT_SINGLE_CYCLE_HOLD(signal, clock=clk_i) \
    always_ff @(posedge clock) begin \
        if (signal == 1'b1) begin \
            single_cycle_``signal``_hold: assert($past(signal) == 1'b0);\
        end\
    end
