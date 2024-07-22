// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vjedro_1_or_tb.h for the primary calling header

#ifndef VERILATED_VJEDRO_1_OR_TB___024ROOT_H_
#define VERILATED_VJEDRO_1_OR_TB___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vjedro_1_or_tb__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vjedro_1_or_tb___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        CData/*0:0*/ jedro_1_or_tb__DOT__clk;
        CData/*0:0*/ jedro_1_or_tb__DOT__rstn;
        CData/*0:0*/ jedro_1_or_tb__DOT__ack;
        CData/*3:0*/ jedro_1_or_tb__DOT__we;
        CData/*0:0*/ jedro_1_or_tb__DOT__stb;
        CData/*0:0*/ jedro_1_or_tb__DOT__iram_rdata;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_ifu_ready;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_ifu_jmp_instr;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_mux3_use_alu_jmp_addr;
        CData/*3:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_alu_sel;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_alu_dest_addr;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_alu_wb;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_rf_addr_a;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_rf_addr_b;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_mux_is_imm;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_mux2_use_pc;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_csr_we;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_csr_uimm;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_csr_uimm_we;
        CData/*1:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_csr_wmode;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_csr_mret;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_csr_illegal_instr;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_csr_ecall;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_csr_ebreak;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_mux4_dest_addr;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_mux4_wb;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_decoder_ops_eq;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_lsu_ctrl_valid;
        CData/*3:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_lsu_ctrl;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_lsu_regdest;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_1_mux4_is_alu_write;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_mux4_is_alu_write;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_mux4_wb;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_mux4_regdest;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_csr_misaligned_load;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_csr_misaligned_store;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_csr_bus_error;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__mux4_rf_wb;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__mux4_rf_dest_addr;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_ifu_trap;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_csr_exception;
        CData/*5:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__state;
        CData/*5:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__next;
        CData/*2:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__stall_begin_pulse;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__stall_begin_pulse_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__prev_ready;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_pulse;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__jmp_instr;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__is_exception;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w;
        CData/*3:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__ecall_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__ebreak_w;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w;
    };
    struct {
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w;
        CData/*3:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__ready_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__csr_we_w;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__csr_uimm_data_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__csr_uimm_we_w;
        CData/*1:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__csr_wmode_w;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w;
        CData/*4:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__sw_irq_i;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__timer_irq_i;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__ext_irq_i;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_n;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_exc;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_n;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_exc;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mip_msip_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mip_mtip_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mip_meip_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_msie_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_msie_n;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_mtie_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_mtie_n;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_meie_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_meie_n;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__is_exception;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_0____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_1____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_2____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_3____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_4____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_5____pinNumber4;
    };
    struct {
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_6____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_7____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_8____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_9____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_10____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_11____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_12____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_13____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_14____pinNumber4;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_15____pinNumber4;
        CData/*1:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_inst__DOT__byte_addr_r;
        CData/*3:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load_hold;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_store;
        CData/*0:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold;
        CData/*0:0*/ __VstlDidInit;
        CData/*0:0*/ __VstlFirstIteration;
        CData/*0:0*/ __Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__clk__0;
        CData/*0:0*/ __VactDidInit;
        CData/*0:0*/ __VactContinue;
        SData/*11:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_csr_addr;
        SData/*11:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__csr_addr_w;
        IData/*31:0*/ jedro_1_or_tb__DOT__i;
        IData/*31:0*/ jedro_1_or_tb__DOT__rdata;
        IData/*31:0*/ jedro_1_or_tb__DOT__addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__wdata;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__mux3_ifu_jmp_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_ifu_jmp_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_mux_imm_ex;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_mux2_instr_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_1_mux2_instr_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_decoder_data;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_mux4_res;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__mux_alu_op_b;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__mux2_alu_op_a;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_csr_misaligned_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__mux4_rf_data;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_ifu_mtvec;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_csr_fault_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_instr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_instr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_instr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_instr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_addr;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__csr_temp_r;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_save_r;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__data_n;
        IData/*29:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtvec_base_r;
        IData/*29:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtvec_base_n;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mscratch_r;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mscratch_n;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_r;
    };
    struct {
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_n;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_r;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_n;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_r;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_n;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__adder_res;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__xor_res;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_res;
        IData/*30:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0;
        IData/*30:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1;
        IData/*30:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_inst__DOT__data_r;
        IData/*31:0*/ jedro_1_or_tb__DOT__dut__DOT__lsu_inst__DOT__active_write_word;
        IData/*31:0*/ __Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2__0;
        IData/*30:0*/ __Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2__0;
        IData/*31:0*/ __Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2__1;
        IData/*30:0*/ __Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2__1;
        IData/*31:0*/ __VactIterCount;
        QData/*40:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__state;
        QData/*40:0*/ jedro_1_or_tb__DOT__dut__DOT__decoder_inst__DOT__next;
        VlUnpacked<IData/*31:0*/, 4096> jedro_1_or_tb__DOT__data_mem__DOT__data_ram__DOT__RAM;
        VlUnpacked<IData/*31:0*/, 32> jedro_1_or_tb__DOT__dut__DOT__regfile_inst__DOT__regfile;
        VlUnpacked<IData/*31:0*/, 4097> jedro_1_or_tb__DOT__rom_mem__DOT__rom_memory__DOT__ram;
    };
    VlDelayScheduler __VdlySched;
    VlTriggerScheduler __VtrigSched_hbc7b7924__0;
    VlTriggerVec<3> __VstlTriggered;
    VlTriggerVec<4> __VactTriggered;
    VlTriggerVec<4> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vjedro_1_or_tb__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vjedro_1_or_tb___024root(Vjedro_1_or_tb__Syms* symsp, const char* v__name);
    ~Vjedro_1_or_tb___024root();
    VL_UNCOPYABLE(Vjedro_1_or_tb___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
