////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_csr                                                   //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The csr reg file of the rvj1 riscv core.                   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`include "rvj1_defines.svh"

module rvj1_csr import rvj1_pkg::*; #(
  parameter int unsigned MVendorId  = 32'h0000_0000,
  parameter int unsigned MArchId    = 32'h0000_0000,
  parameter int unsigned MImpId     = 32'h0000_0000,
  parameter int unsigned MHartId    = 32'h0000_0000,
  parameter int unsigned MConfigPtr = 32'h0000_0000
) (
  input  logic             clk_i,
  input  logic             rstn_i,

  input  logic             csr_valid_r_i,
  input  logic [11:0]      csr_addr_r_i,
  input  csr_cmd_t         csr_cmd_r_i,
  input  logic [XLEN-1:0]  alu_res_r_i,
  input  logic [RALEN-1:0] regdest_r_i,

  input  logic             csr_exc_write_i,
  input  logic [6:0]       csr_exc_mcause_i,
  input  logic [XLEN-3:0]  csr_exc_mepc_i,
  input  logic [XLEN-1:0]  csr_exc_mtval_i,
  input  logic             csr_mret_restore_i,
  input  logic             csr_dbg_write_i,
  input  logic [2:0]       csr_dbg_cause_i,
  input  logic [XLEN-3:0]  csr_dbg_dpc_i,

  input  logic             dbg_mode_i,
  input  logic             stall_mem_wb_i,

  output logic             illegal_csr_write_o, 
  output logic             nonexist_csr_access_o, 
  output logic             debug_csr_access_err_o,

  output miep_reg_t        mip_o,
  output miep_reg_t        mie_o,
  output mstatus_reg_t     mstatus_o,

  input  logic             irq_external_i,
  input  logic             irq_timer_i,
  input  logic             irq_sw_i,
  input  logic             irq_lcofi_i,
  input  logic [15:0]      irq_platform_i,


  output dcsr_reg_t        dcsr_o,
  output logic [XLEN-1:0]  csr_dpc_value_o,
  output logic [XLEN-1:0]  csr_mepc_value_o,
  output logic [XLEN-1:0]  csr_mtvec_value_o,
  output logic [XLEN-1:0]  csr_value_o,
  output logic [RALEN-1:0] csr_regdest_o,
  output logic             csr_wb_o

  `ifdef RVFI
  ,output rvfi_csr_t rvfi_csr_rdata,
  output rvfi_csr_t rvfi_csr_rmask,
  output rvfi_csr_t rvfi_csr_wdata,
  output rvfi_csr_t rvfi_csr_wmask
 `endif

);
  // CSR register signal defintions
  //     +------+
  // --->|D     |
  //     |      |
  //     |     Q|--->
  //     |      |
  //     |CLK   |
  //     +------+
  mstatus_reg_t    mstatus_d, mstatus_q;
  miep_reg_t       mie_d, mie_q;
  mtvec_reg_t      mtvec_d, mtvec_q; // only direct mode supported
  logic [XLEN-3:0] mepc_d, mepc_q;
  logic [6:0]      mcause_d, mcause_q; // 1 bit for IRQ/EXC, 5 bits-code=>log2(19)=4.24
  logic [XLEN-1:0] mtval_d, mtval_q;
  logic [XLEN-1:0] mscratch_d, mscratch_q;
  dcsr_reg_t       dcsr_d, dcsr_q;
  logic [XLEN-1:0] dpc_d, dpc_q;
  logic [XLEN-1:0] dscratch0_d, dscratch0_q;
  logic [XLEN-1:0] dscratch1_d, dscratch1_q;
  logic dcsr_ce, dpc_ce, dscratch0_ce, dscratch1_ce;
  logic mstatus_ce, mie_ce, mtvec_ce, mepc_ce, mcause_ce, mtval_ce, mscratch_ce;
  logic csr_valid_write;
  logic csr_valid_read;

  // full output values of registers
  logic [XLEN-1:0] csr_mstatus_value, csr_mstatus_masked;
  logic [XLEN-1:0] csr_mie_value, csr_mie_masked;
  logic [XLEN-1:0] csr_mip_value;
  logic [XLEN-1:0] csr_mtvec_value, csr_mtvec_masked;
  logic [XLEN-1:0] csr_mepc_value, csr_mepc_masked;
  logic [XLEN-1:0] csr_mcause_value, csr_mcause_masked;
  logic [XLEN-1:0] csr_mtval_value, csr_mtval_masked;
  logic [XLEN-1:0] csr_mscratch_value;
  logic [XLEN-1:0] csr_dcsr_value, csr_dcsr_masked;
  logic [XLEN-1:0] csr_dpc_value, csr_dpc_masked;
  logic [XLEN-1:0] csr_dscratch0_value, csr_dscratch0_masked;
  logic [XLEN-1:0] csr_dscratch1_value, csr_dscratch1_masked;

  logic [XLEN-1:0] csr_value;

  /*************************************
  * Helper functions
  *************************************/
  function automatic [XLEN-1:0] csr_mask_op(input logic [XLEN-1:0] rs1, input logic [XLEN-1:0] csr_reg, input csr_cmd_t cmd);
    begin
      logic [XLEN-1:0] res;
      unique case (cmd)
        CSRRW:   res =  rs1;
        CSRRS:   res =  rs1 | csr_reg;
        CSRRC:   res = ~rs1 & csr_reg;
        default: res =  rs1;
      endcase
      return res;
    end
  endfunction

  /*************************************
  * Outputs
  *************************************/
  assign dcsr_o            = dcsr_q;
  assign csr_dpc_value_o   = csr_dpc_value;
  assign csr_mepc_value_o  = csr_mepc_value;
  assign csr_mtvec_value_o = csr_mtvec_value;
  assign mip_o             = '{
    msi:irq_sw_i,
    mti:irq_timer_i,
    mei:irq_external_i,
    lcofi:irq_lcofi_i,
    irqs:irq_platform_i
  };
  assign mie_o             = mie_q;
  assign mstatus_o         = mstatus_q;


  /*************************************
  * Control and Status Registers
  *************************************/
  assign csr_mstatus_value = (
      ({31'b0, mstatus_q.mie}  << CSR_MSTATUS_MIE_BIT)
    | ({31'b0, mstatus_q.mpie} << CSR_MSTATUS_MPIE_BIT)
    | ({31'b0, mstatus_q.mpp}  << CSR_MSTATUS_MPP_BIT_0)
    | ({31'b0, mstatus_q.mpp}  << CSR_MSTATUS_MPP_BIT_1)
    | 32'b0
  );
  assign csr_mie_value = (
      ({31'b0, mie_q.msi}   << CSR_MIEP_MSI_BIT)
    | ({31'b0, mie_q.mti}   << CSR_MIEP_MTI_BIT)
    | ({31'b0, mie_q.mei}   << CSR_MIEP_MEI_BIT)
    | ({31'b0, mie_q.lcofi} << CSR_MIEP_LCOFI_BIT)
    | ({16'b0, mie_q.irqs}  << CSR_MIEP_PLATFORM_IRQS_BIT)
    | 32'b0
  );
  assign csr_mip_value = (
      ({31'b0, mip_o.msi}   << CSR_MIEP_MSI_BIT)
    | ({31'b0, mip_o.mti}   << CSR_MIEP_MTI_BIT)
    | ({31'b0, mip_o.mei}   << CSR_MIEP_MEI_BIT)
    | ({31'b0, mip_o.lcofi} << CSR_MIEP_LCOFI_BIT)
    | ({16'b0, mip_o.irqs}  << CSR_MIEP_PLATFORM_IRQS_BIT)
    | 32'b0
  );
  assign csr_mepc_value     = {mepc_q, 2'b00}; // IALIGN=32
  assign csr_mtvec_value    = {mtvec_q.base, 1'b0, mtvec_q.mode}; 
  assign csr_mcause_value   = {mcause_q[6], 25'b0, mcause_q[5:0]};
  assign csr_mtval_value    = mtval_q;
  assign csr_mscratch_value = mscratch_q;
  assign csr_dcsr_value     = (
      ({30'b0, 2'd3}           << CSR_DCSR_PRV_BIT_0)
    | ({31'b0, dcsr_q.step}    << CSR_DCSR_STEP_BIT)
    | ({31'b0, dcsr_q.nmip}    << CSR_DCSR_NMIP_BIT)
    | ({31'b0, 1'b0}           << CSR_DCSR_MPRVEN_BIT)
    | ({29'b0, dcsr_q.cause}   << CSR_DCSR_CAUSE_BIT_0)
    | ({31'b0, 1'b0}           << CSR_DCSR_STOPTIME_BIT)
    | ({31'b0, 1'b0}           << CSR_DCSR_STOPCOUNT_BIT)
    | ({31'b0, 1'b0}           << CSR_DCSR_STEPIE_BIT)
    | ({31'b0, dcsr_q.ebreakm} << CSR_DCSR_EBREAKM_BIT)
    | ({28'b0, 4'h4}           << CSR_DCSR_XDEBUGVER_BIT_0)
    | 32'b0
  );
  assign csr_dpc_value = dpc_q;
  assign csr_dscratch0_value = dscratch0_q;
  assign csr_dscratch1_value = dscratch1_q;

  // csr_valid_r does not need stall control as stall is already applied at the
  // pipeline register (_r)
  assign csr_value_o = csr_value;
  assign csr_regdest_o = regdest_r_i;
  assign csr_wb_o = csr_valid_r_i && ~stall_mem_wb_i;


  `ifdef ASSERTIONS
  always_ff @(posedge clk_i) begin
    if (csr_valid_r_i)
      req_val_cmd: assert (csr_cmd_r_i != CSRNO);
  end
  `endif

  assign csr_valid_read = (csr_valid_r_i && (csr_cmd_r_i == CSRRW) && (regdest_r_i != '0) ||
                           csr_valid_r_i && (csr_cmd_r_i == CSRRS) ||
                           csr_valid_r_i && (csr_cmd_r_i == CSRRC));
  assign csr_valid_write = (csr_valid_r_i && (csr_cmd_r_i == CSRRW) ||
                            csr_valid_r_i && (csr_cmd_r_i == CSRRS) && (alu_res_r_i != '0) ||
                            csr_valid_r_i && (csr_cmd_r_i == CSRRC) && (alu_res_r_i != '0));

  assign illegal_csr_write_o = csr_valid_write && csr_addr_r_i[11:10] == 2'b11;
  assign debug_csr_access_err_o = csr_valid_r_i && !dbg_mode_i && (
                                (csr_addr_r_i == CSR_DCSR_ADDR) || 
                                (csr_addr_r_i == CSR_DPC_ADDR) || 
                                (csr_addr_r_i == CSR_DSCRATCH0_ADDR) ||
                                (csr_addr_r_i == CSR_DSCRATCH1_ADDR));

  assign nonexist_csr_access_o = csr_valid_r_i && !(
    (csr_addr_r_i == CSR_MVENDORID_ADDR)  ||
    (csr_addr_r_i == CSR_MARCHID_ADDR)    ||
    (csr_addr_r_i == CSR_MIMPID_ADDR)     ||
    (csr_addr_r_i == CSR_MHARTID_ADDR)    ||
    (csr_addr_r_i == CSR_MCONFIGPTR_ADDR) ||
    (csr_addr_r_i == CSR_MSTATUS_ADDR)    ||
    (csr_addr_r_i == CSR_MSTATUSH_ADDR)   ||
    (csr_addr_r_i == CSR_MISA_ADDR)       ||
    (csr_addr_r_i == CSR_MEDELEG_ADDR)    ||
    (csr_addr_r_i == CSR_MEDELEGH_ADDR)   ||
    (csr_addr_r_i == CSR_MIDELEG_ADDR)    ||
    (csr_addr_r_i == CSR_MIE_ADDR)        ||
    (csr_addr_r_i == CSR_MTVEC_ADDR)      ||
    (csr_addr_r_i == CSR_MCOUNTEREN_ADDR) ||
    (csr_addr_r_i == CSR_MSCRATCH_ADDR)   ||
    (csr_addr_r_i == CSR_MEPC_ADDR)       ||
    (csr_addr_r_i == CSR_MCAUSE_ADDR)     ||
    (csr_addr_r_i == CSR_MTVAL_ADDR)      ||
    (csr_addr_r_i == CSR_MIP_ADDR)        ||
    (csr_addr_r_i == CSR_DCSR_ADDR)       ||
    (csr_addr_r_i == CSR_DPC_ADDR)        ||
    (csr_addr_r_i == CSR_DSCRATCH0_ADDR)  ||
    (csr_addr_r_i == CSR_DSCRATCH1_ADDR)  ||
    (csr_addr_r_i == CSR_MCYCLE_ADDR)     ||
    (csr_addr_r_i == CSR_MCYCLEH_ADDR)    ||
    (csr_addr_r_i == CSR_MINSTRET_ADDR)   ||
    (csr_addr_r_i == CSR_MINSTRETH_ADDR)
  );
   // Read logic
  always_comb begin
    csr_value = '0;
    // ONLY implemented registers, others default to zero
    if (csr_valid_read) begin
      case (csr_addr_r_i)
        // Machine Information Registers
        CSR_MVENDORID_ADDR:  csr_value = MVendorId;
        CSR_MARCHID_ADDR:    csr_value = MArchId;
        CSR_MIMPID_ADDR:     csr_value = MImpId;
        CSR_MHARTID_ADDR:    csr_value = MHartId;
        CSR_MCONFIGPTR_ADDR: csr_value = MConfigPtr;

        // Machine Trap Setup
        CSR_MSTATUS_ADDR:    csr_value = csr_mstatus_value;
        CSR_MSTATUSH_ADDR:   csr_value = CSR_MSTATUSH_VALUE;
        CSR_MISA_ADDR:       csr_value = CSR_MISA_VALUE;
        CSR_MEDELEG_ADDR:    csr_value = CSR_MEDELEG_VALUE;
        CSR_MEDELEGH_ADDR:   csr_value = CSR_MEDELEGH_VALUE;
        CSR_MIDELEG_ADDR:    csr_value = CSR_MIDELEG_VALUE;
        CSR_MIE_ADDR:        csr_value = csr_mie_value;
        CSR_MTVEC_ADDR:      csr_value = csr_mtvec_value;
        CSR_MCOUNTEREN_ADDR: csr_value = CSR_MCOUNTEREN_VALUE;

        // Machine Trap Handling
        CSR_MSCRATCH_ADDR:   csr_value = csr_mscratch_value;
        CSR_MEPC_ADDR:       csr_value = csr_mepc_value;
        CSR_MCAUSE_ADDR:     csr_value = csr_mcause_value;
        CSR_MTVAL_ADDR:      csr_value = csr_mtval_value;
        CSR_MIP_ADDR:        csr_value = csr_mip_value;

        // Debug Mode CSRs
        CSR_DCSR_ADDR:       csr_value = csr_dcsr_value;
        CSR_DPC_ADDR:        csr_value = csr_dpc_value;
        CSR_DSCRATCH0_ADDR:  csr_value = csr_dscratch0_value;
        CSR_DSCRATCH1_ADDR:  csr_value = csr_dscratch1_value;

        // Machine Counter CSRs
        CSR_MCYCLE_ADDR:     csr_value = '0;
        CSR_MCYCLEH_ADDR:    csr_value = '0;
        CSR_MINSTRET_ADDR:   csr_value = '0;
        CSR_MINSTRETH_ADDR:  csr_value = '0;
        default :            csr_value = '0;
      endcase
    end
  end

  always_comb begin
    mscratch_d = mscratch_q;
    mscratch_ce = 1'b0;
    mtvec_d = mtvec_q;
    mtvec_ce = 1'b0;
    csr_mtvec_masked = '0;
    mepc_d = mepc_q;
    mepc_ce = 1'b0;
    csr_mepc_masked = '0;
    mcause_d = mcause_q;
    mcause_ce = 1'b0;
    csr_mcause_masked = '0;
    mstatus_d = mstatus_q;
    mstatus_ce = 1'b0;
    csr_mstatus_masked = '0;
    mtval_d = mtval_q;
    mtval_ce = 1'b0;
    csr_mtval_masked = '0;
    dcsr_d = dcsr_q;
    dcsr_ce = 1'b0;
    dpc_d = dpc_q;
    dpc_ce = 1'b0;
    csr_dcsr_masked = '0;
    csr_dpc_masked = '0;
    csr_dscratch0_masked = '0;
    csr_dscratch1_masked = '0;
    dscratch0_d = dscratch0_q;
    dscratch0_ce = 1'b0;
    dscratch1_d = dscratch1_q;
    dscratch1_ce = 1'b0;
    csr_mie_masked = '0;
    mie_d = mie_q;
    mie_ce = 1'b0;
    if (csr_valid_write) begin
      case (csr_addr_r_i)
        CSR_MSTATUS_ADDR: begin
          // Will the synthesis tool optimize these two function calls into a single module?
          csr_mstatus_masked = csr_mask_op(alu_res_r_i, csr_mstatus_value, csr_cmd_r_i);
          mstatus_d.mie      = csr_mstatus_masked[CSR_MSTATUS_MIE_BIT];
          mstatus_d.mpie     = csr_mstatus_masked[CSR_MSTATUS_MPIE_BIT];
          mstatus_d.mpp      = csr_mstatus_masked[CSR_MSTATUS_MPP_BIT_0]; // WARL
          mstatus_ce         = 1'b1;
        end
        CSR_MSCRATCH_ADDR: begin
          mscratch_d  = csr_mask_op(alu_res_r_i, csr_mscratch_value, csr_cmd_r_i);
          mscratch_ce = 1'b1;
        end
        CSR_MTVEC_ADDR: begin
          csr_mtvec_masked = csr_mask_op(alu_res_r_i, csr_mtvec_value, csr_cmd_r_i);
          mtvec_d.base     = csr_mtvec_masked[31:2];
          mtvec_d.mode     = csr_mtvec_masked[0];
          mtvec_ce         = 1'b1;
        end
        CSR_MEPC_ADDR: begin
          csr_mepc_masked = csr_mask_op(alu_res_r_i, csr_mepc_value, csr_cmd_r_i);
          mepc_d          = csr_mepc_masked[31:2];
          mepc_ce         = 1'b1;
        end
        CSR_MCAUSE_ADDR: begin
          csr_mcause_masked = csr_mask_op(alu_res_r_i, csr_mcause_value, csr_cmd_r_i);
          mcause_d          = {csr_mcause_masked[31], csr_mcause_masked[5:0]};
          mcause_ce         = 1'b1;
        end
        CSR_MTVAL_ADDR: begin
          csr_mtval_masked = csr_mask_op(alu_res_r_i, csr_mtval_value, csr_cmd_r_i);
          mtval_d          = csr_mtval_masked;
          mtval_ce         = 1'b1;
        end
        CSR_MIE_ADDR: begin
          csr_mie_masked = csr_mask_op(alu_res_r_i, csr_mie_value, csr_cmd_r_i);
          mie_d.irqs     = csr_mie_masked[XLEN-1:CSR_MIEP_PLATFORM_IRQS_BIT];
          mie_d.lcofi    = csr_mie_masked[CSR_MIEP_LCOFI_BIT];
          mie_d.mei      = csr_mie_masked[CSR_MIEP_MEI_BIT];
          mie_d.msi      = csr_mie_masked[CSR_MIEP_MSI_BIT];
          mie_d.mti      = csr_mie_masked[CSR_MIEP_MTI_BIT];
          mie_ce         = 1'b1;
        end
        CSR_DCSR_ADDR: begin
          csr_dcsr_masked = csr_mask_op(alu_res_r_i, csr_dcsr_value, csr_cmd_r_i);
          dcsr_d.step     = csr_dcsr_masked[CSR_DCSR_STEP_BIT];
          dcsr_d.ebreakm  = csr_dcsr_masked[CSR_DCSR_EBREAKM_BIT];
          dcsr_ce         = dbg_mode_i;
        end
        CSR_DPC_ADDR: begin
          csr_dpc_masked = csr_mask_op(alu_res_r_i, csr_dpc_value, csr_cmd_r_i);
          dpc_d          = csr_dpc_masked;
          dpc_ce         = dbg_mode_i;
        end
        CSR_DSCRATCH0_ADDR: begin
          csr_dscratch0_masked = csr_mask_op(alu_res_r_i, csr_dscratch0_value, csr_cmd_r_i);
          dscratch0_d          = csr_dscratch0_masked;
          dscratch0_ce         = dbg_mode_i;
        end
        CSR_DSCRATCH1_ADDR: begin
          csr_dscratch1_masked = csr_mask_op(alu_res_r_i, csr_dscratch1_value, csr_cmd_r_i);
          dscratch1_d          = csr_dscratch1_masked;
          dscratch1_ce         = dbg_mode_i;
        end
      endcase
    end
    if (csr_exc_write_i) begin
      mcause_d       = csr_exc_mcause_i;
      mcause_ce      = 1'b1;
      mepc_d         = csr_exc_mepc_i;
      mepc_ce        = 1'b1;
      mstatus_d.mie  = 1'b0;
      mstatus_d.mpie = mstatus_q.mie;
      mstatus_d.mpp  = 1'b1;
      mstatus_ce     = 1'b1;
      mtval_d        = csr_exc_mtval_i;
      mtval_ce       = 1'b1;
    end
    
    if (csr_mret_restore_i) begin
      mstatus_d.mie  = mstatus_q.mpie;
      mstatus_d.mpie = 1'b1;
      mstatus_ce     = 1'b1;
    end
    
    if (csr_dbg_write_i) begin
      dcsr_d.cause = csr_dbg_cause_i;
      dcsr_ce      = 1'b1;
      dpc_d        = {csr_dbg_dpc_i, 2'b00};
      dpc_ce       = 1'b1;
    end
  end

  `ifdef ASSERTIONS
    `ASSERT_SINGLE_CYCLE_HOLD(mstatus_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mie_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mtval_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mcause_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mepc_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mscratch_ce);
  `endif


  register #(
    .DTYPE(miep_reg_t),
    .RESET_VALUE('0)
  ) csr_mie_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (mie_ce),
    .in   (mie_d),
    .out  (mie_q)
  );

  register #(
    .DTYPE(mstatus_reg_t),
    .RESET_VALUE(3'b001) // MPP reset to 0 (spike compat)
  ) csr_mstatus_reg (
    .clk (clk_i),
    .rstn(rstn_i),
    .ce  (mstatus_ce),
    .in  (mstatus_d),
    .out (mstatus_q)
  );

  register #(
    .DTYPE(logic [XLEN-1:0]),
    .RESET_VALUE(0)
  ) csr_mscratch_reg (
    .clk (clk_i),
    .rstn(rstn_i),
    .ce  (mscratch_ce),
    .in  (mscratch_d),
    .out (mscratch_q)
  );

  register #(
    .DTYPE(mtvec_reg_t),
    .RESET_VALUE(0)
  ) csr_mtvec_reg (
    .clk (clk_i),
    .rstn(rstn_i),
    .ce  (mtvec_ce),
    .in  (mtvec_d),
    .out (mtvec_q)
  );

  register #(
    .DTYPE(logic [XLEN-3:0]),
    .RESET_VALUE(0)
  ) csr_mepc_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (mepc_ce), // The core is stalled in exceptions
    .in   (mepc_d),
    .out  (mepc_q)
  );

   register #(
    .DTYPE(logic [6:0]),
    .RESET_VALUE(0)
   ) csr_mcause_reg (
    .clk (clk_i),
    .rstn(rstn_i),
    .ce  (mcause_ce),
    .in  (mcause_d),
    .out (mcause_q)
  );

  register #(
    .DTYPE(logic [XLEN-1:0]),
    .RESET_VALUE(0)
  ) csr_mtval_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (mtval_ce), // The core is stalled in exceptions
    .in   (mtval_d),
    .out  (mtval_q)
  );

  register #(
    .DTYPE(dcsr_reg_t),
    .RESET_VALUE(0)
  ) csr_dcsr_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (dcsr_ce), // The core is stalled in debug mode
    .in   (dcsr_d),
    .out  (dcsr_q)
  );

  register #(
    .DTYPE(logic [XLEN-1:0]),
    .RESET_VALUE(0)
  ) csr_dpc_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (dpc_ce),
    .in   (dpc_d),
    .out  (dpc_q)
  );

  register #(
    .DTYPE(logic [XLEN-1:0]),
    .RESET_VALUE(0)
  ) csr_dscratch0_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (dscratch0_ce),
    .in   (dscratch0_d),
    .out  (dscratch0_q)
  );

  register #(
    .DTYPE(logic [XLEN-1:0]),
    .RESET_VALUE(0)
  ) csr_dscratch1_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (dscratch1_ce),
    .in   (dscratch1_d),
    .out  (dscratch1_q)
  );

  `ifdef RVFI
    assign rvfi_csr_rmask.mstatus = '1;
    assign rvfi_csr_rdata.mstatus = csr_mstatus_value;
    assign rvfi_csr_wmask.mstatus = mstatus_ce ? '1 : '0;
    assign rvfi_csr_wdata.mstatus = ({31'b0, mstatus_d.mie}  << CSR_MSTATUS_MIE_BIT)
                                  | ({31'b0, mstatus_d.mpie} << CSR_MSTATUS_MPIE_BIT)
                                  | ({31'b0, mstatus_d.mpp}  << CSR_MSTATUS_MPP_BIT_0)
                                  | ({31'b0, mstatus_d.mpp}  << CSR_MSTATUS_MPP_BIT_1)
                                  | 32'b0;

    assign rvfi_csr_rmask.mie = '1;
    assign rvfi_csr_rdata.mie = csr_mie_value;
    assign rvfi_csr_wmask.mie = mie_ce ? '1 : '0;
    assign rvfi_csr_wdata.mie = ({31'b0, mie_d.msi}   << CSR_MIEP_MSI_BIT)
                              | ({31'b0, mie_d.mti}   << CSR_MIEP_MTI_BIT)
                              | ({31'b0, mie_d.mei}   << CSR_MIEP_MEI_BIT)
                              | ({31'b0, mie_d.lcofi} << CSR_MIEP_LCOFI_BIT)
                              | ({16'b0, mie_d.irqs}  << CSR_MIEP_PLATFORM_IRQS_BIT)
                              | 32'b0;

    assign rvfi_csr_rmask.mip = '1;
    assign rvfi_csr_rdata.mip = csr_mip_value;
    assign rvfi_csr_wmask.mip = '0; // TODO
    assign rvfi_csr_wdata.mip = '0;
  
    assign rvfi_csr_rmask.mtvec = '1;
    assign rvfi_csr_rdata.mtvec = csr_mtvec_value;
    assign rvfi_csr_wmask.mtvec = mtvec_ce ? '1 : '0;
    assign rvfi_csr_wdata.mtvec = {mtvec_d.base, 1'b0, mtvec_d.mode};

    assign rvfi_csr_rmask.mepc = '1;
    assign rvfi_csr_rdata.mepc = csr_mepc_value;
    assign rvfi_csr_wmask.mepc = mepc_ce ? '1 : '0;
    assign rvfi_csr_wdata.mepc = {mepc_d, 2'b00};

    assign rvfi_csr_rmask.mcause = '1;
    assign rvfi_csr_rdata.mcause = csr_mcause_value;
    assign rvfi_csr_wmask.mcause = mcause_ce ? '1 : '0;
    assign rvfi_csr_wdata.mcause = {mcause_d[6], 25'b0, mcause_d[5:0]};

    assign rvfi_csr_rmask.mtval = '1;
    assign rvfi_csr_rdata.mtval = csr_mtval_value;
    assign rvfi_csr_wmask.mtval = mtval_ce ? '1 : '0;
    assign rvfi_csr_wdata.mtval = mtval_d;

    assign rvfi_csr_rmask.mscratch = '1;
    assign rvfi_csr_rdata.mscratch = csr_mscratch_value;
    assign rvfi_csr_wmask.mscratch = mscratch_ce ? '1 : '0;
    assign rvfi_csr_wdata.mscratch = mscratch_d;
  `endif

endmodule
