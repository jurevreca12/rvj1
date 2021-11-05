////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jure Vreca - jurevreca12@gmail.com                         //
//                                                                            //
//                                                                            //
//                                                                            //
// Design Name:    jedro_1_top                                                //
// Project Name:   riscv-jedro-1                                              //
// Language:       System Verilog                                             //
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
  ram_rw_io.MASTER   data_mem_if

 // IRQ/Debug interface TODO

);

/****************************************
* SIGNAL DECLARATION
****************************************/
logic                      ifu_decoder_instr_valid;
logic [DATA_WIDTH-1:0]     ifu_decoder_instr_addr;
logic [DATA_WIDTH-1:0]     ifu_decoder_instr;
logic [DATA_WIDTH-1:0]     mux3_ifu_jmp_addr;
logic                      decoder_ifu_ready; 
logic                      decoder_ifu_jmp_instr;
logic [DATA_WIDTH-1:0]     decoder_ifu_jmp_addr;
logic                      decoder_mux3_use_alu_jmp_addr;
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
logic                      decoder_mux2_use_pc;
logic [DATA_WIDTH-1:0]     alu_mux4_res;
logic [REG_ADDR_WIDTH-1:0] alu_mux4_dest_addr;
logic                      alu_mux4_wb;
logic                      alu_overflow;
logic                      alu_decoder_ops_eq;
logic [DATA_WIDTH-1:0]     rf_alu_data_a;
logic [DATA_WIDTH-1:0]     rf_alu_data_b;
logic [DATA_WIDTH-1:0]     mux_alu_op_b;
logic [DATA_WIDTH-1:0]     mux2_alu_op_a;
logic                      decoder_1_lsu_ctrl_valid;
logic                      decoder_lsu_ctrl_valid;
logic                      decoder_1_lsu_ctrl;
logic                      decoder_lsu_ctrl;
logic                      decoder_1_lsu_regdest;
logic                      decoder_lsu_regdest;
logic                      decoder_1_mux4_is_alu_write;
logic                      decoder_mux4_is_alu_write;
logic [DATA_WIDTH-1:0]     lsu_mux4_rdata;
logic                      lsu_mux4_wb;
logic [REG_ADDR_WIDTH-1:0] lsu_mux4_regdest;
logic [DATA_WIDTH-1:0]     mux4_rf_data;
logic                      mux4_rf_wb;
logic [REG_ADDR_WIDTH-1:0] mux4_rf_dest_addr;


/****************************************
* INSTRUCTION FETCH STAGE
****************************************/
jedro_1_ifu ifu_inst(.clk_i          (clk_i),
                     .rstn_i         (rstn_i),
                     .jmp_instr_i    (decoder_ifu_jmp_instr | decoder_mux3_use_alu_jmp_addr),
                     .jmp_address_i  (mux3_ifu_jmp_addr),
                     .instr_ro       (ifu_decoder_instr),
                     .instr_addr_ro  (ifu_decoder_instr_addr),
                     .instr_valid_ro (ifu_decoder_instr_valid), 
                     .decoder_ready_i(decoder_ifu_ready), 
                     .instr_mem_if   (instr_mem_if)
                     );  


assign mux3_ifu_jmp_addr = decoder_mux3_use_alu_jmp_addr ? alu_mux4_res : decoder_ifu_jmp_addr;

