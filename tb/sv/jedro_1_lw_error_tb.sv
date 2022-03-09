// A load test where instead of an ack an err signal is returned
`timescale 1ns/1ps

module jedro_1_lw_error_tb();
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 32;

  logic clk;
  logic rstn;
  
  int i;


  // Instruction interface  
  ram_read_io #(.ADDR_WIDTH(ADDR_WIDTH), 
                .DATA_WIDTH(DATA_WIDTH)) instr_mem_if();

  rams_init_file_wrap #(.MEM_INIT_FILE("jedro_1_lw_error_tb.mem")) rom_mem (.clk_i(clk),
                                                                            .rom_if(instr_mem_if.SLAVE));

  // Data interface
  ram_rw_io data_mem_if();
  bytewrite_ram_error_wrap data_mem (.clk_i  (clk),
                                     .rstn_i (rstn),
                                     .ram_if (data_mem_if.SLAVE));


  jedro_1_top dut(.clk_i       (clk),
                  .rstn_i      (rstn),
                  .instr_mem_if(instr_mem_if.MASTER),
                  .data_mem_if (data_mem_if.MASTER)
                );


  // Handle the clock signal
  always #1 clk = ~clk;

  initial begin
  clk <= 1'b0;
  rstn <= 1'b0;
  repeat (3) @ (posedge clk);
  rstn <= 1'b1;
 
  while (i < 64 && dut.decoder_inst.illegal_instr_ro == 0) begin
    @(posedge clk);
    i++;
  end
  repeat (3) @ (posedge clk); // finish instructions in the pipeline

  assert (dut.regfile_inst.regfile[1] == 3) 
  else $display("ERROR: After executing jedro_1_lw_error_tb.mem the value in registers 1 should  be 3. Not %d.", 
                 dut.regfile_inst.regfile[1]);


  $finish;
  end

endmodule : jedro_1_lw_error_tb
