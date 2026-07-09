
module rvj1_debug_top();
  parameter  string       INIT_FILE      = "";
  parameter  int          INIT_FILE_BIN  = 0;
  parameter  int          MEM_SIZE_WORDS = 200000000;
  parameter  int unsigned JTAG_VPI_PORT  = 9999;
  parameter  int unsigned TIMEOUT        = 10000000;

  logic clk, rstn;
  integer unsigned i;

  logic [31:0] sim_jtag_exit;
  logic        sim_jtag_tck;
  logic        sim_jtag_tms;
  logic        sim_jtag_tdi;
  logic        sim_jtag_trstn;
  logic        sim_jtag_tdo;
  

  rvj1_cosim_top #(
    .INIT_FILE     (INIT_FILE),
    .INIT_FILE_BIN (INIT_FILE_BIN),
    .MEM_SIZE_WORDS(MEM_SIZE_WORDS),
    .JTAG_VPI_PORT (JTAG_VPI_PORT)
  ) rvj1_debug_top (
    .clk            (clk),
    .rstn           (rstn),

    .sim_jtag_tck   (sim_jtag_tck),
    .sim_jtag_tms   (sim_jtag_tms),
    .sim_jtag_tdi   (sim_jtag_tdi),
    .sim_jtag_trstn (sim_jtag_trstn),
    .sim_jtag_tdo   (sim_jtag_tdo),

    .irq_external_i (1'b0),
    .irq_timer_i    (1'b0),
    .irq_sw_i       (1'b0),
    .irq_lcofi_i    (1'b0),
    .irq_platform_i ('0),
    .irq_nmi_i      (1'b0)
  );

  SimJTAG #(
    .TICK_DELAY(1),
    .PORT(JTAG_VPI_PORT)
  ) sim_jtag_inst (
    .clock          (clk),
    .reset          (~rstn),
    .enable         (1'b1),
    .init_done      (rstn),
    .jtag_TCK       (sim_jtag_tck),
    .jtag_TMS       (sim_jtag_tms),
    .jtag_TDI       (sim_jtag_tdi),
    .jtag_TRSTn     (sim_jtag_trstn),
    .jtag_TDO_data  (sim_jtag_tdo),
    .jtag_TDO_driven(1'b1),
    .exit           (sim_jtag_exit)
  );


  always_comb begin: jtag_exit_handler
    if ((sim_jtag_exit != '0) && rstn) begin
      $display("SimJTAG requested exit. Ending simulation.");
      $finish(2);
    end
  end

 // Handle the clock signal
  always #1 clk = ~clk;

  initial begin
  $display("Starting debug simulation of RVJ1");
  $dumpfile("dump.vcd");
  $dumpvars();
  clk = 1'b0;
  rstn = 1'b0;
  repeat (3) @ (posedge clk);
  rstn = 1'b1;

  i=0;
  while (i < TIMEOUT) begin
    @(posedge clk);
    i=i+1;
  end

  $finish;
  end
endmodule