/****************************************
* INSTRUCTION DECODE STAGE
****************************************/
jedro_1_decoder decoder_inst(.clk_i               (clk_i),
                             .rstn_i              (rstn_i),                  
                             .instr_addr_i        (ifu_decoder_instr_addr),
                             .instr_addr_ro       (decoder_mux2_instr_addr),
                             .use_pc_ro           (decoder_mux2_use_pc),
                             .instr_i             (ifu_decoder_instr),
                             .instr_valid_i       (ifu_decoder_instr_valid),
                             .ready_co            (decoder_ifu_ready),
                             .jmp_instr_co        (decoder_ifu_jmp_instr),
                             .jmp_addr_co         (decoder_ifu_jmp_addr),
                             .use_alu_jmp_addr_ro (decoder_mux3_use_alu_jmp_addr),
                             .illegal_instr_ro    (), // TODO
                             .is_alu_write_ro     (decoder_mux4_is_alu_write),
                             .alu_sel_ro          (decoder_alu_sel), 
                             .alu_op_a_ro         (decoder_alu_op_a), 
                             .alu_op_b_ro         (decoder_alu_op_b), 
                             .alu_dest_addr_ro    (decoder_alu_dest_addr),
                             .alu_wb_ro           (decoder_alu_wb),
                             .alu_res_i           (alu_mux4_res),
                             .alu_ops_eq_i        (alu_decoder_ops_eq),
                             .rf_addr_a_ro        (decoder_rf_addr_a), 
                             .rf_addr_b_ro        (decoder_rf_addr_b),
                             .is_imm_ro           (decoder_mux_is_imm), 
                             .imm_ext_ro          (decoder_mux_imm_ex),
                             .lsu_ctrl_valid_ro   (decoder_lsu_ctrl_valid), 
                             .lsu_ctrl_ro         (decoder_lsu_ctrl),
                             .lsu_regdest_ro      (decoder_lsu_regdest)
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
                                                .wpc_addr_i   (mux4_rf_dest_addr),  
                                                .wpc_data_i   (mux4_rf_data),     
                                                .wpc_we_i     (mux4_rf_wb)
                                              );   

assign mux2_alu_op_a = decoder_mux2_use_pc ? decoder_mux2_instr_addr : rf_alu_data_a;
// decoder_mux_is_imm signal tells if an operation is between 2 registers or an
// register and an immediate. Based on this the 2:1 MUX bellow selects the 
// mux_alu_op_b
assign mux_alu_op_b = decoder_mux_is_imm ? decoder_mux_imm_ex : rf_alu_data_b;


jedro_1_alu alu_inst(.clk_i       (clk_i),
                     .rstn_i      (rstn_i),
                     .sel_i       (decoder_alu_sel),
                     .op_a_i      (mux2_alu_op_a),
                     .op_b_i      (mux_alu_op_b),
                     .res_ro      (alu_mux4_res),
                     .ops_eq_ro   (alu_decoder_ops_eq),
                     .overflow_ro (alu_overflow),
                     .dest_addr_i (decoder_alu_dest_addr),
                     .dest_addr_ro(alu_mux4_dest_addr),
                     .wb_i        (decoder_alu_wb),
                     .wb_ro       (alu_mux4_wb) 
                   ); 


/*********************************************
* WRITEBACK STAGE 
*********************************************/
// We delay the signals by 1 clock cycle that is used
// for computing the target address.
always_ff @(posedge clk_i) begin
    if (rstn_i == 1'b0) begin        
        decoder_1_lsu_ctrl_valid <= 1'b0;
        decoder_1_lsu_ctrl <= 4'b0000;
        decoder_1_lsu_regdest <= 5'b00000;
        decoder_1_mux4_is_alu_write <= 1'b1;
    end
    else begin
        decoder_1_lsu_ctrl_valid <= decoder_lsu_ctrl_valid;
        decoder_1_lsu_ctrl <= decoder_lsu_ctrl;
        decoder_1_lsu_regdest <= decoder_lsu_regdest;
        decoder_1_mux4_is_alu_write <= decoder_mux4_is_alu_write;
    end
end

// MUX4
always_comb begin
    if (decoder_1_mux4_is_alu_write == 1'b1) begin
        mux4_rf_dest_addr = alu_mux4_dest_addr;
        mux4_rf_data      = alu_mux4_res;
        mux4_rf_wb        = alu_mux4_wb;
    end
    else begin
        mux4_rf_dest_addr = lsu_mux4_regdest;
        mux4_rf_data      = lsu_mux4_rdata;
        mux4_rf_wb        = lsu_mux4_wb;
    end
end


jedro_1_lsu lsu_inst(.clk_i       (clk_i),
                     .rstn_i      (rstn_i),
                     .ctrl_valid_i(decoder_1_lsu_ctrl_valid),
                     .ctrl_i      (decoder_1_lsu_ctrl),
                     .addr_i      (alu_mux4_res),
                     .wdata_i     (rf_alu_data_a),
                     .rdata_o     (lsu_mux4_rdata),
                     .rf_wb_o     (lsu_mux4_wb),
                     .regdest_i   (decoder_1_lsu_regdest),
                     .regdest_o   (lsu_mux4_regdest),
                     .data_mem_if (data_mem_if)
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

endmodule : jedro_1_top
