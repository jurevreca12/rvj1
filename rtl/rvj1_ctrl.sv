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
module rvj1_ctrl import rvj1_pkg::*; #(
  parameter int unsigned BootAddr   = 32'h8000_0000,
  parameter int unsigned DmRomAddr  = 32'h0000_0000,
  parameter int unsigned MVendorId  = 32'h0000_0000,
  parameter int unsigned MArchId    = 32'h0000_0000,
  parameter int unsigned MImpId     = 32'h0000_0000,
  parameter int unsigned MHartId    = 32'h0000_0000,
  parameter int unsigned MConfigPtr = 32'h0000_0000
)
(
  input logic clk_i,
  input logic rstn_i,

  // EX - Stage
  input  logic [RALEN-1:0] rf_addr_a_i,
  input  logic [RALEN-1:0] rf_addr_b_i,
  input  logic             rpa_or_pc_i,
  input  logic             rpb_or_imm_i,
  input  lsu_ctrl_e        lsu_cmd_i,
  input  logic             lsu_ctrl_valid_i,
  input  logic             lsu_ready_i,
  input  logic             lsu_wb_i,
  input  logic             ctrl_jump_i,
  input  logic             ecall_insn_i,
  input  logic             mret_insn_i,
  input  logic             ebreak_insn_i,
  input  logic             dret_insn_i,
  input  logic             illegal_insn_i,

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
  input  logic             branch_cond_met_i,
  input  logic [XLEN-1:0]  lsu_exc_addr_i,

  input  logic             irq_external_i,
  input  logic             irq_timer_i,
  input  logic             irq_sw_i,
  input  logic             irq_lcofi_i,
  input  logic [15:0]      irq_platform_i,
  input  logic             irq_nmi_i,

  input  logic             debug_req_i,
  output logic             debug_rsp_o,

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

  `ifdef RVFI
  output rvfi_csr_t rvfi_csr_rdata,
  output rvfi_csr_t rvfi_csr_rmask,
  output rvfi_csr_t rvfi_csr_wdata,
  output rvfi_csr_t rvfi_csr_wmask,

  output logic exception_o,
 `endif
);
  //`STATIC_ASSERT(DmRomAddr[1:0] == 2'b00);
  rvj1_op_mode_e cpu_mode, cpu_mode_next;
  rvj1_fsm_e state, state_next;

  // Other defintions
  logic rf_a_hazard;
  logic rf_b_hazard;
  logic lsu_b_hazard;
  logic lsu_busy;
  logic csr_write_hazard, csr_write_hazard_r;
  logic raw_hazard;
  logic load, loaded, jump, takebr, mret;
  logic exception, exc_lsu_access_fault, exc_lsu_addr_unalign;
  logic exc_exec_stage, exc_exec_stage_r;
  logic exc_mem_wb_stage, exc_mem_wb_stage2;
  logic instr_will_retire, instr_will_retire_r;
  logic pc_mod;
  logic [XLEN-3:0] program_counter, program_counter_prev, program_counter_next;
  logic exc_jmp_addr_misalign;
  logic ecall_insn;
  logic ebreak_insn;
  logic dret_insn;
  logic illegal_csr_insn;
  logic ebreak_todbg, ebreak_todbg_r, dret_fromdbg, dret_fromdbg_r;
  logic ebreak_totrp, ebreak_totrp_r;
  logic step_todrain;
  logic step_todbg, step_todbg_r;
  logic ext_dbg_req, ext_dbg_req_r;
  logic enter_debug;
  logic valid_jump;

  logic illegal_insn;
  logic instr_fetch_error;
  logic stall_ex_o_r;
  logic csr_mod_insns;
  logic [5:0] exc_cause, exc_cause_r;
  logic illegal_csr_write;
  logic nonexist_csr_access; 
  logic debug_csr_access_err;
  logic rf_a_reg_match, rf_b_reg_match;

  dcsr_reg_t dcsr_q;
  logic [XLEN-1:0] csr_dpc_value;
  logic [XLEN-1:0] csr_mepc_value;
  logic [XLEN-1:0] csr_mtvec_value;

  /*************************************
  * Stalling logic
  *************************************/
  assign rf_a_reg_match = (regdest_r_i == rf_addr_a_i) && (rf_addr_a_i != 5'b00000);
  assign rf_b_reg_match = (regdest_r_i == rf_addr_b_i) && (rf_addr_b_i != 5'b00000);
  assign rf_a_hazard    = rf_a_reg_match && ~rpa_or_pc_i  && ~stall_ex_o_r;
  assign rf_b_hazard    = rf_b_reg_match && ~rpb_or_imm_i && ~stall_ex_o_r;
  // LSU uses rpb port, even though an immediate is used because of this rf_b_hazard does not trigger.
  // lsu_cmd_i == is_write
  assign lsu_b_hazard     = rf_b_reg_match && lsu_ctrl_valid_i && lsu_cmd_i[3] && ~stall_ex_o_r;
  assign csr_mod_insns    = mret_insn_i || ecall_insn_i || ebreak_insn_i || illegal_insn_i || instr_fetch_error_i;
  assign csr_write_hazard = (csr_valid_r_i && csr_mod_insns && ~csr_write_hazard_r); 
  assign raw_hazard       = rf_a_hazard || rf_b_hazard || lsu_b_hazard || csr_write_hazard;
  
  assign lsu_busy       = lsu_ctrl_valid_r_i && ~lsu_ready_i;
  assign stall_mem_wb_o = lsu_busy || (state == eJUMP1) || (state == eEXC);
  assign stall_ex_o     = (raw_hazard ||
                           stall_mem_wb_o ||
                           (state == eLOAD) ||
                           (state == eJUMP0) ||
                           (state == eJUMP1) ||
                           (state == eEXC) ||
                           (state == eMRET) ||
                           (state == eTO_DEBUG) ||
                           dret_fromdbg_r);
  assign flush_ex_o     = ((state == eJUMP0) ||
                           (state == eEXC) ||
                           (state == eMRET) ||
                           (state == eTO_DEBUG) ||
                           step_todbg ||
                           dret_fromdbg_r);
  assign flush_mem_wb_o = (flush_ex_o ||
                          (lsu_ctrl_valid_r_i && lsu_ready_i && (state == eLOAD)) || // flush so each cmd used only once
                          (~control_i && ~stall_ex_o));

  /*************************************
  *  Program Counter - Jumping logic
  *************************************/
  assign pc_mod           = (exception || mret || (state == eJUMP0) ||  enter_debug || 
                            dret_fromdbg ||  instr_will_retire || jump || loaded);
  assign valid_jump       = (state == eJUMP1) && ~exc_jmp_addr_misalign;  
  assign stop_jmp_write_o = exc_jmp_addr_misalign;
  assign jmp_addr_o       = (jmp_addr_valid_o) ? program_counter : '0;
  assign jmp_addr_valid_o = ((state == eBOOT0) || (state == eEXC) || (state == eMRET) || valid_jump ||
                            ext_dbg_req_r || ebreak_todbg_r || step_todbg_r || dret_fromdbg_r);
  always_comb begin
    program_counter_next = program_counter;
    if (enter_debug)
      program_counter_next = DmRomAddr[31:2];
    else if (exception)
      program_counter_next = csr_mtvec_value[31:2];
    else if (mret)
      program_counter_next = csr_mepc_value[31:2];
    else if (state == eJUMP0)
      program_counter_next = alu_res_r_i[31:2];
    else if (dret_fromdbg)
      program_counter_next = csr_dpc_value[31:2];
    else if (instr_will_retire || jump || loaded)
      program_counter_next = program_counter + 1;  // jump - gives us pc + 4 on JAL & JALR
  end
  

  assign program_counter_o = {program_counter, 2'b00};


  /*************************************
  * Exceptions
  *************************************/
  assign ecall_insn        = ecall_insn_i        && ~stall_ex_o;
  assign instr_will_retire = instr_will_retire_i && ~stall_ex_o;
  assign ebreak_insn       = ebreak_insn_i       && ~stall_ex_o;
  assign dret_insn         = dret_insn_i         && ~stall_ex_o;
  assign illegal_insn      = illegal_insn_i      && ~stall_ex_o;
  assign instr_fetch_error = instr_fetch_error_i && ~stall_ex_o;
 
  assign illegal_csr_insn      = nonexist_csr_access || illegal_csr_write || debug_csr_access_err;
  assign exc_lsu_addr_unalign  = load_addr_misaligned_i || store_addr_misaligned_i;
  assign exc_lsu_access_fault  = load_access_fault_i || store_access_fault_i;  // TODO: store_acess_fault should be routed to an IRQ
  assign exc_jmp_addr_misalign = alu_res_r_i[1] && (state == eJUMP0);
  assign exc_exec_stage        = (ecall_insn || illegal_insn || ebreak_totrp || instr_fetch_error);
  assign exc_mem_wb_stage      = (exc_lsu_access_fault || illegal_csr_insn || exc_jmp_addr_misalign || exc_lsu_addr_unalign);
  assign exc_mem_wb_stage2     = (exc_lsu_access_fault || load_addr_misaligned_i);
  assign exception             = exc_exec_stage_r || exc_mem_wb_stage;
  `ifdef RVFI
  assign exception_o = exception;
  `endif
  assign debug_rsp_o = (state == eTO_DEBUG) && ext_dbg_req_r;

  always_comb begin
    exc_cause = 6'b0;
    if (ecall_insn)
      exc_cause = MCAUSE_ECALL_FROM_M_MODE;
    else if (instr_fetch_error)
      exc_cause = MCAUSE_INSTR_ACCESS_FAULT;
    else if (illegal_insn || illegal_csr_insn)
      exc_cause = MCAUSE_ILLEGAL_INSTRUCTION;
    else if (ebreak_insn)
      exc_cause = MCAUSE_BREAKPOINT;
    else if (load_addr_misaligned_i)
      exc_cause = MCAUSE_LOAD_ADDR_MISALIGNED;
    else if (store_addr_misaligned_i)
      exc_cause = MCAUSE_STORE_ADDR_MISALINGED;
    else if (load_access_fault_i)
      exc_cause = MCAUSE_LOAD_ACCESS_FAULT;
    else if (store_access_fault_i)
      exc_cause = MCAUSE_STORE_ACCESS_FAULT;
    else if (exc_jmp_addr_misalign)
      exc_cause = MCAUSE_INSTR_ADDR_MISALIGNED;
  end

  `ifdef ASSERTIONS
    `ASSERT_SINGLE_CYCLE_HOLD(ecall_insn);
    `ASSERT_SINGLE_CYCLE_HOLD(exc_lsu_access_fault);
    `ASSERT_SINGLE_CYCLE_HOLD(exc_lsu_addr_unalign);
    `ASSERT_SINGLE_CYCLE_HOLD(exc_jmp_addr_misalign);
    `ASSERT_SINGLE_CYCLE_HOLD(illegal_insn);
    `ASSERT_SINGLE_CYCLE_HOLD(ebreak_insn);
    `ASSERT_SINGLE_CYCLE_HOLD(illegal_csr_insn);
    `ASSERT_SINGLE_CYCLE_HOLD(instr_fetch_error);
  `endif

  /*************************************
  * Retiring
  *************************************/
  assign instr_retiring_o = (instr_will_retire_r && ~stall_mem_wb_o) || loaded;


  /*************************************
  * CSR
  *************************************/
  rvj1_csr #(
    .MVendorId  (MVendorId),
    .MArchId    (MArchId),
    .MImpId     (MImpId),
    .MHartId    (MHartId),
    .MConfigPtr (MConfigPtr)
  ) csr_inst (
    .clk_i                   (clk_i),
    .rstn_i                  (rstn_i),

    .csr_valid_r_i           (csr_valid_r_i),
    .csr_addr_r_i            (csr_addr_r_i),
    .csr_cmd_r_i             (csr_cmd_r_i),

    .cpu_mode_i              (cpu_mode),
    .state_i                 (state),
    .ebreak_todbg_i          (ebreak_todbg),
    .step_todrain_i          (step_todrain),
    .ext_dbg_req_i           (ext_dbg_req),
    .exception_i            (exception),
    .exc_exec_stage_r_i      (exc_exec_stage_r),
    .exc_mem_wb_stage2_i     (exc_mem_wb_stage2),
    .exc_lsu_access_fault_i  (exc_lsu_access_fault),
    .lsu_exc_addr_i          (lsu_exc_addr_i),
    .exc_cause_i             (exc_cause),
    .exc_cause_r_i           (exc_cause_r),
    .exc_lsu_addr_unalign_i  (exc_lsu_addr_unalign),
    .exc_jmp_addr_misalign_i (exc_jmp_addr_misalign),
    .ebreak_totrp_r_i        (ebreak_totrp_r),
    .program_counter_i       (program_counter),
    .program_counter_prev_i  (program_counter_prev),
    .alu_res_r_i             (alu_res_r_i),
    .regdest_r_i             (regdest_r_i),
    .stall_mem_wb_i          (stall_mem_wb_o),

    .illegal_csr_write_o     (illegal_csr_write), 
    .nonexist_csr_access_o   (nonexist_csr_access), 
    .debug_csr_access_err_o  (debug_csr_access_err),

    .irq_external_i,
    .irq_timer_i,
    .irq_sw_i,
    .irq_lcofi_i,
    .irq_platform_i,
    .irq_nmi_i,

    .dcsr_o                  (dcsr_q),
    .csr_dpc_value_o         (csr_dpc_value),
    .csr_mepc_value_o        (csr_mepc_value),
    .csr_mtvec_value_o       (csr_mtvec_value),
    .csr_value_o             (csr_value_o),
    .csr_regdest_o           (csr_regdest_o),
    .csr_wb_o                (csr_wb_o)

    `ifdef RVFI
    ,.rvfi_csr_rdata         (rvfi_csr_rdata),
     .rvfi_csr_rmask         (rvfi_csr_rmask),
     .rvfi_csr_wdata         (rvfi_csr_wdata),
     .rvfi_csr_wmask         (rvfi_csr_wmask)
    `endif
  );

  /*************************************
  * Finite State Machine (FSM)
  *************************************/
  always_comb begin
    load         = (state == eRUN)    &&  lsu_ctrl_valid_i && ~lsu_cmd_i[3]      && ~stall_ex_o;
    loaded       = (state == eLOAD)   &&  lsu_wb_i;
    jump         = (state == eRUN)    &&  ctrl_jump_i                            && ~stall_ex_o;
    takebr       = (state == eRUN)    &&  branch_cond_met_i                      && ~stall_ex_o;
    mret         = (state == eRUN)    &&  mret_insn_i                            && ~stall_ex_o;
    ext_dbg_req  = (state == eRUN)    && (cpu_mode == eMODE_NORM) && debug_req_i && ~stall_ex_o;
    ebreak_todbg = (state == eRUN)    &&  ebreak_insn && (dcsr_q.ebreakm || (cpu_mode == eMODE_DEBUG)) && ~stall_ex_o;
    // EBREAK causes a trap only if ebreakm is 0
    ebreak_totrp = (state == eRUN)    &&  ebreak_insn && ~dcsr_q.ebreakm && (cpu_mode != eMODE_DEBUG)  && ~stall_ex_o;
    step_todrain = (state == eRUN)    && (cpu_mode == eMODE_NORM) && control_i && dcsr_q.step && ~stall_ex_o;
    step_todbg   = (cpu_mode == eMODE_DRAIN)  &&  instr_retiring_o;
    enter_debug  = ext_dbg_req || ebreak_todbg || step_todbg;
  end
  always_comb begin
    state_next = (state == eRESET)    ? eBOOT0     : state;
    state_next = (state == eBOOT0)    ? eBOOT1     : state_next;
    state_next = (state == eBOOT1)    ? eRUN       : state_next;
    state_next = load                 ? eLOAD      : state_next;
    state_next = loaded               ? eRUN       : state_next;
    state_next = jump                 ? eJUMP0     : state_next;
    state_next = (state == eJUMP0)    ? eJUMP1     : state_next;
    state_next = (state == eJUMP1)    ? eRUN       : state_next;
    state_next = takebr               ? eJUMP0     : state_next;
    state_next = exception            ? eEXC      : state_next;
    state_next = (state == eEXC)      ? eRUN       : state_next;
    state_next = mret                 ? eMRET      : state_next;
    state_next = (state == eMRET)     ? eRUN       : state_next;
    state_next = enter_debug          ? eTO_DEBUG  : state_next;
    state_next = (state == eTO_DEBUG) ? eRUN       : state_next;
  end

  assign dret_fromdbg = (cpu_mode == eMODE_DEBUG) && dret_insn; 
  always_comb begin
    cpu_mode_next = enter_debug   ? eMODE_DEBUG : cpu_mode;
    cpu_mode_next = step_todrain  ? eMODE_DRAIN : cpu_mode_next;
    cpu_mode_next = step_todbg    ? eMODE_DEBUG : cpu_mode_next;
    cpu_mode_next = dret_fromdbg  ? eMODE_NORM  : cpu_mode_next;
  end

  // REGISTERS
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
  register #(
    .DTYPE(rvj1_op_mode_e),
    .RESET_VALUE(eMODE_NORM)
  ) cpu_mode_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (1'b1),
    .in   (cpu_mode_next),
    .out  (cpu_mode)
  );
  register stall_ex_reg (.clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(stall_ex_o), .out(stall_ex_o_r));
  register csr_stall_reg (.clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(csr_write_hazard), .out(csr_write_hazard_r));
  register ebreak_todbg_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(ebreak_todbg), .out(ebreak_todbg_r)
  );
  register dret_fromdbg_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(dret_fromdbg), .out(dret_fromdbg_r)
  );
  register ext_dbg_req_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(ext_dbg_req), .out(ext_dbg_req_r)
  );
  register step_todbg_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(step_todbg), .out(step_todbg_r)
  );
  register ebreak_totrp_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(ebreak_totrp), .out(ebreak_totrp_r)
  );
  register exc_exec_stage_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(exc_exec_stage), .out(exc_exec_stage_r)
  );
  register #(
    .DTYPE(logic [XLEN-3:0]),
    .RESET_VALUE(BootAddr[31:2])
  ) program_counter_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (pc_mod),
    .in   (program_counter_next),
    .out  (program_counter)
  );
  register #(
    .DTYPE(logic [XLEN-3:0]),
    .RESET_VALUE(BootAddr[31:2])
  ) program_counter_prev_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (pc_mod),
    .in   (program_counter),
    .out  (program_counter_prev)
  );
  register #(.DTYPE(logic [5:0])) exc_cause_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (1'b1),
    .in   (exc_cause),
    .out  (exc_cause_r)
  );
  register insn_retire_reg (
    .clk (clk_i),
    .rstn(rstn_i && ~(state == eEXC)),
    .ce  (~stall_mem_wb_o),
    .in  (instr_will_retire),
    .out (instr_will_retire_r)
  );
  
endmodule
