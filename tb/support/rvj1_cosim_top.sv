
module rvj1_cosim_top import rvj1_cosim_pkg::*; #(
  parameter  string INIT_FILE="",
  parameter  int    INIT_FILE_BIN=0,
  parameter  int    MEM_SIZE_WORDS=92097152
  ) (
  input  logic  clk,
  input  logic  rstn,
  
  input  logic          irq_external_i,
  input  logic          irq_timer_i,
  input  logic          irq_sw_i,
  input  logic          irq_lcofi_i,
  input  logic [15:0]   irq_platform_i,
  input  logic          irq_nmi_i,
  
  input  logic          dmi_rstn_i,
  input  logic          dmi_req_valid_i,
  output logic          dmi_req_ready_o,
  input  dm::dmi_req_t  dmi_req_i,
  output logic          dmi_resp_valid_o,
  input  logic          dmi_resp_ready_i,
  output dm::dmi_resp_t dmi_resp_o

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
  logic                 ndmreset;
  logic                 hwsw_rstn;

  localparam dm::hartinfo_t HartInfo = '{
    zero0: '0,
    zero1: '0,
    nscratch: 2,
    dataaccess: 1'b1,
    datasize: dm::DataCount,
    dataaddr: dm::DataAddr
  };
  dm::hartinfo_t hartinfo = HartInfo;

  assign hwsw_rstn = rstn && ~ndmreset;

  mgr_obi_a_t obi_a_chans_mgr        [NumManagers];
  logic       obi_agnt_signals_mgr   [NumManagers];
  mgr_obi_r_t obi_r_chans_mgr        [NumManagers];
  logic       obi_rready_signals_mgr [NumManagers];

  sub_obi_a_t obi_a_chans_sub        [NumSubordinates];
  logic       obi_agnt_signals_sub   [NumSubordinates];
  sub_obi_r_t obi_r_chans_sub        [NumSubordinates];
  logic       obi_rready_signals_sub [NumSubordinates];

  addr_map_t address_map [xbar_cfg.NoMaps];
  assign address_map[0] = '{idx: 0,   base: 32'h8000_0000, mask: 32'hffff_4000}; 
  assign address_map[6] = '{idx: 6,   base: 32'h0000_0000, mask: 32'hfff4_0000};

  rvj1_obi #(
    .BootAddr (BootAddr),
    .DmRomAddr(DmRomAddr),
    .MVendorId(MVendorId),
    .MArchId  (MArchId),
    .MImpId   (MImpId),
    .MHartId  (MHartId)
  ) rvj1_inst (
    .clk_i          (clk),
    .rstn_i         (hwsw_rstn),

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
    .rstn_i           (hwsw_rstn),

    .mgr_obi_a_chans       (obi_a_chans_mgr),
    .mgr_obi_agnt_signals  (obi_agnt_signals_mgr),
    .mgr_obi_r_chans       (obi_r_chans_mgr),
    .mgr_obi_rready_signals(obi_rready_signals_mgr),

    .sub_obi_a_chans       (obi_a_chans_sub),
    .sub_obi_agnt_signals  (obi_agnt_signals_sub),
    .sub_obi_r_chans       (obi_r_chans_sub),
    .sub_obi_rready_signals(obi_rready_signals_sub),

    .addr_map_i            ( address_map )
  );

  obi_ram #(
    .INIT_FILE     (INIT_FILE),
    .INIT_FILE_BIN (INIT_FILE_BIN),
    .MEM_SIZE_WORDS(MEM_SIZE_WORDS),
    .IDLEN         (xbar_cfg.IdWidth + 2)
  ) mem (
    .clk_i  (clk),
    .rstn_i (hwsw_rstn),

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

  dm_obi_top #(
    .NrHarts  (1),
    .BusWidth (DataWidth),
    .IdWidth  (xbar_cfg.IdWidth + 2),
    .DmBaseAddress('0)
  ) dm_obi_top_inst (
    .clk_i       (clk),
    .rst_ni      (rstn),
    .testmode_i  (1'b0),
    .ndmreset_o  (ndmreset),
    .dmactive_o  (),

    .debug_req_o   (debug_req),
    .unavailable_i (1'b0),
    .hartinfo_i    (hartinfo),

    .slave_req_i       (obi_a_chans_sub[XbarSbrDbg].obi_areq),
    .slave_we_i        (obi_a_chans_sub[XbarSbrDbg].obi_awe),
    .slave_addr_i      (obi_a_chans_sub[XbarSbrDbg].obi_aadr),
    .slave_be_i        (obi_a_chans_sub[XbarSbrDbg].obi_abe),
    .slave_wdata_i     (obi_a_chans_sub[XbarSbrDbg].obi_awdata),
    .slave_aid_i       (obi_a_chans_sub[XbarSbrDbg].obi_aid),
    .slave_gnt_o       (obi_agnt_signals_sub[XbarSbrDbg]),
    .slave_rvalid_o    (obi_r_chans_sub[XbarSbrDbg].obi_rvalid),
    .slave_rdata_o     (obi_r_chans_sub[XbarSbrDbg].obi_rdata),
    .slave_rid_o       (obi_r_chans_sub[XbarSbrDbg].obi_rid),

    .master_req_o      (obi_a_chans_mgr[XbarMgrDbg].obi_areq),
    .master_addr_o     (obi_a_chans_mgr[XbarMgrDbg].obi_aadr),
    .master_we_o       (obi_a_chans_mgr[XbarMgrDbg].obi_awe),
    .master_be_o       (obi_a_chans_mgr[XbarMgrDbg].obi_abe),
    .master_wdata_o    (obi_a_chans_mgr[XbarMgrDbg].obi_awdata),
    .master_gnt_i      (obi_agnt_signals_mgr[XbarMgrDbg]),
    .master_rvalid_i   (obi_r_chans_mgr[XbarMgrDbg].obi_rvalid),
    .master_rdata_i    (obi_r_chans_mgr[XbarMgrDbg].obi_rdata),
    .master_err_i      (obi_r_chans_mgr[XbarMgrDbg].obi_rerr),
    .master_other_err_i(1'b0),

    .dmi_rst_ni        (dmi_rstn_i),
    .dmi_req_valid_i   (dmi_req_valid_i),
    .dmi_req_ready_o   (dmi_req_ready_o),
    .dmi_req_i         (dmi_req_i),

    .dmi_resp_valid_o  (dmi_resp_valid_o),
    .dmi_resp_ready_i  (dmi_resp_ready_i),
    .dmi_resp_o        (dmi_resp_o)
  );


  // Handle the clock signal
  /*always #1 clk = ~clk;
  initial begin
    clk = 1'b0;
  end*/
endmodule