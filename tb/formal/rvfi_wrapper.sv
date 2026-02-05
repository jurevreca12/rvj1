module rvfi_wrapper (
  input         clock,
  input         reset,

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
  output logic [31:0]                  rvfi_mem_wdata
);

  (* keep *) logic [31:0] instr_req_addr;
  (* keep *) logic [31:0] instr_req_data;
  (* keep *) logic [3:0]  instr_req_strobe;
  (* keep *) logic        instr_req_write;
  (* keep *) logic        instr_req_valid;
  (* keep *) logic        instr_req_ready;

  (* keep *) logic [31:0] instr_rsp_data;
  (* keep *) logic        instr_rsp_error;
  (* keep *) logic        instr_rsp_valid;
  (* keep *) logic        instr_rsp_ready;

  (* keep *) logic [31:0] data_req_addr;
  (* keep *) logic [31:0] data_req_data;
  (* keep *) logic [3:0]  data_req_strobe;
  (* keep *) logic        data_req_write;
  (* keep *) logic        data_req_valid;
  (* keep *) logic        data_req_ready;

  (* keep *) logic [31:0] data_rsp_data;
  (* keep *) logic        data_rsp_error;
  (* keep *) logic        data_rsp_valid;
  (* keep *) logic        data_rsp_ready;

  (* keep *) logic        irq_external;
  (* keep *) logic        irq_timer;
  (* keep *) logic        irq_sw;
  (* keep *) logic        irq_lcofi;
  (* keep *) logic [15:0] irq_platform;
  (* keep *) logic        irq_nmi;

  (* keep *) logic        fetch_enable;
  
  logic resetn;
  assign resetn = ~reset;

  rvj1_top rvj1_inst (
    .clk_i             (clock),
    .rstn_i            (resetn),

    .instr_req_addr_o  (instr_req_addr),
    .instr_req_data_o  (instr_req_data),
    .instr_req_strobe_o(instr_req_strobe),
    .instr_req_write_o (instr_req_write),
    .instr_req_valid_o (instr_req_valid),
    .instr_req_ready_i (instr_req_ready),

    .instr_rsp_data_i  (instr_rsp_data),
    .instr_rsp_error_i (instr_rsp_error),
    .instr_rsp_valid_i (instr_rsp_valid),
    .instr_rsp_ready_o (instr_rsp_ready),

    .data_req_addr_o   (data_req_addr),
    .data_req_data_o   (data_req_data),
    .data_req_strobe_o (data_req_strobe),
    .data_req_write_o  (data_req_write),
    .data_req_valid_o  (data_req_valid),
    .data_req_ready_i  (data_req_ready),

    .data_rsp_data_i   (data_rsp_data),
    .data_rsp_error_i  (data_rsp_error),
    .data_rsp_valid_i  (data_rsp_valid),
    .data_rsp_ready_o  (data_rsp_ready),

    .irq_external_i    (irq_external),
    .irq_timer_i       (irq_timer),
    .irq_sw_i          (irq_sw),
    .irq_lcofi_i       (irq_lcofi),
    .irq_platform_i    (irq_platform),
    .irq_nmi_i         (irq_nmi),

    .rvfi_valid        (rvfi_valid),
    .rvfi_order        (rvfi_order),
    .rvfi_insn         (rvfi_insn),
    .rvfi_trap         (rvfi_trap),
    .rvfi_halt         (rvfi_halt),
    .rvfi_intr         (rvfi_intr),
    .rvfi_mode         (rvfi_mode),
    .rvfi_ixl          (rvfi_ixl),
    .rvfi_rs1_addr     (rvfi_rs1_addr),
    .rvfi_rs2_addr     (rvfi_rs2_addr),
    .rvfi_rs1_rdata    (rvfi_rs1_rdata),
    .rvfi_rs2_rdata    (rvfi_rs2_rdata),
    .rvfi_rd_addr      (rvfi_rd_addr),
    .rvfi_rd_wdata     (rvfi_rd_wdata),
    .rvfi_pc_rdata     (rvfi_pc_rdata),
    .rvfi_pc_wdata     (rvfi_pc_wdata),
    .rvfi_mem_addr     (rvfi_mem_addr),
    .rvfi_mem_rmask    (rvfi_mem_rmask),
    .rvfi_mem_wmask    (rvfi_mem_wmask),
    .rvfi_mem_rdata    (rvfi_mem_rdata),
    .rvfi_mem_wdata    (rvfi_mem_wdata),

    .fetch_enable_i    (fetch_enable)
  );

  assign irq_external = 1'b0;
  assign irq_timer    = 1'b0;
  assign irq_sw       = 1'b0;
  assign irq_lcofi    = 1'b0;
  assign irq_platform = 16'b0;
  assign irq_nmi      = 1'b0;

  assign fetch_enable = 1'b1;

  // Assume that we start in reset.
  initial assume(resetn == 1'b0);

  // Assume no interrupts for now - TODO
  always @(posedge clock) begin
    assume(!irq_external);
    assume(!irq_timer);
    assume(!irq_sw);
    assume(!irq_lcofi);
    assume(irq_platform == '0);
    assume(!irq_nmi);
  end
  
  // MEMORIEs
  logic instr_req_fire, instr_rsp_fire;
  logic data_req_fire, data_rsp_fire;
  assign instr_req_fire = (instr_req_valid && instr_req_ready);
  assign instr_rsp_fire = (instr_rsp_valid && instr_rsp_ready);
  assign data_req_fire = (data_req_valid && data_req_ready);
  assign data_rsp_fire = (data_rsp_valid && data_rsp_ready);

  // Get memory responses in MAX cycles
  localparam int ImemMaxDelay = 5;
  localparam int DmemMaxDelay = 5;
  logic [7:0] imem_delay;
  logic [7:0] dmem_delay;

  always_ff @(posedge clock) begin
    if (reset || instr_req_fire)
      imem_delay <= '0;
    else if (instr_rsp_valid && ~instr_rsp_ready)
      imem_delay <= imem_delay + 1;
    assume(imem_delay < ImemMaxDelay);
  end
  always_ff @(posedge clock) begin
    if (reset || data_req_fire)
      dmem_delay <= '0;
    else if (data_rsp_valid && ~data_rsp_ready)
      dmem_delay <= dmem_delay + 1;
    assume(dmem_delay < DmemMaxDelay);
  end

  // Assume no memory errors - TODO
  always @(posedge clock) begin
    if($past(instr_req_valid) && $past(instr_req_ready)) begin
      assume(!instr_rsp_error);
    end

    if($past(data_req_valid) && $past(data_req_ready)) begin
      assume(!data_rsp_error);
    end
  end

  // No responses without outstanding requests
  // We use 8 as a "zero". HW does not support
  // more than two outstanding simultaneous
  // requests.
  logic [3:0] imem_req_act;
  logic [3:0] dmem_req_act;
  always_ff @(posedge clock) begin
    if (reset)
      imem_req_act <= 8;
    if (instr_req_fire)
      imem_req_act <= imem_req_act + 1'b1;
    if (instr_rsp_fire)
      imem_req_act <= imem_req_act - 1'b1;
  end
  always_ff @(posedge clock) begin
      assume(imem_req_act >= 8);
  end
  always_ff @(posedge clock) begin
    if (reset)
      dmem_req_act <= 8;
    if (data_req_fire)
      dmem_req_act <= dmem_req_act + 1'b1;
    if (data_rsp_fire)
      dmem_req_act <= dmem_req_act - 1'b1;
  end
  always_ff @(posedge clock) begin
      assume(dmem_req_act >= 8);
  end

endmodule
