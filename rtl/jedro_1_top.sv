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

module jedro_1_top
(
  input logic clk_i,
  input logic rstn_i,

  ram_read_io.MASTER instr_mem_if,
  ram_rw_io.MASTER data_mem_if

 // IRQ/Debug interface TODO

);

/****************************************
* SIGNAL DECLARATION
****************************************/
logic                      ifu_decoder_instr_valid;
logic [DATA_WIDTH-1:0]     ifu_decoder_instr_addr;
logic [DATA_WIDTH-1:0]     ifu_decoder_instr;
logic                      decoder_ifu_ready; 
logic [ALU_OP_WIDTH-1:0]   decoder_alu_sel;
logic                      decoder_alu_op_a;
logic                      decoder_alu_op_b;
logic [REG_ADDR_WIDTH-1:0] decoder_alu_dest_addr;
logic                      decoder_alu_wb;
logic [REG_ADDR_WIDTH-1:0] decoder_rf_addr_a;
logic [REG_ADDR_WIDTH-1:0] decoder_rf_addr_b;
logic [DATA_WIDTH-1:0]     decoder_mux_imm_ex;
logic                      decoder_mux_is_imm;
logic [DATA_WIDTH-1:0]     decoder_mux2_instr_addr;
logic                      decoder_mux2_is_auipc;
logic [DATA_WIDTH-1:0]     alu_rf_res;
logic [REG_ADDR_WIDTH-1:0] alu_rf_dest_addr;
logic                      alu_rf_wb;
logic                      alu_overflow;
logic [DATA_WIDTH-1:0]     rf_alu_data_a;
logic [DATA_WIDTH-1:0]     rf_alu_data_b;
logic [DATA_WIDTH-1:0]     mux_alu_op_b;
logic [DATA_WIDTH-1:0]     mux2_alu_op_a;


/****************************************
* INSTRUCTION FETCH STAGE
****************************************/
jedro_1_ifu ifu_inst(.clk_i          (clk_i),
                     .rstn_i         (rstn_i),
                     .jmp_instr_i    (1'b0),
                     .jmp_address_i  (32'b0),
                     .instr_ro       (ifu_decoder_instr),
                     .instr_addr_ro  (ifu_decoder_instr_addr),
                     .instr_valid_ro (ifu_decoder_instr_valid), 
                     .decoder_ready_i(decoder_ifu_ready), 
                     .instr_mem_if   (instr_mem_if)
                     );  


/****************************************
* INSTRUCTION DECODE STAGE
****************************************/
jedro_1_decoder decoder_inst(.clk_i           (clk_i),
                             .rstn_i          (rstn_i),                  
                             .instr_addr_i    (ifu_decoder_instr_addr),
                             .instr_addr_ro   (decoder_mux2_instr_addr),
                             .is_auipc_ro     (decoder_mux2_is_auipc),
                             .instr_i         (ifu_decoder_instr),
                             .instr_valid_i   (ifu_decoder_instr_valid),
                             .ready_co        (decoder_ifu_ready),
                             .illegal_instr_ro(), // TODO
                             .alu_sel_ro      (decoder_alu_sel), 
                             .alu_op_a_ro     (decoder_alu_op_a), 
                             .alu_op_b_ro     (decoder_alu_op_b), 
                             .alu_dest_addr_ro(decoder_alu_dest_addr),
                             .alu_wb_ro       (decoder_alu_wb),
                             .rf_addr_a_ro    (decoder_rf_addr_a), 
                             .rf_addr_b_ro    (decoder_rf_addr_b),
                             .is_imm_ro       (decoder_mux_is_imm), 
                             .imm_ext_ro      (decoder_mux_imm_ex),
                             .lsu_new_ctrl_ro (), 
                             .lsu_ctrl_ro     (), // TODO
                             .lsu_regdest_ro  ()
                           );


/*********************************************
* INSTRUCTION EXECUTE STAGE - ALU/REGFILE/MUX
*********************************************/
jedro_1_regfile #(.DATA_WIDTH(32)) regfile_inst(.clk_i        (clk_i),
                                                .rstn_i       (rstn_i),
                                                .rpa_addr_i   (decoder_rf_addr_a),
                                                .rpa_data_co  (rf_alu_data_a),
                                                .rpb_addr_i   (decoder_rf_addr_b),
                                                .rpb_data_co  (rf_alu_data_b),
                                                .wpc_addr_i   (alu_rf_dest_addr),  
                                                .wpc_data_i   (alu_rf_res),     
                                                .wpc_we_i     (alu_rf_wb)
                                              );   

assign mux2_alu_op_a = decoder_mux2_is_auipc ? decoder_mux2_instr_addr : rf_alu_data_a;
// decoder_mux_is_imm signal tells if an operation is between 2 registers or an
// register and an immediate. Based on this the 2:1 MUX bellow selects the 
// mux_alu_op_b
assign mux_alu_op_b = decoder_mux_is_imm ? decoder_mux_imm_ex : rf_alu_data_b;


jedro_1_alu alu_inst(.clk_i       (clk_i),
                     .rstn_i      (rstn_i),
                     .sel_i       (decoder_alu_sel),
                     .op_a_i      (mux2_alu_op_a),
                     .op_b_i      (mux_alu_op_b),
                     .res_ro      (alu_rf_res),
                     .overflow_ro (alu_overflow),
                     .dest_addr_i (decoder_alu_dest_addr),
                     .dest_addr_ro(alu_rf_dest_addr),
                     .wb_i        (decoder_alu_wb),
                     .wb_ro       (alu_rf_wb) 
                   ); 


/*********************************************
* WRITEBACK STAGE 
*********************************************/
// TODO


// Note that the ICARUS flag needs to be set in the makefile arguments
`ifdef COCOTB_SIM
`ifdef ICARUS
initial begin
  $dumpfile ("jedro_1_top_testing.vcd");
  $dumpvars (0, jedro_1_top);
end
`endif
`endif

endmodule : jedro_1_top
