////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreča - jurevreca12@gmail.com                       //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_top                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       Verilog                                                    //
//                                                                            //
// Description:    The top file of the jedro_1 riscv core.                    //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
  
import jedro_1_defines::*;
`include "if_ram_1way.sv"
`include "if_ram_2way_32b_data.sv"

module jedro_1_top
(
  input clk_i,
  input rstn_i,

  if_ram_1way.MASTER          if_instr_ram,
  if_ram_2way_32b_data.MASTER if_data_ram

 // IRQ/Debug interface TODO

);

logic [ALU_OP_WIDTH-1:0]   alu_op_sel;
logic                      alu_reg_op_a;
logic                      alu_reg_op_b;
logic [REG_ADDR_WIDTH-1:0] alu_reg_op_a_addr;
logic [REG_ADDR_WIDTH-1:0] alu_reg_op_b_addr;
logic [DATA_WIDTH-1:0]     reg_op_a_data;
logic [DATA_WIDTH-1:0]     reg_op_b_data;
logic [DATA_WIDTH-1:0]     alu_result_data;
logic [DATA_WIDTH-1:0]     decoder_immediate_extended;
logic [DATA_WIDTH-1:0]     mux_alu_operand_b;
logic                      alu_is_immediate;
logic [DATA_WIDTH-1:0]     ifu_current_instr;
logic                      alu_overflow;
logic [REG_ADDR_WIDTH-1:0] alu_reg_dest_addr;
logic [REG_ADDR_WIDTH-1:0] reg_writeback_addr;
logic [REG_ADDR_WIDTH-1:0] reg_writeback_addr_2;
logic                       writeback_to_reg;
logic                       writeback_to_alu;
logic                       writeback_we;

jedro_1_ifu ifu_inst(.clk_i         (clk_i),
                     .rstn_i        (rstn_i),

                     // The interface to the FSM
                     .get_next_instr_i    (1'b1), // TODO
                     .jmp_instr_i         (1'b0),
                     .jmp_address_i       (32'b0),

                     // The decoder interface
                     .cinstr_o      (ifu_current_instr),
                     
                     // The instruction interface
                     .if_instr_mem(if_instr_ram)
                     );  


jedro_1_decoder decoder_inst(.clk_i               (clk_i),
                             .rstn_i              (rstn_i),
                  
                             .instr_rdata_i       (ifu_current_instr),
                             .illegal_instr_o     (), // TODO
            
                             .alu_op_sel_o        (alu_op_sel), 
                             .alu_reg_op_a_o      (alu_reg_op_a), 
                             .alu_reg_op_b_o      (alu_reg_op_b), 
                             .alu_reg_op_a_addr_o (alu_reg_op_a_addr), 
                             .alu_reg_op_b_addr_o (alu_reg_op_b_addr),
                             .alu_reg_dest_addr_o (alu_reg_dest_addr),
                             .alu_immediate_ext_o (decoder_immediate_extended),
                             .alu_wb_o            (writeback_to_reg),

                             .lsu_new_ctrl_o      (), // TODO
                             .lsu_ctrl_o          (),
                             .lsu_regdest_o       ()
                           );



jedro_1_regfile #(.DATA_WIDTH(32)) regfile_inst(.clk_i        (clk_i),
                                                .rstn_i     (rstn_i),
                                                .rpa_addr_i   (alu_reg_op_a_addr),
                                                .rpa_data_o   (reg_op_a_data),
                                                .rpb_addr_i   (alu_reg_op_b_addr),
                                                .rpb_data_o   (reg_op_b_data),
                                                .wpc_addr_i   (reg_writeback_addr_2),  // TODO
                                                .wpc_data_i   (alu_result_data),     // TODO
                                                .wpc_we_i     (writeback_we),

                                                .reg_alu_dest_i (alu_reg_dest_addr),
                                                .reg_alu_dest_o (reg_writeback_addr),
                                                .reg_alu_wb_i   (writeback_to_reg),
                                                .reg_alu_wb_o   (writeback_to_alu)
                                              );   



// alu_is_immediate signal tells if an operation is between 2 registers or an
// register and an immediate. Based on this the 2:1 MUX bellow selects the 
// mux_alu_operand_b
assign alu_is_immediate = ~(alu_reg_op_a & alu_reg_op_b);
assign mux_alu_operand_b = alu_is_immediate ? decoder_immediate_extended : reg_op_b_data;

jedro_1_alu alu_inst(.clk_i         (clk_i),
                     .rstn_i        (rstn_i),
                     .alu_op_sel_i  (alu_op_sel),
                     .opa_i         (reg_op_a_data),
                     .opb_i         (mux_alu_operand_b),
                     .res_o         (alu_result_data),
                     .overflow_o    (alu_overflow),

                     .reg_alu_dest_addr_i (reg_writeback_addr),
                     .reg_alu_dest_addr_o (reg_writeback_addr_2),
                     .alu_reg_wb_i        (writeback_to_alu),
                     .alu_reg_wb_o        (writeback_we) // overflow signal to the FSM?
                   ); 


// Note that the ICARUS flag needs to be set in the makefile arguments
`ifdef COCOTB_SIM
`ifdef ICARUS
initial begin
  $dumpfile ("jedro_1_top_testing.vcd");
  $dumpvars (0, jedro_1_top);
end
`endif
`endif

endmodule
