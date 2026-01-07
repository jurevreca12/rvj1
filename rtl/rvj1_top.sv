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
  logic             dec_valid;
  logic [XLEN-1:0]  fetched_instr;
  logic             dec_ready;
  logic [RALEN-1:0] rf_addr_a;
  logic [RALEN-1:0] rf_addr_b;
  alu_op_e          alu_op_sel;
  logic             rpa_or_pc;
  logic             rpb_or_imm;
  logic             alu_write_rf;
  logic             alu_write_rf_r;
  logic [RALEN-1:0] regdest;
  logic [RALEN-1:0] regdest_r;
  logic [XLEN-1:0]  immediate;
  logic             lsu_ctrl_valid;
  logic             lsu_ctrl_valid_r;
  lsu_ctrl_e        lsu_ctrl;
  lsu_ctrl_e        lsu_ctrl_r;
  logic [XLEN-1:0]  rf_alu_data_a;
  logic [XLEN-1:0]  rf_alu_data_b;
  logic [XLEN-1:0]  rf_alu_data_b_r;

  logic [XLEN-1:0] alu_op_a_data;
  logic [XLEN-1:0] alu_op_b_data;
  logic [XLEN-1:0] alu_res;
  logic [XLEN-1:0] alu_res_r;

  logic [XLEN-1:0]  program_counter;
  logic             stall;
  logic             instr_issued;
  logic             instr_will_retire;
  logic             instr_retiring;
  logic             jmp_addr_valid;
  logic [XLEN-1:0]  jmp_addr;
  logic             lsu_ready;
  logic [RALEN-1:0] wpc_addr;
  logic [XLEN-1:0]  wpc_data;
  logic             wpc_we;
  logic [RALEN-1:0] rf_dest;
  logic [XLEN-1:0]  rf_data;
  logic             rf_wb;
  logic             jump;
  logic             jump_r;
  logic             flush;
  logic             ctrl_branch;
  branch_ctrl_e     ctrl_branch_type;
  logic             control;
  logic             csr_valid, csr_valid_r;
  logic [11:0]      csr_addr, csr_addr_r;
  csr_cmd_t         csr_cmd, csr_cmd_r;
  logic             csr_wb;
  logic [XLEN-1:0]  csr_value;
  logic [RALEN-1:0] csr_regdest;
  logic             ecall_insn;
  logic             mret_insn;

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
    .dec_valid_o        (dec_valid),
    .dec_ready_i        (dec_ready),

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
    .ifu_valid_i         (dec_valid),
    .ifu_ready_o         (dec_ready),
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
    .rpa_data_o (rf_alu_data_a),
    .rpb_addr_i (rf_addr_b),
    .rpb_data_o (rf_alu_data_b),
    .wpc_addr_i (wpc_addr),
    .wpc_data_i (wpc_data),
    .wpc_we_i   (wpc_we)
  );

  assign alu_op_a_data = rpa_or_pc  ? program_counter : rf_alu_data_a;
  assign alu_op_b_data = rpb_or_imm ? immediate       : rf_alu_data_b;

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
    .in   ({alu_write_rf,   regdest,   alu_res,   lsu_ctrl_valid,   lsu_ctrl,   rf_alu_data_b,   jump,   csr_valid,   csr_addr,   csr_cmd}),
    .out  ({alu_write_rf_r, regdest_r, alu_res_r, lsu_ctrl_valid_r, lsu_ctrl_r, rf_alu_data_b_r, jump_r, csr_valid_r, csr_addr_r, csr_cmd_r})
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
    .lsu_data_i              (rf_alu_data_b_r),
    .lsu_regdest_i           (regdest_r),
    .rf_data_o               (rf_data),
    .rf_wb_o                 (rf_wb),
    .rf_dest_o               (rf_dest),
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
    unique case ({jump_r, rf_wb, alu_write_rf_r, csr_wb})
      4'b1000: begin // JUMP
        wpc_addr = regdest_r;
        wpc_data = program_counter;
      end
      4'b0100: begin // RF_WB
        wpc_addr = rf_dest;
        wpc_data = rf_data;
      end
      4'b0010: begin // ALU_WRITE
        wpc_addr = regdest_r;
        wpc_data = alu_res_r;
      end
      4'b0001: begin // CSR_WB
        wpc_addr = csr_regdest;
        wpc_data = csr_value;
      end
      default: begin // should not happen
        wpc_addr = '0;
        wpc_data = '0;
      end
    endcase
  end
  assign wpc_we   = rf_wb || alu_write_rf_r || jump_r || csr_wb;

  `ifdef ASSERTIONS
      one_hot_write: assert($countbits({jump_r, rf_wb, alu_write_rf_r, csr_wb}) == 1 ||
                            $countbits({jump_r, rf_wb, alu_write_rf_r, csr_wb}) == 0);
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
    .alu_regdest_r_i     (regdest_r),
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
  rvfi_stage_info_t exec_stage, mem_stage, wb_stage;

  always_comb begin
      exec_stage.instr         = instr_exec;
      exec_stage.rs1_addr      = rf_addr_a;
      exec_stage.rs2_addr      = rf_addr_b;
      exec_stage.rs1_rdata     = rf_alu_data_a;
      exec_stage.rs2_rdata     = rf_alu_data_b;
      exec_stage.rd_addr       = regdest;
      exec_stage.alu_res       = alu_res;
      exec_stage.pc_rdata      = program_counter;
      exec_stage.lsu_cmd_valid = lsu_ctrl_valid;
      exec_stage.lsu_cmd       = lsu_ctrl;
  end

  always_ff @(posedge clk_i) begin
    if (~rstn_i)
      mem_stage <= '{default:'0, lsu_cmd:LSU_NO_CMD};
    else if (lsu_ctrl_valid_r && lsu_ready)
      mem_stage <= exec_stage;
  end
  always_ff @(posedge clk_i) begin
    if (~rstn_i || stall)
      wb_stage <= '{default:'0, lsu_cmd:LSU_NO_CMD};
    else if (instr_retiring)
      if (rf_wb)
        wb_stage <= mem_stage;
      else
        wb_stage <= exec_stage;
  end

  always_ff @(posedge clk_i) begin
    if (~rstn_i)
      instr_retired <= 1'b0;
    else
      instr_retired <= instr_retiring;
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
  assign rvfi_insn = wb_stage.instr;
  assign rvfi_trap = 1'b0; // TODO
  assign rvfi_halt = 1'b0; // TODO
  assign rvfi_intr = 
  assign rvfi_mode = 2'b11; // M-mode only
  assign rvfi_ixl  = 2'b01; // MXL = 32

  assign rvfi_rs1_addr = wb_stage.rs1_addr;
  assign rvfi_rs2_addr = wb_stage.rs2_addr;
  assign rvfi_rs1_rdata = wb_stage.rs1_rdata;
  assign rvfi_rs2_rdata = wb_stage.rs2_rdata;

  assign rvfi_rd_addr = wb_stage.rd_addr;
  assign rvfi_rd_wdata = wpc_data;

  assign rvfi_pc_rdata = wb_stage.pc_rdata;
  assign rvfi_pc_wdata = jmp_addr_valid ? jmp_addr : (program_counter + 4);

  assign rvfi_mem_addr = wb_stage.alu_res;
  logic [3:0] strobe_sig;
  // This module is used also in LSU! It was just easier to instatiate
  // another copy here.
  cmd_to_strobe cmd2strb_dummy (
    .cmd(wb_stage.lsu_cmd),
    .addr(wb_stage.alu_res[1:0]),
    .strobe(strobe_sig)
  );
  assign rvfi_mem_rmask = strobe_sig;
  assign rvfi_mem_wmask = strobe_sig;
  assign rvfi_mem_rdata = rf_data;
  assign rvfi_mem_wdata = wb_stage.rs2_rdata;
  `endif
endmodule
