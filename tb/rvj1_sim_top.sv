
module rvj1_sim_top import rvj1_sim_pkg::*; #(
  parameter bit          CompressedEnabled = 1'b0,  
  parameter string       INIT_FILE         = "",
  parameter int          INIT_FILE_BIN     = 0,
  parameter int          MEM_SIZE_WORDS    = 200000000
                                  
  ) (
  input  logic  clk,
  input  logic  rstn,
  
  input  logic          irq_external_i,
  input  logic          irq_timer_i,
  input  logic          irq_sw_i,
  input  logic          irq_lcofi_i,
  input  logic [15:0]   irq_platform_i,
  input  logic          irq_nmi_i

  // RISC-V Formal Interface
  `ifdef RVFI
  ,`RVFI_OUTPUTS
  `endif
);

  logic [IdWidth-1:0]   obi_instr_aid;
  logic                 obi_instr_areq;
  logic                 obi_instr_agnt;
  logic [AddrWidth-1:0] obi_instr_aaddr;
  logic                 obi_instr_awe;
  logic [NBytes-1:0]    obi_instr_abe;
  logic [DataWidth-1:0] obi_instr_awdata;

  logic [IdWidth-1:0]   obi_instr_rid;
  logic                 obi_instr_rvalid;
  logic                 obi_instr_rready;
  logic [DataWidth-1:0] obi_instr_rdata;
  logic                 obi_instr_rerr;

  logic [IdWidth-1:0]   obi_data_aid;
  logic                 obi_data_areq;
  logic                 obi_data_agnt;
  logic [AddrWidth-1:0] obi_data_aaddr;
  logic                 obi_data_awe;
  logic [NBytes-1:0]    obi_data_abe;
  logic [DataWidth-1:0] obi_data_awdata;

  logic [IdWidth-1:0]   obi_data_rid;
  logic                 obi_data_rvalid;
  logic                 obi_data_rready;
  logic [DataWidth-1:0] obi_data_rdata;
  logic                 obi_data_rerr;

  logic                 debug_req;

  mgr_obi_a_t obi_a_chans_mgr        [NumManagers];
  logic       obi_agnt_signals_mgr   [NumManagers];
  mgr_obi_r_t obi_r_chans_mgr        [NumManagers];
  logic       obi_rready_signals_mgr [NumManagers];

  sub_obi_a_t obi_a_chans_sub        [NumSubordinates];
  logic       obi_agnt_signals_sub   [NumSubordinates];
  sub_obi_r_t obi_r_chans_sub        [NumSubordinates];
  logic       obi_rready_signals_sub [NumSubordinates];

  addr_map_t address_map [xbar_cfg.NoMaps];
  assign address_map[XbarSbrMem] = '{idx: 0, base: 32'h8000_0000, mask: 32'hfff8_0000}; 

  rvj1_obi #(
    .CompressedEnabled(CompressedEnabled),
    .BootAddr (BootAddr),
    .DmRomAddr(DmRomAddr),
    .MVendorId(MVendorId),
    .MArchId  (MArchId),
    .MImpId   (MImpId),
    .MHartId  (MHartId)
  ) rvj1_inst (
    .clk_i          (clk),
    .rstn_i         (rstn),

    .instr_aid_o    (obi_instr_aid),
    .instr_areq_o   (obi_instr_areq),
    .instr_agnt_i   (obi_instr_agnt),
    .instr_aaddr_o  (obi_instr_aaddr),
    .instr_awe_o    (obi_instr_awe),
    .instr_abe_o    (obi_instr_abe),
    .instr_awdata_o (obi_instr_awdata),

    .instr_rid_i    (obi_instr_rid),
    .instr_rvalid_i (obi_instr_rvalid),
    .instr_rready_o (obi_instr_rready),
    .instr_rdata_i  (obi_instr_rdata),
    .instr_rerr_i   (obi_instr_rerr),
    
    .data_aid_o     (obi_data_aid),
    .data_areq_o    (obi_data_areq),
    .data_agnt_i    (obi_data_agnt),
    .data_aaddr_o   (obi_data_aaddr),
    .data_awe_o     (obi_data_awe),
    .data_abe_o     (obi_data_abe),
    .data_awdata_o  (obi_data_awdata),

    .data_rid_i     (obi_data_rid),
    .data_rvalid_i  (obi_data_rvalid),
    .data_rready_o  (obi_data_rready),
    .data_rdata_i   (obi_data_rdata),
    .data_rerr_i    (obi_data_rerr),

    .irq_external_i (irq_external_i),
    .irq_timer_i    (irq_timer_i),
    .irq_sw_i       (irq_sw_i),
    .irq_lcofi_i    (irq_lcofi_i),
    .irq_platform_i (irq_platform_i),
    .irq_nmi_i      (irq_nmi_i),

    .ext_dbg_req_i  (debug_req)

    // verilator lint_off REDEFMACRO
    `ifdef RVFI
    ,`RVFI_CONN
    `endif
    // verilator lint_on REDEFMACRO
  );
  assign obi_instr_agnt                          = obi_agnt_signals_mgr[XbarMgrIfu];
  assign obi_a_chans_mgr[XbarMgrIfu].obi_areq    = obi_instr_areq;
  assign obi_a_chans_mgr[XbarMgrIfu].obi_aadr    = obi_instr_aaddr;
  assign obi_a_chans_mgr[XbarMgrIfu].obi_awe     = obi_instr_awe;
  assign obi_a_chans_mgr[XbarMgrIfu].obi_abe     = obi_instr_abe;
  assign obi_a_chans_mgr[XbarMgrIfu].obi_awdata  = obi_instr_awdata;
  assign obi_a_chans_mgr[XbarMgrIfu].obi_aid     = obi_instr_aid;

  assign obi_rready_signals_mgr[XbarMgrIfu]  = obi_instr_rready;
  assign obi_instr_rvalid                    = obi_r_chans_mgr[XbarMgrIfu].obi_rvalid;
  assign obi_instr_rdata                     = obi_r_chans_mgr[XbarMgrIfu].obi_rdata;
  assign obi_instr_rerr                      = obi_r_chans_mgr[XbarMgrIfu].obi_rerr;
  assign obi_instr_rid                       = obi_r_chans_mgr[XbarMgrIfu].obi_rid;

  assign obi_data_agnt                          = obi_agnt_signals_mgr[XbarMgrLsu];
  assign obi_a_chans_mgr[XbarMgrLsu].obi_areq   = obi_data_areq;
  assign obi_a_chans_mgr[XbarMgrLsu].obi_aadr   = obi_data_aaddr;
  assign obi_a_chans_mgr[XbarMgrLsu].obi_awe    = obi_data_awe;
  assign obi_a_chans_mgr[XbarMgrLsu].obi_abe    = obi_data_abe;
  assign obi_a_chans_mgr[XbarMgrLsu].obi_awdata = obi_data_awdata;
  assign obi_a_chans_mgr[XbarMgrLsu].obi_aid    = obi_data_aid;

  assign obi_rready_signals_mgr[XbarMgrLsu]  = obi_data_rready;
  assign obi_data_rvalid                     = obi_r_chans_mgr[XbarMgrLsu].obi_rvalid;
  assign obi_data_rdata                      = obi_r_chans_mgr[XbarMgrLsu].obi_rdata;
  assign obi_data_rerr                       = obi_r_chans_mgr[XbarMgrLsu].obi_rerr;
  assign obi_data_rid                        = obi_r_chans_mgr[XbarMgrLsu].obi_rid;

  obi_xbar #(
    .XbarCfg    (xbar_cfg),
    .mgr_obi_a_t(mgr_obi_a_t),
    .mgr_obi_r_t(mgr_obi_r_t),
    .sub_obi_a_t(sub_obi_a_t),
    .sub_obi_r_t(sub_obi_r_t),
    .addr_map_t (addr_map_t),

    .USE_SR_FIFO_MASK(UseSrFifoMask),
    .SR_FIFO_DEPTHS(SrFifoDepth),

    .CONNECTIVITY(Connectivity)
  ) xbar (
    .clk_i            (clk),
    .rstn_i           (rstn),

    .mgr_obi_a_chans       (obi_a_chans_mgr),
    .mgr_obi_agnt_signals  (obi_agnt_signals_mgr),
    .mgr_obi_r_chans       (obi_r_chans_mgr),
    .mgr_obi_rready_signals(obi_rready_signals_mgr),

    .sub_obi_a_chans       (obi_a_chans_sub),
    .sub_obi_agnt_signals  (obi_agnt_signals_sub),
    .sub_obi_r_chans       (obi_r_chans_sub),
    .sub_obi_rready_signals(obi_rready_signals_sub),

    .addr_map_i            (address_map)
  );

  obi_ram #(
    .INIT_FILE     (INIT_FILE),
    .INIT_FILE_BIN (INIT_FILE_BIN),
    .MEM_SIZE_WORDS(MEM_SIZE_WORDS),
    .IDLEN         (xbar_cfg.IdWidth + 2)
  ) mem (
    .clk_i  (clk),
    .rstn_i (rstn),

    .obi_aid_i    (obi_a_chans_sub[XbarSbrMem].obi_aid),
    .obi_areq_i   (obi_a_chans_sub[XbarSbrMem].obi_areq),
    .obi_agnt_o   (obi_agnt_signals_sub[XbarSbrMem]),
    .obi_aaddr_i  (obi_a_chans_sub[XbarSbrMem].obi_aadr),
    .obi_awe_i    (obi_a_chans_sub[XbarSbrMem].obi_awe),
    .obi_awdata_i (obi_a_chans_sub[XbarSbrMem].obi_awdata),
    .obi_abe_i    (obi_a_chans_sub[XbarSbrMem].obi_abe),

    .obi_rid_o    (obi_r_chans_sub[XbarSbrMem].obi_rid),
    .obi_rvalid_o (obi_r_chans_sub[XbarSbrMem].obi_rvalid),
    .obi_rready_i (obi_rready_signals_sub[XbarSbrMem]),
    .obi_rdata_o  (obi_r_chans_sub[XbarSbrMem].obi_rdata)
  );


endmodule
