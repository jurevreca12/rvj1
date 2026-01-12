////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_top                                                   //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    The top file of the rvj1 riscv core.                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import rvj1_defines::*;

module rvj1_top
(
  input logic clk_i,
  input logic rstn_i,

  // Interface to instr memory
  output logic [XLEN-1:0]   instr_req_addr_o,
  output logic [XLEN-1:0]   instr_req_data_o,
  output logic [NBYTES-1:0] instr_req_strobe_o,
  output logic              instr_req_write_o,
  output logic              instr_req_valid_o,
  input  logic              instr_req_ready_i,

  input  logic [XLEN-1:0] instr_rsp_data_i,
  input  logic            instr_rsp_error_i,
  input  logic            instr_rsp_valid_i,
  output logic            instr_rsp_ready_o,

  // Interface to data memory
  output logic [XLEN-1:0]   data_req_addr_o,
  output logic [XLEN-1:0]   data_req_data_o,
  output logic [NBYTES-1:0] data_req_strobe_o,
  output logic              data_req_write_o,
  output logic              data_req_valid_o,
  input  logic              data_req_ready_i,

  input  logic [XLEN-1:0] data_rsp_data_i,
  input  logic            data_rsp_error_i,
  input  logic            data_rsp_valid_i,
  output logic            data_rsp_ready_o,

  // Interrupt sources
  input logic        irq_external_i,
  input logic        irq_timer_i,
  input logic        irq_sw_i,
  input logic        irq_lcofi_i,
  input logic [15:0] irq_platform_i,
  input logic        irq_nmi_i,

  // RISC-V Formal Interface
`ifdef RVFI
  output logic                         rvfi_valid,
  output logic [63:0]                  rvfi_order,
  output logic [31:0]                  rvfi_insn,
  output logic                         rvfi_trap,
  output logic                         rvfi_halt,
  output logic                         rvfi_intr,
  output logic [ 1:0]                  rvfi_mode,
  output logic [ 1:0]                  rvfi_ixl,
  output logic [ 4:0]                  rvfi_rs1_addr,
  output logic [ 4:0]                  rvfi_rs2_addr,
  output logic [31:0]                  rvfi_rs1_rdata,
  output logic [31:0]                  rvfi_rs2_rdata,
  output logic [ 4:0]                  rvfi_rd_addr,
  output logic [31:0]                  rvfi_rd_wdata,
  output logic [31:0]                  rvfi_pc_rdata,
  output logic [31:0]                  rvfi_pc_wdata,
  output logic [31:0]                  rvfi_mem_addr,
  output logic [ 3:0]                  rvfi_mem_rmask,
  output logic [ 3:0]                  rvfi_mem_wmask,
  output logic [31:0]                  rvfi_mem_rdata,
  output logic [31:0]                  rvfi_mem_wdata,
`endif

  input logic fetch_enable_i
);

  /****************************************
  * SIGNAL DECLARATION
  ****************************************/
  // IF/DEC
  logic             fetched_instr_valid;
  logic [XLEN-1:0]  fetched_instr;
  logic             fetched_instr_ready;

  // DEC/EX
  logic             control;
  logic [RALEN-1:0] rf_addr_a;
  logic [RALEN-1:0] rf_addr_b;
  alu_op_e          alu_op_sel;
  logic             rpa_or_pc;
  logic             rpb_or_imm;
  logic             alu_write_rf;
  logic [RALEN-1:0] regdest;
  logic [XLEN-1:0]  immediate;
  logic             lsu_ctrl_valid;
  lsu_ctrl_e        lsu_ctrl;
  logic [XLEN-1:0]  regs1_data;
  logic [XLEN-1:0]  regs2_data;
  logic             instr_issued;
  logic             instr_will_retire;
  logic             ecall_insn;
  logic             mret_insn;
  logic             csr_valid;
  logic [11:0]      csr_addr;
  csr_cmd_t         csr_cmd;
  logic             ctrl_branch;
  branch_ctrl_e     ctrl_branch_type;
  logic             jump;

  // EXECUTE
  logic [XLEN-1:0]  alu_op_a_data;
  logic [XLEN-1:0]  alu_op_b_data;
  logic [XLEN-1:0]  alu_res;
  logic [XLEN-1:0]  program_counter;
  logic             stall;

  // MEM - WB
  logic             alu_write_rf_r;
  logic [RALEN-1:0] regdest_r;
  logic             lsu_ctrl_valid_r;
  lsu_ctrl_e        lsu_ctrl_r;
  logic [XLEN-1:0]  regs2_data_r;
  logic [XLEN-1:0]  alu_res_r;
  logic             jump_r;
  logic             csr_valid_r;
  logic [11:0]      csr_addr_r;
  csr_cmd_t         csr_cmd_r;

  logic [RALEN-1:0] wpc_addr;
  logic [XLEN-1:0]  wpc_data;
  logic             wpc_we;
  logic [RALEN-1:0] lsu_wb_regdest;
  logic [XLEN-1:0]  lsu_wb_data;
  logic             lsu_wb_valid;

  // CONTROL SIGNALS
  logic             instr_retiring;
  logic             jmp_addr_valid;
  logic [XLEN-1:0]  jmp_addr;
  logic             lsu_ready;
  logic             flush;
  logic             csr_wb;
  logic [XLEN-1:0]  csr_value;
  logic [RALEN-1:0] csr_regdest;


  `ifdef RVFI
  logic [XLEN-1:0] instr_exec;
  `endif

  /****************************************
  * INSTRUCTION FETCH STAGE
  ****************************************/
  rvj1_ifu ifu_inst(
    .clk_i              (clk_i),
    .rstn_i             (rstn_i),
    .instr_req_addr_o   (instr_req_addr_o),
    .instr_req_data_o   (instr_req_data_o),
    .instr_req_strobe_o (instr_req_strobe_o),
    .instr_req_write_o  (instr_req_write_o),
    .instr_req_valid_o  (instr_req_valid_o),
    .instr_req_ready_i  (instr_req_ready_i),

    .instr_rsp_data_i   (instr_rsp_data_i),
    .instr_rsp_error_i  (instr_rsp_error_i),
    .instr_rsp_valid_i  (instr_rsp_valid_i),
    .instr_rsp_ready_o  (instr_rsp_ready_o),

    .dec_instr_o        (fetched_instr),
    .dec_valid_o        (fetched_instr_valid),
    .dec_ready_i        (fetched_instr_ready),

    .jmp_addr_valid_i   (jmp_addr_valid),
    .jmp_addr_i         (jmp_addr),

    .ctrl_insn_misalign_exception_o (),
    .ctrl_fault_addr_o              ()
  );


  /****************************************
  * INSTRUCTION DECODE STAGE
  ****************************************/
  rvj1_dec decoder_inst(
    .clk_i               (clk_i),
    .rstn_i              (rstn_i && ~flush),
    .ifu_instr_i         (fetched_instr),
    .ifu_valid_i         (fetched_instr_valid),
    .ifu_ready_o         (fetched_instr_ready),
    .stall_i             (stall),
    .instr_issued_o      (instr_issued),
    .instr_will_retire_o (instr_will_retire),
    .control_o           (control),
    `ifdef RVFI
    .instr_exec_o        (instr_exec),
    `endif
    .rf_addr_a_o         (rf_addr_a),
    .rf_addr_b_o         (rf_addr_b),
    .alu_sel_o           (alu_op_sel),
    .rpa_or_pc_o         (rpa_or_pc),
    .rpb_or_imm_o        (rpb_or_imm),
    .alu_write_rf_o      (alu_write_rf),
    .regdest_o           (regdest),
    .immediate_o         (immediate),
    .lsu_ctrl_valid_o    (lsu_ctrl_valid),
    .lsu_ctrl_o          (lsu_ctrl),
    .ctrl_jump_o         (jump),
    .ctrl_branch_o       (ctrl_branch),
    .ctrl_branch_type_o  (ctrl_branch_type),
    .csr_valid_o         (csr_valid),
    .csr_addr_o          (csr_addr),
    .csr_cmd_o           (csr_cmd),
    .ecall_insn_o        (ecall_insn),
    .mret_insn_o         (mret_insn)
  );

  /*********************************************
  * INSTRUCTION EXECUTE STAGE - ALU/REGFILE/MUX
  *********************************************/

  rvj1_regfile regfile_inst(
    .clk_i      (clk_i),
    .rstn_i     (rstn_i),
    .rpa_addr_i (rf_addr_a),
    .rpa_data_o (regs1_data),
    .rpb_addr_i (rf_addr_b),
    .rpb_data_o (regs2_data),
    .wpc_addr_i (wpc_addr),
    .wpc_data_i (wpc_data),
    .wpc_we_i   (wpc_we)
  );

  assign alu_op_a_data = rpa_or_pc  ? program_counter : regs1_data;
  assign alu_op_b_data = rpb_or_imm ? immediate       : regs2_data;

  rvj1_alu alu_inst(
    .sel_i  (alu_op_sel),
    .op_a_i (alu_op_a_data),
    .op_b_i (alu_op_b_data),
    .res_o  (alu_res)
  );

  pipeline_register #(
    .WORD_WIDTH  (1 + RALEN + XLEN + 1 + $bits(lsu_ctrl_e) + XLEN + 1 + 1 + 12 + $bits(csr_cmd_t)),
    .RESET_VALUE (0)
  ) ex_mem_stage_reg (
    .clk  (clk_i),
    .ce   (control && ~stall),
    .in   ({alu_write_rf,   regdest,   alu_res,   lsu_ctrl_valid,   lsu_ctrl,   regs2_data,   jump,   csr_valid,   csr_addr,   csr_cmd}),
    .out  ({alu_write_rf_r, regdest_r, alu_res_r, lsu_ctrl_valid_r, lsu_ctrl_r, regs2_data_r, jump_r, csr_valid_r, csr_addr_r, csr_cmd_r})
  );

  /*********************************************
  * MEMORY ACCESS STAGE
  *********************************************/
  rvj1_lsu lsu_inst(
    .clk_i                   (clk_i),
    .rstn_i                  (rstn_i),
    .lsu_valid_i             (lsu_ctrl_valid_r),
    .lsu_ready_o             (lsu_ready),
    .lsu_cmd_i               (lsu_ctrl_r),
    .lsu_addr_i              (alu_res_r),
    .lsu_data_i              (regs2_data_r),
    .lsu_regdest_i           (regdest_r),
    .rf_data_o               (lsu_wb_data),
    .rf_wb_o                 (lsu_wb_valid),
    .rf_dest_o               (lsu_wb_regdest),
    .ctrl_misaligned_load_o  (),
    .ctrl_misaligned_store_o (),
    .ctrl_bus_error_o        (),
    .ctrl_exception_addr_o   (),
    .data_req_addr_o         (data_req_addr_o),
    .data_req_data_o         (data_req_data_o),
    .data_req_strobe_o       (data_req_strobe_o),
    .data_req_write_o        (data_req_write_o),
    .data_req_valid_o        (data_req_valid_o),
    .data_req_ready_i        (data_req_ready_i),
    .data_rsp_data_i         (data_rsp_data_i),
    .data_rsp_error_i        (data_rsp_error_i),
    .data_rsp_valid_i        (data_rsp_valid_i),
    .data_rsp_ready_o        (data_rsp_ready_o)
  );


  /*********************************************
  * WRITEBACK STAGE
  *********************************************/
  always_comb begin
    wpc_addr = '0;
    wpc_data = '0;
    unique case ({jump_r, lsu_wb_valid, alu_write_rf_r, csr_wb})
      4'b1000: begin // jump_r - one cycle after execute
        wpc_addr = regdest_r;
        wpc_data = program_counter;
      end
      4'b0100: begin // lsu_wb_valid - ctrl logic stalls execution path
        wpc_addr = lsu_wb_regdest;
        wpc_data = lsu_wb_data;
      end
      4'b0010: begin // alu_write_rf_r - one cycle after execute
        wpc_addr = regdest_r;
        wpc_data = alu_res_r;
      end
      4'b0001: begin // csr_wb - two cycles after execute (thats why csr insns takes 3 cycles)
        wpc_addr = csr_regdest;
        wpc_data = csr_value;
      end
      default: begin // should not happen
        wpc_addr = '0;
        wpc_data = '0;
      end
    endcase
  end
  assign wpc_we   = lsu_wb_valid || alu_write_rf_r || jump_r || csr_wb;

  `ifdef ASSERTIONS
    always_ff @(posedge clk_i)
      one_hot_write: assert( $onehot0({jump_r, lsu_wb_valid, alu_write_rf_r, csr_wb}) );
  `endif

  /*********************************************
  * CONTROLLER
  *********************************************/
  rvj1_ctrl ctrl_inst(
    .clk_i               (clk_i),
    .rstn_i              (rstn_i),
    .rf_addr_a_i         (rf_addr_a),
    .rf_addr_b_i         (rf_addr_b),
    .rpa_or_pc_i         (rpa_or_pc),
    .rpb_or_imm_i        (rpb_or_imm),
    .regdest_i           (regdest),
    .regdest_r_i         (regdest_r),
    .lsu_cmd_i           (lsu_ctrl),
    .lsu_ctrl_valid_i    (lsu_ctrl_valid),
    .lsu_ready_i         (lsu_ready),
    .ctrl_jump_i         (jump),
    .alu_res_i           (alu_res_r),
    .ctrl_branch_i       (ctrl_branch),
    .ctrl_branch_type_i  (ctrl_branch_type),
    .instr_issued_i      (instr_issued),
    .instr_will_retire_i (instr_will_retire),
    .instr_retiring_o    (instr_retiring),
    .stall_o             (stall),
    .program_counter_o   (program_counter),
    .flush_o             (flush),
    .jmp_addr_valid_o    (jmp_addr_valid),
    .jmp_addr_o          (jmp_addr),
    .csr_valid_i         (csr_valid_r),
    .csr_addr_i          (csr_addr_r),
    .csr_cmd_i           (csr_cmd_r),
    .csr_value_o         (csr_value),
    .csr_regdest_o       (csr_regdest),
    .csr_wb_o            (csr_wb),
    .irq_external_i      (irq_external_i),
    .irq_timer_i         (irq_timer_i),
    .irq_sw_i            (irq_sw_i),
    .irq_lcofi_i         (irq_lcofi_i),
    .irq_platform_i      (irq_platform_i),
    .irq_nmi_i           (irq_nmi_i),
    .ecall_insn_i        (ecall_insn),
    .mret_insn_i         (mret_insn)
  );


  /*********************************************
  * RISC-V Formal Interface (RVFI)
  * https://yosyshq.readthedocs.io/projects/riscv-formal/en/latest/rvfi.html
  *********************************************/
  `ifdef RVFI
  logic instr_retired;
  logic simple_insn_issued;
  logic load_insn_issued;
  logic csr_insn_issued;
  rvfi_stage_info_t exec_stage_comb, mem_stage, wb_stage, retired_stage;

  assign simple_insn_issued = instr_issued && instr_will_retire && ~stall;
  assign load_insn_issued = instr_issued && lsu_ctrl_valid && ~lsu_ctrl[3] && ~stall;
  assign csr_insn_issued = instr_issued && csr_valid && ~stall;

  always_comb begin
    exec_stage_comb.instr         = instr_exec;
    exec_stage_comb.rs1_addr      = rf_addr_a;
    exec_stage_comb.rs2_addr      = rf_addr_b;
    exec_stage_comb.rs1_rdata     = regs1_data;
    exec_stage_comb.rs2_rdata     = regs2_data;
    exec_stage_comb.rd_addr       = regdest;
    exec_stage_comb.alu_res       = alu_res;
    exec_stage_comb.pc_rdata      = program_counter;
    exec_stage_comb.lsu_cmd_valid = lsu_ctrl_valid;
    exec_stage_comb.lsu_cmd       = lsu_ctrl;
  end

  always_ff @(posedge clk_i) begin
    if (~rstn_i)
      mem_stage <= '{default:'0, lsu_cmd:LSU_NO_CMD};
    else if (load_insn_issued || csr_insn_issued)
      mem_stage <= exec_stage_comb;
  end
  always_ff @(posedge clk_i) begin
    if (~rstn_i)
      wb_stage <= '{default:'0, lsu_cmd:LSU_NO_CMD};
    else if (simple_insn_issued || csr_insn_issued)
      wb_stage <= exec_stage_comb;
    else if (lsu_wb_valid)
      wb_stage <= mem_stage;
  end
  always_ff @(posedge clk_i)
    retired_stage <= wb_stage;

  always_ff @(posedge clk_i)
    wb_collison: assert ($onehot0({simple_insn_issued, lsu_wb_valid, csr_wb}));

  always_ff @(posedge clk_i) begin
    if (~rstn_i)
      instr_retired <= 1'b0;
    else
      instr_retired <= instr_retiring & ~stall;
  end
  assign rvfi_valid = instr_retired;
  counter #(
    .WORD_WIDTH (64),
    .RESET_VALUE(0)
  ) rvfi_order_cnt (
    .clk  (clk_i),
    .rstn (rstn_i),
    .ce   (rvfi_valid),
    .count(rvfi_order)
  );
  assign rvfi_insn = retired_stage.instr;
  assign rvfi_trap = 1'b0; // TODO
  assign rvfi_halt = 1'b0; // TODO
  assign rvfi_intr = 1'b0; // TODO
  assign rvfi_mode = 2'b11; // M-mode only
  assign rvfi_ixl  = 2'b01; // MXL = 32

  assign rvfi_rs1_addr = retired_stage.rs1_addr;
  assign rvfi_rs2_addr = retired_stage.rs2_addr;
  assign rvfi_rs1_rdata = retired_stage.rs1_rdata;
  assign rvfi_rs2_rdata = retired_stage.rs2_rdata;

  assign rvfi_rd_addr = retired_stage.rd_addr;

  logic [XLEN-1:0] wpc_data_r;
  always_ff @(posedge clk_i) begin
    if (~rstn_i)
      wpc_data_r <= '0;
    else if (jump_r || lsu_wb_valid || alu_write_rf_r || csr_wb)
      wpc_data_r <= wpc_data;
  end
  assign rvfi_rd_wdata = wpc_data_r;

  assign rvfi_pc_rdata = retired_stage.pc_rdata;
  assign rvfi_pc_wdata = jmp_addr_valid ? jmp_addr : (retired_stage.pc_rdata + 4);

  assign rvfi_mem_addr = retired_stage.alu_res;
  logic [3:0] strobe_sig;
  // This module is used also in LSU! It was just easier to instatiate
  // another copy here.
  cmd_to_strobe cmd2strb_dummy (
    .cmd(retired_stage.lsu_cmd),
    .addr(retired_stage.alu_res[1:0]),
    .strobe(strobe_sig)
  );
  assign rvfi_mem_rmask = strobe_sig;
  assign rvfi_mem_wmask = strobe_sig;
  assign rvfi_mem_rdata = lsu_wb_data;
  assign rvfi_mem_wdata = retired_stage.rs2_rdata;
  `ifdef RVFI_TRACE
    rvfi_trace trace_mod (
      .clk            (clk_i),
      .rvfi_valid     (rvfi_valid),
      .rvfi_order     (rvfi_order),
      .rvfi_insn      (rvfi_insn),
      .rvfi_trap      (rvfi_trap),
      .rvfi_halt      (rvfi_halt),
      .rvfi_intr      (rvfi_intr),
      .rvfi_mode      (rvfi_mode),
      .rvfi_ixl       (rvfi_ixl),
      .rvfi_rs1_addr  (rvfi_rs1_addr),
      .rvfi_rs2_addr  (rvfi_rs2_addr),
      .rvfi_rs1_rdata (rvfi_rs1_rdata),
      .rvfi_rs2_rdata (rvfi_rs2_rdata),
      .rvfi_rd_addr   (rvfi_rd_addr),
      .rvfi_rd_wdata  (rvfi_rd_wdata),
      .rvfi_pc_rdata  (rvfi_pc_rdata),
      .rvfi_pc_wdata  (rvfi_pc_wdata),
      .rvfi_mem_addr  (rvfi_mem_addr),
      .rvfi_mem_rmask (rvfi_mem_rmask),
      .rvfi_mem_wmask (rvfi_mem_wmask),
      .rvfi_mem_rdata (rvfi_mem_rdata),
      .rvfi_mem_wdata (rvfi_mem_wdata)
    );
  `endif
  `endif
  
endmodule
