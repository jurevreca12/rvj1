////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    rvj1_obi                                                   //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
//                                                                            //
// Description:    RVJ1 with an OBI interface wrapper.                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* verilator lint_off IMPORTSTAR */
module rvj1_obi import rvj1_pkg::*; #(
  parameter int unsigned BootAddr   = 32'h8000_0000,
  parameter int unsigned DmRomAddr  = 32'h0000_0000,
  parameter int unsigned DmExcAddr  = 32'h0000_0000,
  parameter int unsigned MVendorId  = 32'h0000_0000,
  parameter int unsigned MArchId    = 32'h0000_0000,
  parameter int unsigned MImpId     = 32'h0000_0000,
  parameter int unsigned MHartId    = 32'h0000_0000,
  parameter int unsigned MConfigPtr = 32'h0000_0000
)
(
  input  logic                   clk_i,
  input  logic                   rstn_i,

  output logic [IDLEN-1:0]       instr_aid_o,
  output logic                   instr_areq_o,
  input  logic                   instr_agnt_i,
  output logic [XLEN-1:0]        instr_aaddr_o,
  output logic                   instr_awe_o,
  output logic [NBYTES-1:0]      instr_abe_o,
  output logic [XLEN-1:0]        instr_awdata_o,

  input  logic [IDLEN-1:0]       instr_rid_i,
  input  logic                   instr_rvalid_i,
  output logic                   instr_rready_o,
  input  logic [XLEN-1:0]        instr_rdata_i,
  input  logic                   instr_rerr_i,
  
  output logic [IDLEN-1:0]       data_aid_o,
  output logic                   data_areq_o,
  input  logic                   data_agnt_i,
  output logic [XLEN-1:0]        data_aaddr_o,
  output logic                   data_awe_o,
  output logic [NBYTES-1:0]      data_abe_o,
  output logic [XLEN-1:0]        data_awdata_o,

  input  logic [IDLEN-1:0]       data_rid_i,
  input  logic                   data_rvalid_i,
  output logic                   data_rready_o,
  input  logic [XLEN-1:0]        data_rdata_i,
  input  logic                   data_rerr_i,

  input logic                    irq_external_i,
  input logic                    irq_timer_i,
  input logic                    irq_sw_i,
  input logic                    irq_lcofi_i,
  input logic [15:0]             irq_platform_i,
  input logic                    irq_nmi_i,

  input  logic                   debug_req_i,
  output logic                   debug_rsp_o
);

  logic [IDLEN-1:0]       instr_req_id;
  logic [XLEN-1:0]        instr_req_addr;
  logic [XLEN-1:0]        instr_req_data;
  logic [NBYTES-1:0]      instr_req_strobe;
  logic                   instr_req_write;
  logic                   instr_req_valid;
  logic                   instr_req_ready;

  logic [IDLEN-1:0]       instr_rsp_id;
  logic [XLEN-1:0]        instr_rsp_data;
  logic                   instr_rsp_error;
  logic                   instr_rsp_valid;
  logic                   instr_rsp_ready;

  logic [IDLEN-1:0]       data_req_id;
  logic [XLEN-1:0]        data_req_addr;
  logic [XLEN-1:0]        data_req_data;
  logic [NBYTES-1:0]      data_req_strobe;
  logic                   data_req_write;
  logic                   data_req_valid;
  logic                   data_req_ready;

  logic [IDLEN-1:0]       data_rsp_id;
  logic [XLEN-1:0]        data_rsp_data;
  logic                   data_rsp_error;
  logic                   data_rsp_valid;
  logic                   data_rsp_ready;

  rvj1_top #(
    .BootAddr(BootAddr),
    .DmRomAddr(DmRomAddr),
    .DmExcAddr(DmExcAddr),
    .MVendorId(MVendorId),
    .MArchId(MArchId),
    .MImpId(MImpId),
    .MHartId(MHartId),
    .MConfigPtr(MConfigPtr)
  ) rvj1_inst (
    .clk_i              (clk_i),
    .rstn_i             (rstn_i),

    .instr_req_id_o     (instr_req_id),
    .instr_req_addr_o   (instr_req_addr),
    .instr_req_data_o   (instr_req_data),
    .instr_req_strobe_o (instr_req_strobe),
    .instr_req_write_o  (instr_req_write),
    .instr_req_valid_o  (instr_req_valid),
    .instr_req_ready_i  (instr_req_ready),

    .instr_rsp_id_i     (instr_rsp_id),
    .instr_rsp_data_i   (instr_rsp_data),
    .instr_rsp_error_i  (instr_rsp_error),
    .instr_rsp_valid_i  (instr_rsp_valid),
    .instr_rsp_ready_o  (instr_rsp_ready),

    .data_req_id_o      (data_req_id),
    .data_req_addr_o    (data_req_addr),
    .data_req_data_o    (data_req_data),
    .data_req_strobe_o  (data_req_strobe),
    .data_req_write_o   (data_req_write),
    .data_req_valid_o   (data_req_valid),
    .data_req_ready_i   (data_req_ready),

    .data_rsp_id_i      (data_rsp_id),
    .data_rsp_data_i    (data_rsp_data),
    .data_rsp_error_i   (data_rsp_error),
    .data_rsp_valid_i   (data_rsp_valid),
    .data_rsp_ready_o   (data_rsp_ready),

    .irq_external_i,
    .irq_timer_i,
    .irq_sw_i,
    .irq_lcofi_i,
    .irq_platform_i,
    .irq_nmi_i,

    .debug_req_i,
    .debug_rsp_o
  );

  mapped2obi #(
    .ADDR_WIDTH(XLEN),
    .DATA_WIDTH(XLEN),
    .IDLEN(IDLEN)) m2o_instr (

    .mapped_req_id_i     (instr_req_id),
    .mapped_req_addr_i   (instr_req_addr),
    .mapped_req_data_i   (instr_req_data),
    .mapped_req_strobe_i (instr_req_strobe),
    .mapped_req_write_i  (instr_req_write),
    .mapped_req_valid_i  (instr_req_valid),
    .mapped_req_ready_o  (instr_req_ready),

    .mapped_rsp_id_o     (instr_rsp_id),
    .mapped_rsp_data_o   (instr_rsp_data),
    .mapped_rsp_error_o  (instr_rsp_error),
    .mapped_rsp_valid_o  (instr_rsp_valid),
    .mapped_rsp_ready_i  (instr_rsp_ready),

    .obi_aid_o           (instr_aid_o),
    .obi_areq_o          (instr_areq_o),
    .obi_agnt_i          (instr_agnt_i),
    .obi_aaddr_o         (instr_aaddr_o),
    .obi_awe_o           (instr_awe_o),
    .obi_abe_o           (instr_abe_o),
    .obi_awdata_o        (instr_awdata_o),

    .obi_rid_i           (instr_rid_i),
    .obi_rvalid_i        (instr_rvalid_i),
    .obi_rready_o        (instr_rready_o),
    .obi_rdata_i         (instr_rdata_i),
    .obi_rerr_i          (instr_rerr_i)
  );

  mapped2obi #(
    .ADDR_WIDTH(XLEN),
    .DATA_WIDTH(XLEN),
    .IDLEN(IDLEN)) m2o_data (

    .mapped_req_id_i     (data_req_id),
    .mapped_req_addr_i   (data_req_addr),
    .mapped_req_data_i   (data_req_data),
    .mapped_req_strobe_i (data_req_strobe),
    .mapped_req_write_i  (data_req_write),
    .mapped_req_valid_i  (data_req_valid),
    .mapped_req_ready_o  (data_req_ready),

    .mapped_rsp_id_o     (data_rsp_id),
    .mapped_rsp_data_o   (data_rsp_data),
    .mapped_rsp_error_o  (data_rsp_error),
    .mapped_rsp_valid_o  (data_rsp_valid),
    .mapped_rsp_ready_i  (data_rsp_ready),

    .obi_aid_o           (data_aid_o),
    .obi_areq_o          (data_areq_o),
    .obi_agnt_i          (data_agnt_i),
    .obi_aaddr_o         (data_aaddr_o),
    .obi_awe_o           (data_awe_o),
    .obi_abe_o           (data_abe_o),
    .obi_awdata_o        (data_awdata_o),

    .obi_rid_i           (data_rid_i),
    .obi_rvalid_i        (data_rvalid_i),
    .obi_rready_o        (data_rready_o),
    .obi_rdata_i         (data_rdata_i),
    .obi_rerr_i          (data_rerr_i)
  );
endmodule
