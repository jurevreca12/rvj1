package rvj1_cosim_pkg;
  `include "obi_typedef.svh"

  localparam logic [6:0]  MVendorIdOffset = 7'h2;
  localparam logic [24:0] MVendorIdBank   = 25'hC;
  localparam logic [31:0] MVendorId    = {MVendorIdBank, MVendorIdOffset};
  localparam logic [31:0] MArchId      = 32'hd22;
  localparam logic [31:0] MImpId       = '0;
  localparam int unsigned MHartId      = 0;

  localparam logic [31:0] BootAddr  = 32'h1000_0000;
  localparam logic [31:0] DmRomAddr = 32'h0000_0800;
  localparam logic [31:0] DmExcAddr = 32'h0000_0810;
  localparam int unsigned AddrWidth = 32;
  localparam int unsigned DataWidth = 32;
  localparam int unsigned NBytes    = (DataWidth / 8);
  localparam int unsigned IdWidth   = 4;

  localparam dm::hartinfo_t HartInfo = '{
    zero0: '0,
    zero1: '0,
    nscratch: 2,
    dataaccess: 1'b1,
    datasize: dm::DataCount,
    dataaddr: dm::DataAddr
  };

  localparam int unsigned NumManagers     = 3;
  localparam int unsigned NumSubordinates = 2;

  typedef enum int {
    XbarSbrMem   = 0,
    XbarSbrDbg   = 1
  } xbar_sub_e;

  typedef enum int {
    XbarMgrLsu   = 0,
    XbarMgrIfu   = 1,
    XbarMgrDbg   = 2
  } xbar_mgr_e;


  // Xbar & Obi config
  localparam obi_pkg::xbar_cfg_t xbar_cfg = obi_pkg::xbar_default_cfg(
    NumManagers, NumSubordinates, AddrWidth, DataWidth, IdWidth
  );

  localparam bit unsigned [xbar_cfg.Subordinates-1:0] UseSrFifoMask = 2'b11;
  localparam int unsigned SrFifoDepth [xbar_cfg.Subordinates] = '{4,4};

  typedef struct packed {
        logic [xbar_cfg.IdWidth-1:0]          obi_aid;
        logic [$clog2(xbar_cfg.Managers)-1:0] obi_mid;
  } obi_sub_id_t;

  typedef struct packed {
        logic                               obi_areq;
        logic [xbar_cfg.AddrWidth-1:0]      obi_aadr;
        logic                               obi_awe; 
        logic [xbar_cfg.DataWidth/8-1:0]    obi_abe;
        logic [xbar_cfg.DataWidth-1:0]      obi_awdata;
        logic [xbar_cfg.IdWidth-1:0]        obi_aid;
    } mgr_obi_a_t;

  typedef struct packed {
        logic                               obi_rvalid;
        logic                               obi_rerr;
        logic [xbar_cfg.DataWidth-1:0]      obi_rdata;
        logic [xbar_cfg.IdWidth-1:0]        obi_rid;
    } mgr_obi_r_t;

  typedef struct packed {
        logic                               obi_areq;
        logic [xbar_cfg.AddrWidth-1:0]      obi_aadr;
        logic                               obi_awe; 
        logic [xbar_cfg.DataWidth/8-1:0]    obi_abe;
        logic [xbar_cfg.DataWidth-1:0]      obi_awdata;
        logic [(xbar_cfg.IdWidth+2)-1:0]    obi_aid;
    } sub_obi_a_t;

  typedef struct packed {
        logic                               obi_rvalid;
        logic                               obi_rerr;
        logic [xbar_cfg.DataWidth-1:0]      obi_rdata;
        logic [(xbar_cfg.IdWidth+2)-1:0]    obi_rid;
    } sub_obi_r_t;

  `TYPEDEF_XBAR_ADDR_MAP(addr_map_t, AddrWidth, NumSubordinates)

  `TYPEDEF_XBAR_CONNECTIVITY(Connectivity, NumSubordinates, NumManagers, {{2'b11}, {2'b11}, {2'b11}})

endpackage