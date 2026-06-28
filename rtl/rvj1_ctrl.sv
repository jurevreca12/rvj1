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

  input  logic             ext_dbg_req_i,

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

  output logic [XLEN-1:0]  pc_o,

  output logic             jmp_addr_valid_o,
  output logic [XLEN-3:0]  jmp_addr_o

  `ifdef RVFI
  ,output rvfi_csr_t rvfi_csr_rdata,
  output rvfi_csr_t rvfi_csr_rmask,
  output rvfi_csr_t rvfi_csr_wdata,
  output rvfi_csr_t rvfi_csr_wmask,

  output logic exception_o
 `endif
);
  //`STATIC_ASSERT(DmRomAddr[1:0] == 2'b00);
  typedef enum logic [1:0] {
    eRESET,
    eJUMP,
    eRUN,
    eLOAD
  } rvj1_fsm_e;
  rvj1_fsm_e state, state_next;

  // Other defintions
  logic rf_a_hazard;
  logic rf_b_hazard;
  logic lsu_b_hazard;
  logic lsu_busy;
  logic csr_write_hazard, csr_write_hazard_r;
  logic raw_hazard;
  logic loaded;
  logic exception, exc_lsu_access_fault, exc_lsu_addr_unalign;
  logic exc_exec_stage, exc_exec_stage_r;
  logic exc_mem_wb_stage, exc_mem_wb_stage2;
  logic instr_will_retire, instr_will_retire_r;
  logic pc_mod;
  logic [XLEN-3:0] pc, pc_r, pc_next;
  logic exc_jmp_addr_misalign;
  logic ecall_insn;
  logic ebreak_insn, ebreak_insn_r;
  logic dret_insn;
  logic mret_insn;
  logic illegal_csr_insn;
  logic ebreak_todbg, ebreak_todbg_r, dret_fromdbg, dret_fromdbg_r;
  logic ebreak_totrp, ebreak_totrp_r;
  logic step_todrain;
  logic step_todbg, step_todbg_r;
  logic ext_dbg_req_r;
  logic enter_debug;
  logic cancel_retire;
  logic dbg_mode, dbg_mode_next;
  logic drain, drain_next;
  logic [2:0]  dcsr_cause;
  logic [XLEN-3:0] dpc_next;

  logic illegal_insn;
  logic instr_fetch_error;
  logic stall_ex_o_r;
  logic csr_mod_insns;
  logic [5:0] exc_cause, exc_cause_r;
  logic illegal_csr_write;
  logic nonexist_csr_access; 
  logic debug_csr_access_err;
  logic rf_a_reg_match, rf_b_reg_match;
  logic load_insn;
  logic ctrl_jump;
  logic load_exception;

  logic [XLEN-1:0]  exc_mtval;

  logic             csr_exc_write;
  logic [5:0]       csr_exc_mcause;
  logic [XLEN-3:0]  csr_exc_mepc;
  logic [XLEN-1:0]  csr_exc_mtval;
  logic             csr_mret_restore;
  logic             csr_dbg_write;
  logic [2:0]       csr_dbg_cause;
  logic [XLEN-3:0]  csr_dbg_dpc;

  dcsr_reg_t dcsr_q;
  logic [XLEN-1:0] csr_dpc_value;
  logic [XLEN-1:0] csr_mepc_value;
  logic [XLEN-1:0] csr_mtvec_value;

  /*************************************
  * Hazard Detection logic
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
  assign lsu_busy         = lsu_ctrl_valid_r_i && ~lsu_ready_i;


  assign load_insn = lsu_ctrl_valid_i && ~is_write_cmd(lsu_cmd_i) && ~stall_ex_o;

  /*************************************
  * Exceptions
  *************************************/
  assign ecall_insn        = ecall_insn_i        && ~stall_ex_o;
  assign instr_will_retire = instr_will_retire_i && ~stall_ex_o;
  assign ebreak_insn       = ebreak_insn_i       && ~stall_ex_o;
  assign dret_insn         = dret_insn_i         && ~stall_ex_o;
  assign mret_insn         = mret_insn_i         && ~stall_ex_o;
  assign illegal_insn      = illegal_insn_i      && ~stall_ex_o;
  assign instr_fetch_error = instr_fetch_error_i && ~stall_ex_o;
  assign ctrl_jump         = ctrl_jump_i         && ~stall_ex_o;
  
  assign illegal_csr_insn      = nonexist_csr_access || illegal_csr_write || debug_csr_access_err;
  assign exc_lsu_addr_unalign  = load_addr_misaligned_i || store_addr_misaligned_i;
  assign exc_lsu_access_fault  = load_access_fault_i || store_access_fault_i;  // TODO: store_acess_fault should be routed to an IRQ
  assign load_exception        = exc_lsu_addr_unalign | exc_lsu_access_fault;
  assign exc_jmp_addr_misalign = alu_res_r_i[1] && (state == eJUMP);
  assign exc_exec_stage        = (ecall_insn | illegal_insn | ebreak_totrp | instr_fetch_error);
  assign exc_mem_wb_stage      = (exc_lsu_access_fault || illegal_csr_insn || exc_jmp_addr_misalign || exc_lsu_addr_unalign);
  assign exc_mem_wb_stage2     = (exc_lsu_access_fault || load_addr_misaligned_i);
  assign exception             = exc_exec_stage_r || exc_mem_wb_stage;
  `ifdef RVFI
  assign exception_o = exception;
  `endif

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
  * Debug
  *************************************/
  assign ebreak_todbg = ebreak_insn & (dcsr_q.ebreakm | dbg_mode);
  assign ebreak_totrp = ebreak_insn & ~dbg_mode & ~dcsr_q.ebreakm;
  assign step_todrain = dcsr_q.step & ~dbg_mode & ~drain & control_i; 
  assign step_todbg   = dcsr_q.step & drain & instr_will_retire_r;
  assign enter_debug  = ~dbg_mode & (ext_dbg_req_i | ebreak_todbg | step_todbg);
  always_comb begin
    dcsr_cause = '0;
    dpc_next = '0;
    if (ebreak_todbg) begin
      dcsr_cause = DCSR_CAUSE_EBREAK;
      dpc_next   = pc;
    end else if (step_todbg) begin
      dcsr_cause = DCSR_CAUSE_STEP;
      dpc_next   = pc + 1'b1;
    end else if (ext_dbg_req_i) begin 
      dcsr_cause = DCSR_CAUSE_HALTREQ;
      dpc_next   = pc;
    end else begin
      dcsr_cause = '0;
      dpc_next   = '0;
    end
  end

  always_comb begin
    exc_mtval = '0;
    if (exc_lsu_access_fault)
      exc_mtval = lsu_exc_addr_i;
    else if (exc_lsu_addr_unalign || exc_jmp_addr_misalign)
      exc_mtval = alu_res_r_i;
    else if (ebreak_insn_r)
      exc_mtval = {pc_r, 2'b00};
  end

  assign pc_o = {pc, 2'b00};

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
    .alu_res_r_i             (alu_res_r_i),
    .regdest_r_i             (regdest_r_i),

    .csr_exc_write_i         (csr_exc_write),
    .csr_exc_mcause_i        (csr_exc_mcause),
    .csr_exc_mepc_i          (csr_exc_mepc),
    .csr_exc_mtval_i         (csr_exc_mtval),
    .csr_mret_restore_i      (csr_mret_restore),
    .csr_dbg_write_i         (csr_dbg_write),
    .csr_dbg_cause_i         (csr_dbg_cause),
    .csr_dbg_dpc_i           (csr_dbg_dpc),

    .dbg_mode_i              (dbg_mode),
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

  always_comb begin
    pc_next          = pc;
    pc_mod           = 1'b0;
    state_next       = state;
    cancel_retire    = 1'b0;
    jmp_addr_valid_o = 1'b0;
    jmp_addr_o       = '0;
    stall_ex_o       = 1'b0;
    stall_mem_wb_o   = 1'b0;
    flush_ex_o       = 1'b0;
    flush_mem_wb_o   = 1'b0;
    stop_jmp_write_o = 1'b0;
    dbg_mode_next    = dbg_mode;
    loaded           = 1'b0;
    drain_next       = 1'b0;

    csr_exc_write    = 1'b0;
    csr_exc_mcause   = '0;
    csr_exc_mepc     = '0;
    csr_exc_mtval    = '0;
    csr_mret_restore = 1'b0;
    csr_dbg_write    = 1'b0;
    csr_dbg_cause    = '0;
    csr_dbg_dpc      = '0;

    unique case (state)
      eRESET: begin
        state_next       = eRUN;
        pc_next          = BootAddr[31:2];
        pc_mod           = 1'b1;
        jmp_addr_valid_o = 1'b1;
        jmp_addr_o       = BootAddr[31:2];
      end

      eRUN: begin
        stall_ex_o     = raw_hazard | lsu_busy | exception;
        stall_mem_wb_o = lsu_busy;
        flush_ex_o     = exception | mret_insn | enter_debug | dret_insn;
        flush_mem_wb_o = flush_ex_o | (~control_i & ~stall_ex_o); // flush reg stage if nothing new

        if (instr_will_retire) begin
          pc_next = pc + 1; 
          pc_mod  = 1'b1;
        end

        if (branch_cond_met_i) begin
          state_next = eJUMP;
        end

        if (ctrl_jump) begin 
          pc_next    = pc + 1; // gives us pc + 4 on JAL & JALR
          pc_mod     = 1'b1;
          state_next = eJUMP;
        end

        if (load_insn) begin
          state_next = eLOAD;
        end

        if (exception) begin
          jmp_addr_valid_o = 1'b1;
          jmp_addr_o       = csr_mtvec_value[31:2];
          pc_next          = csr_mtvec_value[31:2];
          pc_mod           = 1'b1;
          csr_exc_write    = 1'b1;
          csr_exc_mcause   = exc_exec_stage_r  ? exc_cause_r : exc_cause;
          csr_exc_mepc     = exc_mem_wb_stage2 ? pc          : pc_r;
          csr_exc_mtval    = exc_mtval;
          cancel_retire    = 1'b1;
        end
        
        if (mret_insn) begin
          jmp_addr_valid_o = 1'b1;
          jmp_addr_o       = csr_mepc_value[31:2];
          pc_next          = csr_mepc_value[31:2];
          pc_mod           = 1'b1;
          csr_mret_restore = 1'b1;
        end

        if (enter_debug) begin
          state_next       = eRUN;
          jmp_addr_valid_o = 1'b1;
          jmp_addr_o       = DmRomAddr[31:2];
          pc_next          = DmRomAddr[31:2];
          pc_mod           = 1'b1;
          dbg_mode_next    = 1'b1;
          csr_dbg_write    = 1'b1;
          csr_dbg_cause    = dcsr_cause;
          csr_dbg_dpc      = dpc_next; 
          drain_next       = 1'b0;
        end

        if (step_todrain) begin
          drain_next = 1'b1;
          pc_next    = pc;
          pc_mod     = 1'b0;
        end

        if (dret_insn) begin
          dbg_mode_next    = 1'b0;
          jmp_addr_valid_o = 1'b1;
          jmp_addr_o       = csr_dpc_value[31:2];
          pc_next          = csr_dpc_value[31:2];
          pc_mod           = 1'b1;
        end
      end

      eJUMP: begin
        state_next       = eRUN;
        stall_ex_o       = 1'b1;
        flush_ex_o       = 1'b1;
        jmp_addr_valid_o = 1'b1;
        flush_mem_wb_o   = 1'b1;
        jmp_addr_o       = alu_res_r_i[31:2];
        pc_next          = alu_res_r_i[31:2];
        pc_mod           = 1'b1;
        if (exc_jmp_addr_misalign) begin
          pc_next           = csr_mtvec_value[31:2];
          pc_mod            = 1'b1;
          jmp_addr_o        = csr_mtvec_value[31:2];
          jmp_addr_valid_o  = 1'b1;
          stop_jmp_write_o  = 1'b1;
          csr_exc_write     = 1'b1;
          csr_exc_mcause    = exc_cause_r;
          csr_exc_mepc      = pc_r;
          csr_exc_mtval     = exc_mtval;
        end
      end

      eLOAD: begin
        stall_ex_o = 1'b1;
        if (load_exception) begin
          state_next        = eRUN;
          pc_next           = csr_mtvec_value[31:2];
          pc_mod            = 1'b1;
          jmp_addr_o        = csr_mtvec_value[31:2];
          jmp_addr_valid_o  = 1'b1;
          stop_jmp_write_o  = 1'b1;
          csr_exc_write     = 1'b1;
          csr_exc_mcause    = exc_cause;
          csr_exc_mepc      = pc;
          csr_exc_mtval     = exc_mtval;
          flush_ex_o        = 1'b1;
          flush_mem_wb_o    = 1'b1;
        end
        else if (lsu_wb_i) begin
          loaded = 1'b1;
          state_next = eRUN;
          pc_next = pc + 1; 
          pc_mod  = 1'b1;
          flush_mem_wb_o = 1'b1;
        end
      end
    endcase

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
  register dbg_mode_reg  (.clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(dbg_mode_next),    .out(dbg_mode));
  register drain_reg     (.clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(drain_next),       .out(drain));
  register stall_ex_reg  (.clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(stall_ex_o),       .out(stall_ex_o_r));
  register csr_stall_reg (.clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(csr_write_hazard), .out(csr_write_hazard_r));
  register ebreak_todbg_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(ebreak_todbg), .out(ebreak_todbg_r)
  );
  register dret_fromdbg_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(dret_fromdbg), .out(dret_fromdbg_r)
  );
  register ebreak_insn_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(ebreak_insn), .out(ebreak_insn_r)
  );
  register ext_dbg_req_reg (
    .clk(clk_i), .rstn(rstn_i), .ce(1'b1), .in(ext_dbg_req_i), .out(ext_dbg_req_r)
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
    .DTYPE(logic [XLEN-3:0])
  ) pc_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (pc_mod),
    .in   (pc_next),
    .out  (pc)
  );
  register #(
    .DTYPE(logic [XLEN-3:0])
  ) pc_r_reg (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (pc_mod),
    .in   (pc),
    .out  (pc_r)
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
    .rstn(rstn_i && ~cancel_retire),
    .ce  (~stall_mem_wb_o),
    .in  (instr_will_retire),
    .out (instr_will_retire_r)
  );
  
endmodule
