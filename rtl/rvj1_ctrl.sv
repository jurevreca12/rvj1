////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jure.vreca@ijs.si                             //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_ctrl                                                  //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    Controller for the rvj1 core.                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

`include "rvj1_defines.svh"
/* verilator lint_off IMPORTSTAR */
module rvj1_ctrl import rvj1_pkg::*;
(
  input logic clk_i,
  input logic rstn_i,

  // EX - Stage
  input  logic [RALEN-1:0] rf_addr_a_i,
  input  logic [RALEN-1:0] rf_addr_b_i,
  input  logic             rpa_or_pc_i,
  input  logic             rpb_or_imm_i,
  input  logic [RALEN-1:0] regdest_i,
  input  lsu_ctrl_e        lsu_cmd_i,
  input  logic             lsu_ctrl_valid_i,
  input  logic             lsu_ready_i,
  input  logic             lsu_wb_i,
  input  logic             ctrl_jump_i,
  input  logic             ctrl_branch_i,
  input  branch_ctrl_e     ctrl_branch_type_i,
  input  logic             ecall_insn_i,
  input  logic             mret_insn_i,
  input  logic             ebreak_insn_i,
  input  logic             illegal_instr_i,

  input  logic             control_i,
  input  logic             instr_fetch_error_i,
  input  logic             instr_will_retire_i,

  // MEM/WB - Stage
  input  logic [RALEN-1:0] regdest_r_i,
  input  logic             lsu_ctrl_valid_r_i,
  input  logic [XLEN-1:0]  alu_res_r_i,
  input  logic             load_addr_misaligned_i,
  input  logic             load_access_fault_i,
  input  logic             store_addr_misaligned_i,
  input  logic             store_access_fault_i,
  input  logic [XLEN-1:0]  lsu_exc_addr_i,
  input  logic             csr_valid_r_i,
  input  logic [11:0]      csr_addr_r_i,
  input  csr_cmd_t         csr_cmd_r_i,

  output logic [XLEN-1:0]  csr_value_o,
  output logic [RALEN-1:0] csr_regdest_o,
  output logic             csr_wb_o,

  output logic             instr_retiring_o,
  output logic             stall_ex_o,
  output logic             stall_mem_wb_o,
  output logic             flush_ex_o,
  output logic             flush_mem_wb_o,
  output logic             stop_jmp_write_o,

  output logic [XLEN-1:0]  program_counter_o,

  output logic             jmp_addr_valid_o,
  output logic [XLEN-3:0]  jmp_addr_o,

  input  logic             irq_external_i,
  input  logic             irq_timer_i,
  input  logic             irq_sw_i,
  input  logic             irq_lcofi_i,
  input  logic [15:0]      irq_platform_i,
  input  logic             irq_nmi_i,

  `ifdef RVFI
  output rvfi_csr_t rvfi_csr_rdata,
  output rvfi_csr_t rvfi_csr_rmask,
  output rvfi_csr_t rvfi_csr_wdata,
  output rvfi_csr_t rvfi_csr_wmask,
 `endif

  output logic synhr_trap_o
);
  typedef enum logic [3:0] {
      eRESET,
      eBOOT0,
      eBOOT1,
      eJUMP0,
      eJUMP1,
      eRUN,
      eLOAD,   // loading a value from data mem to a register.
      eBRANCH,
      eTRAP,
      eMRET
  } rvj1_fsm_e;
  rvj1_fsm_e state, state_next;

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
  miep_reg_t       mip_d, mip_q;
  assign mie_q = '0; // TODO
  logic [XLEN-3:0] mtvec_d, mtvec_q; // only direct mode supported
  logic [XLEN-3:0] mepc_d, mepc_q;
  logic [5:0]      mcause_d, mcause_q, trap_cause, trap_cause_r; // 1 bit for IRQ/EXC, 5 bits-code=>log2(19)=4.24
  logic [XLEN-1:0] mtval_d, mtval_q;
  logic [XLEN-1:0] mscratch_d, mscratch_q;

  logic mstatus_ce, mie_ce, mip_ce, mtvec_ce, mepc_ce, mcause_ce, mtval_ce, mscratch_ce;
  logic csr_valid_write;
  logic csr_valid_read;

  // full output values of registers
  logic [XLEN-1:0] csr_mstatus_value, csr_mstatus_masked;
  logic [XLEN-1:0] csr_mie_value, csr_mie_masked;
  logic [XLEN-1:0] csr_mip_value, csr_mip_masked;
  logic [XLEN-1:0] csr_mtvec_value, csr_mtvec_masked;
  logic [XLEN-1:0] csr_mepc_value, csr_mepc_masked;
  logic [XLEN-1:0] csr_mcause_value, csr_mcause_masked;
  logic [XLEN-1:0] csr_mtval_value, csr_mtval_masked;
  logic [XLEN-1:0] csr_mscratch_value;

  logic [XLEN-1:0] csr_value;

  // Other defintions
  logic rf_a_hazard;
  logic rf_b_hazard;
  logic lsu_b_hazard;
  logic lsu_busy_hazard;
  logic csr_write_hazard;
  logic csr_write_hazard_r;
  logic load, loaded, jump, branch, takebr, nobr, mret;
  branch_ctrl_e ctrl_branch_type_r;
  logic cond_met;
  logic synhr_trap, lsu_trap, addr_unaligned_trap;
  logic synhr_trap_ex, synhr_trap_ex_r;
  logic synhr_trap_mem_wb, synhr_trap_mem_wb2;
  logic instr_will_retire, instr_will_retire_r;
  logic pc_change;
  logic [XLEN-3:0] program_counter, program_counter_prev, program_counter_next;
  logic instr_addr_misaligned;
  logic ecall_insn;
  logic ebreak_insn, ebreak_insn_r;
  logic ctrl_jump;
  logic illegal_csr_insn, illegal_csr_addr;
  logic illegal_instr;
  logic instr_fetch_error;
  logic stall_ex_o_r;
  logic sys_insns;
  logic csr_mod_insns;

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
  * Stalling logic
  *************************************/
  register stall_ex_reg (.clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(stall_ex_o), .out(stall_ex_o_r));
  assign rf_a_hazard = ((regdest_r_i == rf_addr_a_i) &&
                         ~rpa_or_pc_i  &&
                        (rf_addr_a_i != 5'b00000) &&
                        ~stall_ex_o_r
                        );
  assign rf_b_hazard = ((regdest_r_i == rf_addr_b_i) &&
                         ~rpb_or_imm_i &&
                         rf_addr_b_i != 5'b00000 &&
                         ~stall_ex_o_r);
  // LSU uses rpb port, even though an immediate is used.
  // Because of this rf_b_hazard does not trigger.
  assign lsu_b_hazard = ((regdest_r_i == rf_addr_b_i) &&
                          lsu_ctrl_valid_i &&
                          lsu_cmd_i[3] && // is_write
                         (rf_addr_b_i != 5'b00000) &&
                          ~stall_ex_o_r);
  assign lsu_busy_hazard = lsu_ctrl_valid_r_i && ~lsu_ready_i;
  assign sys_insns = mret_insn_i || ecall_insn_i || ebreak_insn_i;
  assign csr_mod_insns = sys_insns || illegal_instr_i || instr_fetch_error_i;
  register csr_stall_reg (.clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(csr_write_hazard), .out(csr_write_hazard_r));
  assign csr_write_hazard = (csr_valid_r_i &&
                             csr_mod_insns &&
                             ~csr_write_hazard_r);
  assign stall_mem_wb_o = (lsu_busy_hazard ||
                          (state == eJUMP1) ||
                          (state == eTRAP));
  assign stall_ex_o = (rf_a_hazard  ||
                       rf_b_hazard  ||
                       lsu_b_hazard ||
                       csr_write_hazard ||
                       stall_mem_wb_o ||
                       (state == eLOAD) ||
                       (state == eJUMP0) ||
                       (state == eJUMP1) ||
                       (state == eTRAP) ||
                       (state == eMRET));
  assign flush_ex_o = ((state == eJUMP0) ||
                       (state == eTRAP) ||
                       (state == eMRET));
  assign flush_mem_wb_o = (flush_ex_o ||
                          (lsu_ctrl_valid_r_i && lsu_ready_i && (state == eLOAD)) || // flush so each cmd used only once
                          (~control_i && ~stall_ex_o));

  /*************************************
  * Jumping logic
  *************************************/
  assign jmp_addr_valid_o = (((state == eJUMP0) && ~instr_addr_misaligned) ||
                             (state == eBOOT0) ||
                             (state == eTRAP)  ||
                             (state == eMRET));
  assign stop_jmp_write_o = instr_addr_misaligned;
  always_comb begin
    jmp_addr_o = '0;
    if (state == eJUMP0)
      jmp_addr_o = alu_res_r_i[31:2];
    else if (state == eTRAP)
      jmp_addr_o = csr_mtvec_value[31:2];
    else if (state == eMRET)
      jmp_addr_o = csr_mepc_value[31:2];
    else
      jmp_addr_o = BOOT_ADDR[31:2];
  end

  /*************************************
  * Program Counter
  *************************************/
  assign pc_change = (state == eJUMP0) ||
                      synhr_trap ||
                      mret ||
                      instr_will_retire ||
                      ctrl_jump ||
                      loaded;
  always_comb begin
    program_counter_next = program_counter;
    if (synhr_trap)
      program_counter_next = csr_mtvec_value[31:2];
    else if (mret)
      program_counter_next = csr_mepc_value[31:2];
    else if (state == eJUMP0)
      program_counter_next = alu_res_r_i[31:2];
    else if (instr_will_retire || ctrl_jump || loaded)
      program_counter_next = program_counter + 1;  // ctrl_jump - gives us pc + 4 on JAL & JALR
  end
  register #(
    .DTYPE(logic [XLEN-3:0]),
    .RESET_VALUE(BOOT_ADDR[31:2])
  ) program_counter_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (pc_change),
    .in   (program_counter_next),
    .out  (program_counter)
  );
  assign program_counter_o = {program_counter, 2'b00};
  // TODO: Is there anyway to get rid of this extra state?
  // This is here because we need mepc on write misalign trap
  // Tega se znebimo tak da vse izjeme obravnavamo v istem delu cevovoda
  register #(
    .DTYPE(logic [XLEN-3:0]),
    .RESET_VALUE(BOOT_ADDR[31:2])
  ) program_counter_prev_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (pc_change),
    .in   (program_counter),
    .out  (program_counter_prev)
  );

  /*************************************
  * Traps
  *************************************/
  assign ecall_insn        = ecall_insn_i        && ~stall_ex_o;
  assign ctrl_jump         = ctrl_jump_i         && ~stall_ex_o;
  assign instr_will_retire = instr_will_retire_i && ~stall_ex_o;
  assign ebreak_insn       = ebreak_insn_i       && ~stall_ex_o;
  assign illegal_instr     = illegal_instr_i     && ~stall_ex_o;
  assign illegal_csr_insn  = illegal_csr_addr    && csr_valid_r_i && ~stall_ex_o;
  assign instr_fetch_error = instr_fetch_error_i && ~stall_ex_o;

  assign addr_unaligned_trap = load_addr_misaligned_i || store_addr_misaligned_i;
  // TODO: store_acess_fault should be routed to an IRQ
  assign lsu_trap = load_access_fault_i || store_access_fault_i;
  assign instr_addr_misaligned = alu_res_r_i[1] && (state == eJUMP0);

  register ebreak_insn_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(ebreak_insn), .out(ebreak_insn_r)
  );

  assign synhr_trap_ex = (ecall_insn ||
                          ebreak_insn ||
                          illegal_instr ||
                          instr_fetch_error);
  register synhr_trap_ex_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(synhr_trap_ex), .out(synhr_trap_ex_r)
  );
  assign synhr_trap_mem_wb = (lsu_trap ||
                              illegal_csr_insn ||
                              instr_addr_misaligned ||
                              addr_unaligned_trap);
  assign synhr_trap_mem_wb2 = (lsu_trap || load_addr_misaligned_i);
  assign synhr_trap = synhr_trap_ex_r || synhr_trap_mem_wb;
  `ifdef RVFI
  assign synhr_trap_o = synhr_trap;
  `endif

  `ifdef ASSERTIONS
    `ASSERT_SINGLE_CYCLE_HOLD(ecall_insn);
    `ASSERT_SINGLE_CYCLE_HOLD(lsu_trap);
    `ASSERT_SINGLE_CYCLE_HOLD(addr_unaligned_trap);
    `ASSERT_SINGLE_CYCLE_HOLD(instr_addr_misaligned);
    `ASSERT_SINGLE_CYCLE_HOLD(illegal_instr);
    `ASSERT_SINGLE_CYCLE_HOLD(ebreak_insn);
    `ASSERT_SINGLE_CYCLE_HOLD(illegal_csr_insn);
    `ASSERT_SINGLE_CYCLE_HOLD(instr_fetch_error);
  `endif

  always_comb begin
    trap_cause = 6'b0;
    if (ecall_insn)
      trap_cause = MCAUSE_ECALL_FROM_M_MODE;
    else if (instr_fetch_error)
      trap_cause = MCAUSE_INSTR_ACCESS_FAULT;
    else if (illegal_instr || illegal_csr_insn)
      trap_cause = MCAUSE_ILLEGAL_INSTRUCTION;
    else if (ebreak_insn)
      trap_cause = MCAUSE_BREAKPOINT;
    else if (load_addr_misaligned_i)
      trap_cause = MCAUSE_LOAD_ADDR_MISALIGNED;
    else if (store_addr_misaligned_i)
      trap_cause = MCAUSE_STORE_ADDR_MISALINGED;
    else if (load_access_fault_i)
      trap_cause = MCAUSE_LOAD_ACCESS_FAULT;
    else if (store_access_fault_i)
      trap_cause = MCAUSE_STORE_ACCESS_FAULT;
    else if (instr_addr_misaligned)
      trap_cause = MCAUSE_INSTR_ADDR_MISALIGNED;
  end
  register #(.DTYPE(logic [5:0])) trap_cause_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (1'b1),
    .in   (trap_cause),
    .out  (trap_cause_r)
  );

  /*************************************
  * Branching conditions - TODO: Move this to ALU?
  *************************************/
  always_comb begin
    cond_met = 1'b0;
    unique case (ctrl_branch_type_r)
      BRANCH_EQ:  cond_met = (alu_res_r_i    == 0   );
      BRANCH_NEQ: cond_met = (alu_res_r_i    != 0   );
      BRANCH_LT:  cond_met = (alu_res_r_i[0] == 1'b1);
      BRANCH_GE:  cond_met = (alu_res_r_i[0] == 1'b0);
      BRANCH_LTU: cond_met = (alu_res_r_i[0] == 1'b1);
      BRANCH_GEU: cond_met = (alu_res_r_i[0] == 1'b0);
    endcase
  end
  register #(
    .DTYPE(branch_ctrl_e),
    .RESET_VALUE(BRANCH_EQ)
  ) ctrl_branch_type_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (ctrl_branch_i),
    .in   (ctrl_branch_type_i),
    .out  (ctrl_branch_type_r)
  );

  /*************************************
  * Retiring
  *************************************/
  register insn_retire_reg (
    .clk (clk_i),
    .rstn(rstn_i && ~(state == eTRAP)),
    .ce  (~stall_mem_wb_o),
    .in  (instr_will_retire && ~stall_ex_o),
    .out (instr_will_retire_r)
  );
  assign instr_retiring_o = (instr_will_retire_r && ~stall_mem_wb_o) || loaded;

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
      ({31'b0, mip_q.msi}   << CSR_MIEP_MSI_BIT)
    | ({31'b0, mip_q.mti}   << CSR_MIEP_MTI_BIT)
    | ({31'b0, mip_q.mei}   << CSR_MIEP_MEI_BIT)
    | ({31'b0, mip_q.lcofi} << CSR_MIEP_LCOFI_BIT)
    | ({16'b0, mip_q.irqs}  << CSR_MIEP_PLATFORM_IRQS_BIT)
    | 32'b0
  );
  assign csr_mepc_value     = {mepc_q, 2'b00}; // IALIGN=32
  assign csr_mtvec_value    = {mtvec_q, 2'b00}; // direct mode only! (no vector irqs)
  assign csr_mcause_value   = {mcause_q[5], 26'b0, mcause_q[4:0]};
  assign csr_mtval_value    = mtval_q;
  assign csr_mscratch_value = mscratch_q;

  // csr_valid_r does not need stall control as stall is already applied at the
  // pipeline register (_r)
  assign csr_value_o = csr_value;
  assign csr_regdest_o = regdest_r_i;
  assign csr_wb_o = csr_valid_r_i && ~stall_mem_wb_o;


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

   // Read logic
  always_comb begin
    csr_value = '0;
    illegal_csr_addr = 1'b0;
    // ONLY implemented registers, others default to zero
    if (csr_valid_read) begin
      unique case (csr_addr_r_i)
        // Machine Information Registers
        CSR_MVENDORID_ADDR: csr_value = CSR_MVENDORID_VALUE;
        CSR_MARCHID_ADDR:   csr_value = CSR_MARCHID_VALUE;
        CSR_MIMPID_ADDR:    csr_value = CSR_MIMPID_VALUE;
        CSR_MHARTID_ADDR:   csr_value = CSR_MHARTID_VALUE;

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
        default:             illegal_csr_addr = 1'b1;
      endcase
    end
  end

  // Write logic
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
    if (synhr_trap) begin
      mcause_d = synhr_trap_ex_r ? trap_cause_r : trap_cause;
      mcause_ce = 1'b1;
      mepc_d = synhr_trap_mem_wb2 ? program_counter : program_counter_prev;
      mepc_ce = 1'b1;
      mstatus_d.mie = 1'b0;
      mstatus_d.mpie = mstatus_q.mie;
      mstatus_d.mpp = 1'b1;
      mstatus_ce = 1'b1;
      if (lsu_trap)
        mtval_d = lsu_exc_addr_i;
      else if (addr_unaligned_trap || instr_addr_misaligned)
        mtval_d = alu_res_r_i;
      else if (ebreak_insn_r)
        mtval_d = {program_counter_prev, 2'b00};
      else
        mtval_d = '0;
      mtval_ce = 1'b1;
    end
    else if (state == eMRET) begin
      mstatus_d.mie = mstatus_q.mpie;
      mstatus_d.mpie = 1'b1;
      mstatus_ce = 1'b1;
    end
    else if (csr_valid_write) begin
      unique case (csr_addr_r_i)
        CSR_MSTATUS_ADDR: begin
          // Will the synthesis tool optimize these two function calls into a single module?
          csr_mstatus_masked = csr_mask_op(alu_res_r_i, csr_mstatus_value, csr_cmd_r_i);
          mstatus_d.mie = csr_mstatus_masked[CSR_MSTATUS_MIE_BIT];
          mstatus_d.mpie = csr_mstatus_masked[CSR_MSTATUS_MPIE_BIT];
          mstatus_d.mpp = csr_mstatus_masked[CSR_MSTATUS_MPP_BIT_0]; // WARL
          mstatus_ce = 1'b1;
        end
        CSR_MSCRATCH_ADDR: begin
          mscratch_d = csr_mask_op(alu_res_r_i, csr_mscratch_value, csr_cmd_r_i);
          mscratch_ce = 1'b1;
        end
        CSR_MTVEC_ADDR: begin
          csr_mtvec_masked = csr_mask_op(alu_res_r_i, csr_mtvec_value, csr_cmd_r_i);
          mtvec_d = csr_mtvec_masked[31:2];
          mtvec_ce = 1'b1;
        end
        CSR_MEPC_ADDR: begin
          csr_mepc_masked = csr_mask_op(alu_res_r_i, csr_mepc_value, csr_cmd_r_i);
          mepc_d = csr_mepc_masked[31:2];
          mepc_ce = 1'b1;
        end
        CSR_MCAUSE_ADDR: begin
          csr_mcause_masked = csr_mask_op(alu_res_r_i, csr_mcause_value, csr_cmd_r_i);
          mcause_d = {csr_mcause_masked[31], csr_mcause_masked[4:0]};
          mcause_ce = 1'b1;
        end
        CSR_MTVAL_ADDR: begin
          csr_mtval_masked = csr_mask_op(alu_res_r_i, csr_mtval_value, csr_cmd_r_i);
          mtval_d = csr_mtval_masked;
          mtval_ce = 1'b1;
        end
        default:;
      endcase
    end
  end

  `ifdef ASSERTIONS
    `ASSERT_SINGLE_CYCLE_HOLD(mstatus_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mie_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mip_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mtval_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mcause_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mepc_ce);
    `ASSERT_SINGLE_CYCLE_HOLD(mscratch_ce);
  `endif

  assign mip_d = '{
    msi:irq_sw_i,
    mti:irq_timer_i,
    mei:irq_external_i,
    lcofi:irq_lcofi_i,
    irqs:irq_platform_i
  };
  register #(
    .DTYPE(miep_reg_t),
    .RESET_VALUE(0)
  ) csr_mip_reg (
    .clk (clk_i),
    .rstn(rstn_i),
    .ce  (1'b1),
    .in  (mip_d),
    .out (mip_q)
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
    .DTYPE(logic [XLEN-3:0]),
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
    .DTYPE(logic [5:0]),
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

  /*************************************
  * Finite State Machine (FSM)
  *************************************/
  always_comb begin
    load    = (state == eRUN)    &&  lsu_ctrl_valid_i && ~lsu_cmd_i[3] && ~stall_ex_o;
    loaded  = (state == eLOAD)   &&  lsu_wb_i;
    jump    = (state == eRUN)    &&  ctrl_jump_i                       && ~stall_ex_o;
    branch  = (state == eRUN)    &&  ctrl_branch_i                     && ~stall_ex_o;
    takebr  = (state == eBRANCH) &&  cond_met                          && ~stall_ex_o;
    nobr    = (state == eBRANCH) && ~cond_met                          && ~stall_ex_o;
    mret    = (state == eRUN)    &&  mret_insn_i                       && ~stall_ex_o;
  end
  always_comb begin
    state_next = (state == eRESET) ? eBOOT0  : state;
    state_next = (state == eBOOT0) ? eBOOT1  : state_next;
    state_next = (state == eBOOT1) ? eRUN    : state_next;
    state_next = load              ? eLOAD  : state_next;
    state_next = loaded            ? eRUN    : state_next;
    state_next = jump              ? eJUMP0  : state_next;
    state_next = (state == eJUMP0) ? eJUMP1  : state_next;
    state_next = (state == eJUMP1) ? eRUN    : state_next;
    state_next = branch            ? eBRANCH : state_next;
    state_next = takebr            ? eJUMP0  : state_next;
    state_next = nobr              ? eRUN    : state_next;
    state_next = synhr_trap        ? eTRAP   : state_next;
    state_next = (state == eTRAP)  ? eRUN    : state_next;
    state_next = mret              ? eMRET   : state_next;
    state_next = (state == eMRET)  ? eRUN    : state_next;
  end
  register #(
    .DTYPE(rvj1_fsm_e),
    .RESET_VALUE(eRESET)
  ) state_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (1'b1),
    .in   (state_next),
    .out  (state)
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
  assign rvfi_csr_wmask.mip = mip_ce ? '1 : '0;
  assign rvfi_csr_wdata.mip = ({31'b0, mie_d.msi}   << CSR_MIEP_MSI_BIT)
                            | ({31'b0, mie_d.mti}   << CSR_MIEP_MTI_BIT)
                            | ({31'b0, mie_d.mei}   << CSR_MIEP_MEI_BIT)
                            | ({31'b0, mie_d.lcofi} << CSR_MIEP_LCOFI_BIT)
                            | ({16'b0, mie_d.irqs}  << CSR_MIEP_PLATFORM_IRQS_BIT)
                            | 32'b0;

  assign rvfi_csr_rmask.mtvec = '1;
  assign rvfi_csr_rdata.mtvec = csr_mtvec_value;
  assign rvfi_csr_wmask.mtvec = mtvec_ce ? '1 : '0;
  assign rvfi_csr_wdata.mtvec = {mtvec_d, 2'b00};

  assign rvfi_csr_rmask.mepc = '1;
  assign rvfi_csr_rdata.mepc = csr_mepc_value;
  assign rvfi_csr_wmask.mepc = mepc_ce ? '1 : '0;
  assign rvfi_csr_wdata.mepc = {mepc_d, 2'b00};

  assign rvfi_csr_rmask.mcause = '1;
  assign rvfi_csr_rdata.mcause = csr_mcause_value;
  assign rvfi_csr_wmask.mcause = mcause_ce ? '1 : '0;
  assign rvfi_csr_wdata.mcause = {mcause_d[5], 26'b0, mcause_d[4:0]};

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
