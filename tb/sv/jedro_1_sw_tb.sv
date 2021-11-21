// A basic test of the sw (store word) instruction.
`timescale 1ns/1ps

module jedro_1_sw_tb();
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 32;

  logic clk;
  logic rstn;
  
  int i;


  // Instruction interface  
  ram_read_io #(.ADDR_WIDTH(ADDR_WIDTH), 
                .DATA_WIDTH(DATA_WIDTH)) instr_mem_if();

  rams_init_file_wrap #(.MEM_INIT_FILE("jedro_1_sw_tb.mem")) rom_mem (.clk_i(clk),
                                                                      .rom_if(instr_mem_if.SLAVE));

  // Data interface
  ram_rw_io data_mem_if();
  rams_sp_nc_wrap data_mem (.clk_i (clk),
                            .ram_if(data_mem_if.SLAVE);


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

  
  assert (data_mem.data_mem.RAM[0] == 32'b00000000_00000000_00000000_00000000 &&
          data_mem.data_mem.RAM[4] == 32'b00000000_00000000_00000000_00000000) 
  else $display("ERROR: At reset data memory should be set to zero. Instead the value
                 at address 0 and 4 were %d, and $d, respectively.", 
                 data_mem.data_mem.RAM[0], data_mem.data_mem.RAM[4]);

  while (i < 64) begin
    @(posedge clk);
    i++;
  end

  assert (dut.regfile_inst.regfile[1] == 0) 
  else $display("ERROR: After executing jedro_1_sw_tb.mem the value in register 1 should be 0, not %d.", 
                $signed(dut.regfile_inst.regfile[1]));
  

  assert (data_mem.data_mem.RAM[0] == 32'b00000000_00000000_00000000_00001101 &&
          data_mem.data_mem.RAM[4] == 32'b11111111_11111111_11111111_11111111) 
  else $display("ERROR: At reset data memory should be set to 13 and 4294967295. Instead the value
                 at address 0 and 4 were %d, and $d, respectively.", 
                 data_mem.data_mem.RAM[0], data_mem.data_mem.RAM[4]);

  $finish;
  end

endmodule : jedro_1_sw_tb
