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

import rvj1_defines::*;

module rvj1_ctrl #(
  parameter bit [31:0] BOOT_ADDR = 32'h8000_0000
)
(
  input logic clk_i,
  input logic rstn_i,

  input logic [RALEN-1:0] rf_addr_a_i,
  input logic [RALEN-1:0] rf_addr_b_i,
  input logic             rpa_or_pc_i,
  input logic             rpb_or_imm_i,
  input logic [RALEN-1:0] alu_regdest_r_i,
  input lsu_ctrl_e        lsu_cmd_i,
  input logic             lsu_ctrl_valid_i,
  input logic             lsu_ready_i,
  input logic             ctrl_jump_i,
  input logic [XLEN-1:0]  alu_res_i,
  input logic             ctrl_branch_i,
  input branch_ctrl_e     ctrl_branch_type_i,
  input logic             csr_valid_i,
  input logic [11:0]      csr_addr_i,
  input csr_cmd_t         csr_cmd_i,

  input  logic            instr_issued_i,
  output logic            stall_o,
  output logic [XLEN-1:0] program_counter_o,
  output logic            flush_o,

  output logic            jmp_addr_valid_o,
  output logic [XLEN-1:0] jmp_addr_o,

  output logic [XLEN-1:0] csr_value_o,
  output logic            csr_wb_o
);
  typedef enum logic [3:0] {
      eRESET,
      eBOOT0,
      eBOOT1,
      eJUMP0,
      eJUMP1,
      eRUN,
      eLOAD0,   // loading a value from data mem to a register.
      eLOAD1,
      eBRANCH
  } rvj1_fsm_e;
  rvj1_fsm_e state, state_next;

  // CSR defintions
  logic [XLEN-3:0] mtvec; // only direct mode supported
  logic [XLEN-3:0] mepc;  // holds valid PCs
  logic [4:0]      mcause;
  logic            mcause_int;
  logic [XLEN-1:0] mscratch;
  logic            mip_msi;  // machine sw irq
  logic            mip_mti;  // machine timer irq
  logic            mip_mei;  // machine ext irq
  logic            mip_lcofi; // local cnt overflow irq
  logic            mie_msi;
  logic            mie_mti;
  logic            mie_mei;
  logic            mie_lcofi;
  logic [XLEN-1:0] misa;
  logic [XLEN-1:0] mhartid;
  logic [XLEN-1:0] mtvendorid;
  logic            mstatus_mie;  // machine interrupt enable
  logic            mstatus_mpie; // machine previous irq enable

  // full output values of registers
  logic [XLEN-1:0] csr_mstatus_value;
  logic [XLEN-1:0] csr_mie_value;
  logic [XLEN-1:0] csr_mtvec_value;
  logic [XLEN-1:0] csr_msratch_value;
  logic [XLEN-1:0] csr_mepc_value;
  logic [XLEN-1:0] csr_mcause_value;
  logic [XLEN-1:0] csr_mtval_value;
  logic [XLEN-1:0] csr_mip_value;

  logic [XLEN-1:0] csr_value;

  // Other defintions
  logic rf_a_hazard;
  logic rf_b_hazard;
  logic lsu_b_hazard;
  logic load, loaded, jump, branch, takebr, nobr;
  logic [XLEN-1:0] program_counter;
  logic is_booted;
  branch_ctrl_e ctrl_branch_type_reg;
  logic cond_met;

  assign rf_a_hazard = ((alu_regdest_r_i == rf_addr_a_i) &&
                         ~rpa_or_pc_i  &&
                         rf_addr_a_i != 5'b00000);
  assign rf_b_hazard = ((alu_regdest_r_i == rf_addr_b_i) &&
                         ~rpb_or_imm_i &&
                         rf_addr_b_i != 5'b00000);
  // LSU uses rpb port, even though an immediate is used.
  // Because of this rf_b_hazard does not trigger.
  assign lsu_b_hazard = ((alu_regdest_r_i == rf_addr_b_i) &&
                          lsu_ctrl_valid_i &&
                          lsu_cmd_i[3] && // is_write
                          rf_addr_b_i != 5'b00000);
  assign stall_o = (rf_a_hazard  ||
                    rf_b_hazard  ||
                    lsu_b_hazard ||
                    (state == eLOAD0) ||
                    (state == eLOAD1)) ||
                    (state == eJUMP0) ||
                    (state == eJUMP1);

  assign jmp_addr_valid_o = (state == eJUMP0) || (state == eBOOT0);
  assign jmp_addr_o       = (state == eJUMP0) ?  {alu_res_i[31:1], 1'b0} : BOOT_ADDR;
  assign flush_o          = (state == eJUMP0);


  /*************************************
  * Program Counter
  *************************************/
  always_ff @(posedge clk_i) begin
    if (~rstn_i)
      program_counter <= BOOT_ADDR;
    else if (state_next == eJUMP1) begin
      program_counter <= alu_res_i;
    end
    // ctrl_jump_i makes sure that we increment the program counter on the jump instruction.
    // This gives us pc + 4 required for JAL and JALR.
    else if ((instr_issued_i && ~stall_o) || ctrl_jump_i) begin
      program_counter <= program_counter + 4;
    end
  end
  assign program_counter_o = program_counter;

  /*************************************
  * Branching conditions
  *************************************/
  always_ff @(posedge clk_i) begin
    if (~rstn_i)
      ctrl_branch_type_reg <= BRANCH_EQ;
    if (ctrl_branch_i)
      ctrl_branch_type_reg <= ctrl_branch_type_i;
  end

  always_comb begin
    cond_met = 1'b0;
    unique case (ctrl_branch_type_reg)
      BRANCH_EQ:  cond_met = (alu_res_i    == 0   );
      BRANCH_NEQ: cond_met = (alu_res_i    != 0   );
      BRANCH_LT:  cond_met = (alu_res_i[0] == 1'b1);
      BRANCH_GE:  cond_met = (alu_res_i[0] == 1'b0);
      BRANCH_LTU: cond_met = (alu_res_i[0] == 1'b1);
      BRANCH_GEU: cond_met = (alu_res_i[0] == 1'b0);
    endcase
  end

  /*************************************
  * Control and Status Registers
  *************************************/
  assign csr_mstatus_value = (
      (mstatus_mie  << CSR_MSTATUS_MIE_BIT)
    | (mstatus_mpie << CSR_MSTATUS_MPIE_BIT)
  );
  assign csr_mie_value = (
      (mie_msi   << CSR_MIE_MSI_BIT)
    | (mie_mti   << CSR_MIE_MTI_BIT)
    | (mie_mei   << CSR_MIE_MEI_BIT)
    | (mie_lcofi << CSR_MIE_LCOFI_BIT)
  );

  always_comb begin
    csr_value = '0;
    // ONLY implemented registers, others default to zero
    unique case (csr_addr_i)
      CSR_MVENDORID_ADDR: csr_value = CSR_MVENDORID_ADDR;
      CSR_MARCHID_ADDR:   csr_value = CSR_MARCHID_VALUE;
      CSR_MIMPID_ADDR:    csr_value = CSR_MIMPID_VALUE;
      CSR_MHARTID_ADDR:   csr_value = CSR_MHARTID_VALUE;
      CSR_MSTATUS_ADDR:   csr_value = csr_mstatus_value;
      CSR_MSTATUSH_ADDR:  csr_value = CSR_MSTATUSH_VALUE;
      CSR_MISA_ADDR:      csr_value = CSR_MISA_VALUE;
      CSR_MIE_ADDR:       csr_value = csr_mie_value;
      CSR_MTVEC_ADDR:     csr_value = csr_mtvec_value;
      CSR_MSCRATCH_ADDR:  csr_value = csr_msratch_value;
      CSR_MEPC_ADDR:      csr_value = csr_mepc_value;
      CSR_MCAUSE_ADDR:    csr_value = csr_mcause_value;
      CSR_MTVAL_ADDR:     csr_value = csr_mtval_value;
      CSR_MIP_ADDR:       csr_value = csr_mip_value;
      default:            csr_value = '0;
    endcase
  end
  always_ff @(posedge clk_i) begin
    if (!rstn_i && !csr_valid_i)
      csr_value_o <= '0;
    else if (csr_valid_i)
      csr_value_o <= csr_value;
  end


  /*************************************
  * Finite State Machine (FSM)
  *************************************/
  always_comb begin
    load   = (state == eRUN)    &&  lsu_ctrl_valid_i && ~lsu_cmd_i[3] && ~stall_o;
    loaded = (state == eLOAD1)  &&  lsu_ready_i;
    jump   = (state == eRUN)    &&  ctrl_jump_i                       && ~stall_o;
    branch = (state == eRUN)    &&  ctrl_branch_i                     && ~stall_o;
    takebr = (state == eBRANCH) &&  cond_met                          && ~stall_o;
    nobr   = (state == eBRANCH) && ~cond_met                          && ~stall_o;
  end
  always_comb begin
    state_next = (state == eRESET) ? eBOOT0  : state;
    state_next = (state == eBOOT0) ? eBOOT1  : state_next;
    state_next = (state == eBOOT1) ? eRUN    : state_next;
    state_next = load              ? eLOAD0  : state_next;
    state_next = (state == eLOAD0) ? eLOAD1  : state_next;
    state_next = loaded            ? eRUN    : state_next;
    state_next = jump              ? eJUMP0  : state_next;
    state_next = (state == eJUMP0) ? eJUMP1  : state_next;
    state_next = (state == eJUMP1) ? eRUN    : state_next;
    state_next = branch            ? eBRANCH : state_next;
    state_next = takebr            ? eJUMP0  : state_next;
    state_next = nobr              ? eRUN    : state_next;
  end
  always_ff @(posedge clk_i) begin
    if (~rstn_i)
        state <= eRESET;
    else
        state <= state_next;
  end
endmodule
