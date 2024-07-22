// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vjedro_1_addi_tb.h for the primary calling header

#include "Vjedro_1_addi_tb__pch.h"
#include "Vjedro_1_addi_tb___024root.h"

VL_ATTR_COLD void Vjedro_1_addi_tb___024root___eval_initial__TOP(Vjedro_1_addi_tb___024root* vlSelf);
VlCoroutine Vjedro_1_addi_tb___024root___eval_initial__TOP__Vtiming__0(Vjedro_1_addi_tb___024root* vlSelf);
VlCoroutine Vjedro_1_addi_tb___024root___eval_initial__TOP__Vtiming__1(Vjedro_1_addi_tb___024root* vlSelf);

void Vjedro_1_addi_tb___024root___eval_initial(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___eval_initial\n"); );
    // Body
    Vjedro_1_addi_tb___024root___eval_initial__TOP(vlSelf);
    Vjedro_1_addi_tb___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vjedro_1_addi_tb___024root___eval_initial__TOP__Vtiming__1(vlSelf);
    vlSelf->__Vtrigprevexpr___TOP__jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2__0 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2;
    vlSelf->__Vtrigprevexpr___TOP__jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2__0 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2;
    vlSelf->__Vtrigprevexpr___TOP__jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2__1 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2;
    vlSelf->__Vtrigprevexpr___TOP__jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2__1 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2;
    vlSelf->__Vtrigprevexpr___TOP__jedro_1_addi_tb__DOT__clk__0 
        = vlSelf->jedro_1_addi_tb__DOT__clk;
}

VL_INLINE_OPT VlCoroutine Vjedro_1_addi_tb___024root___eval_initial__TOP__Vtiming__0(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___eval_initial__TOP__Vtiming__0\n"); );
    // Body
    vlSelf->jedro_1_addi_tb__DOT__clk = 0U;
    vlSelf->jedro_1_addi_tb__DOT__rstn = 0U;
    co_await vlSelf->__VtrigSched_hddf0f50c__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge jedro_1_addi_tb.clk)", 
                                                       "jedro_1_addi_tb.sv", 
                                                       55);
    co_await vlSelf->__VtrigSched_hddf0f50c__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge jedro_1_addi_tb.clk)", 
                                                       "jedro_1_addi_tb.sv", 
                                                       55);
    co_await vlSelf->__VtrigSched_hddf0f50c__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge jedro_1_addi_tb.clk)", 
                                                       "jedro_1_addi_tb.sv", 
                                                       55);
    vlSelf->jedro_1_addi_tb__DOT__rstn = 1U;
    while ((VL_GTS_III(32, 0x20U, vlSelf->jedro_1_addi_tb__DOT__i) 
            & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_illegal_instr)))) {
        co_await vlSelf->__VtrigSched_hddf0f50c__0.trigger(0U, 
                                                           nullptr, 
                                                           "@(posedge jedro_1_addi_tb.clk)", 
                                                           "jedro_1_addi_tb.sv", 
                                                           59);
        vlSelf->jedro_1_addi_tb__DOT__i = ((IData)(1U) 
                                           + vlSelf->jedro_1_addi_tb__DOT__i);
    }
    co_await vlSelf->__VtrigSched_hddf0f50c__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge jedro_1_addi_tb.clk)", 
                                                       "jedro_1_addi_tb.sv", 
                                                       62);
    co_await vlSelf->__VtrigSched_hddf0f50c__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge jedro_1_addi_tb.clk)", 
                                                       "jedro_1_addi_tb.sv", 
                                                       62);
    co_await vlSelf->__VtrigSched_hddf0f50c__0.trigger(0U, 
                                                       nullptr, 
                                                       "@(posedge jedro_1_addi_tb.clk)", 
                                                       "jedro_1_addi_tb.sv", 
                                                       62);
    VL_FINISH_MT("jedro_1_addi_tb.sv", 68, "");
}

VL_INLINE_OPT VlCoroutine Vjedro_1_addi_tb___024root___eval_initial__TOP__Vtiming__1(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___eval_initial__TOP__Vtiming__1\n"); );
    // Body
    while (1U) {
        co_await vlSelf->__VdlySched.delay(0x3e8ULL, 
                                           nullptr, 
                                           "jedro_1_addi_tb.sv", 
                                           50);
        vlSelf->jedro_1_addi_tb__DOT__clk = (1U & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__clk)));
    }
}

void Vjedro_1_addi_tb___024root___act_sequent__TOP__0(Vjedro_1_addi_tb___024root* vlSelf);
void Vjedro_1_addi_tb___024root___act_sequent__TOP__1(Vjedro_1_addi_tb___024root* vlSelf);

void Vjedro_1_addi_tb___024root___eval_act(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___eval_act\n"); );
    // Body
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        Vjedro_1_addi_tb___024root___act_sequent__TOP__0(vlSelf);
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        Vjedro_1_addi_tb___024root___act_sequent__TOP__1(vlSelf);
    }
}

VL_INLINE_OPT void Vjedro_1_addi_tb___024root___act_sequent__TOP__0(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___act_sequent__TOP__0\n"); );
    // Init
    IData/*31:0*/ __Vtemp_1;
    // Body
    __Vtemp_1 = ((0x80000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                 | (((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                         >> 0x1fU)) 
                                     << 0x1fU) & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                  << 1U)))) 
                 | ((0x40000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                    | (((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                            >> 0x1eU)) 
                                        << 0x1eU) & 
                                       (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                        << 1U)))) | 
                    ((0x20000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                     | (((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                             >> 0x1dU)) 
                                         << 0x1dU) 
                                        & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                           << 1U)))) 
                     | ((0x10000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                        | (((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                >> 0x1cU)) 
                                            << 0x1cU) 
                                           & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                              << 1U)))) 
                        | ((0x8000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                          | (((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                  >> 0x1bU)) 
                                              << 0x1bU) 
                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                << 1U)))) 
                           | ((0x4000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                             | (((~ 
                                                  (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                   >> 0x1aU)) 
                                                 << 0x1aU) 
                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                   << 1U)))) 
                              | ((0x2000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                | (((~ 
                                                     (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                      >> 0x19U)) 
                                                    << 0x19U) 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                      << 1U)))) 
                                 | ((0x1000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                   | (((~ 
                                                        (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                         >> 0x18U)) 
                                                       << 0x18U) 
                                                      & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                         << 1U)))) 
                                    | ((0x800000U & 
                                        (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                         | (((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                 >> 0x17U)) 
                                             << 0x17U) 
                                            & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                               << 1U)))) 
                                       | ((0x400000U 
                                           & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                              | (((~ 
                                                   (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                    >> 0x16U)) 
                                                  << 0x16U) 
                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                    << 1U)))) 
                                          | ((0x200000U 
                                              & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                 | (((~ 
                                                      (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                       >> 0x15U)) 
                                                     << 0x15U) 
                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                       << 1U)))) 
                                             | ((0x100000U 
                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                    | (((~ 
                                                         (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                          >> 0x14U)) 
                                                        << 0x14U) 
                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                          << 1U)))) 
                                                | ((0x80000U 
                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                       | (((~ 
                                                            (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                             >> 0x13U)) 
                                                           << 0x13U) 
                                                          & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                             << 1U)))) 
                                                   | ((0x40000U 
                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                          | (((~ 
                                                               (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                >> 0x12U)) 
                                                              << 0x12U) 
                                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                << 1U)))) 
                                                      | ((0x20000U 
                                                          & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                             | (((~ 
                                                                  (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                   >> 0x11U)) 
                                                                 << 0x11U) 
                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                   << 1U)))) 
                                                         | ((0x10000U 
                                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                | (((~ 
                                                                     (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                      >> 0x10U)) 
                                                                    << 0x10U) 
                                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                      << 1U)))) 
                                                            | ((0x8000U 
                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                   | (((~ 
                                                                        (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                         >> 0xfU)) 
                                                                       << 0xfU) 
                                                                      & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                         << 1U)))) 
                                                               | ((0x4000U 
                                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                      | (((~ 
                                                                           (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                            >> 0xeU)) 
                                                                          << 0xeU) 
                                                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                            << 1U)))) 
                                                                  | ((0x2000U 
                                                                      & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                         | (((~ 
                                                                              (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                               >> 0xdU)) 
                                                                             << 0xdU) 
                                                                            & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                               << 1U)))) 
                                                                     | ((0x1000U 
                                                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                            | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 0xcU)) 
                                                                                << 0xcU) 
                                                                               & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                        | ((0x800U 
                                                                            & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                               | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 0xbU)) 
                                                                                << 0xbU) 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                           | ((0x400U 
                                                                               & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                                | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 0xaU)) 
                                                                                << 0xaU) 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                              | ((0x200U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                                | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 9U)) 
                                                                                << 9U) 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((0x100U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                                | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 8U)) 
                                                                                << 8U) 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((0x80U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                                | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 7U)) 
                                                                                << 7U) 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((0x40U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                                | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 6U)) 
                                                                                << 6U) 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((0x20U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                                | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 5U)) 
                                                                                << 5U) 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((0x10U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                                | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 4U)) 
                                                                                << 4U) 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((8U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                                | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 3U)) 
                                                                                << 3U) 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((4U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
                                                                                | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 2U)) 
                                                                                << 2U) 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((2U 
                                                                                & ((0xfffffffeU 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1) 
                                                                                | (((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
                                                                                >> 1U)) 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2) 
                                                                                << 1U))) 
                                                                                | (1U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1))))))))))))))))))))))))))))))));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
        = __Vtemp_1;
}

VL_INLINE_OPT void Vjedro_1_addi_tb___024root___act_sequent__TOP__1(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___act_sequent__TOP__1\n"); );
    // Init
    IData/*31:0*/ __Vtemp_1;
    // Body
    __Vtemp_1 = ((0x40000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                 | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                       << 1U)))) | 
                 ((0x20000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                  | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                        << 1U)))) | 
                  ((0x10000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                   | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                      & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                         << 1U)))) 
                   | ((0x8000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                     | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                        & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                           << 1U)))) 
                      | ((0x4000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                        | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                           & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                              << 1U)))) 
                         | ((0x2000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                           | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                              & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                 << 1U)))) 
                            | ((0x1000000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                              | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                    << 1U)))) 
                               | ((0x800000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                      << 1U)))) 
                                  | ((0x400000U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                   | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                      & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                         << 1U)))) 
                                     | ((0x200000U 
                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                            | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                               & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                  << 1U)))) 
                                        | ((0x100000U 
                                            & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                               | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                     << 1U)))) 
                                           | ((0x80000U 
                                               & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                  | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                        << 1U)))) 
                                              | ((0x40000U 
                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                     | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                        & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                           << 1U)))) 
                                                 | ((0x20000U 
                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                        | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                           & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                              << 1U)))) 
                                                    | ((0x10000U 
                                                        & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                           | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                              & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                 << 1U)))) 
                                                       | ((0x8000U 
                                                           & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                              | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                    << 1U)))) 
                                                          | ((0x4000U 
                                                              & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                 | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                       << 1U)))) 
                                                             | ((0x2000U 
                                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                    | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                          << 1U)))) 
                                                                | ((0x1000U 
                                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                       | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                          & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                             << 1U)))) 
                                                                   | ((0x800U 
                                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                          | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                      | ((0x400U 
                                                                          & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                             | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                         | ((0x200U 
                                                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                            | ((0x100U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                               | ((0x80U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((0x40U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((0x20U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((0x10U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((8U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((4U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | ((2U 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
                                                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                                                                << 1U)))) 
                                                                                | (1U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1)))))))))))))))))))))))))))))));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
        = __Vtemp_1;
}

void Vjedro_1_addi_tb___024root___nba_sequent__TOP__0(Vjedro_1_addi_tb___024root* vlSelf);

void Vjedro_1_addi_tb___024root___eval_nba(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___eval_nba\n"); );
    // Body
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vjedro_1_addi_tb___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((6ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vjedro_1_addi_tb___024root___act_sequent__TOP__1(vlSelf);
    }
    if ((5ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vjedro_1_addi_tb___024root___act_sequent__TOP__0(vlSelf);
    }
}

extern const VlUnpacked<CData/*5:0*/, 8192> Vjedro_1_addi_tb__ConstPool__TABLE_h6d1ecb11_0;

VL_INLINE_OPT void Vjedro_1_addi_tb___024root___nba_sequent__TOP__0(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___nba_sequent__TOP__0\n"); );
    // Init
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__ifu_decoder_instr_valid;
    jedro_1_addi_tb__DOT__dut__DOT__ifu_decoder_instr_valid = 0;
    IData/*31:0*/ jedro_1_addi_tb__DOT__dut__DOT__rf_alu_data_b;
    jedro_1_addi_tb__DOT__dut__DOT__rf_alu_data_b = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT____Vcellinp__ifu_inst__jmp_instr_i;
    jedro_1_addi_tb__DOT__dut__DOT____Vcellinp__ifu_inst__jmp_instr_i = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall;
    jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT____VdfgRegularize_h53ae3cf6_0_1;
    jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT____VdfgRegularize_h53ae3cf6_0_1 = 0;
    IData/*31:0*/ jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__I_imm_sign_extended_w;
    jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__I_imm_sign_extended_w = 0;
    IData/*31:0*/ jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__B_imm_sign_extended_w;
    jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__B_imm_sign_extended_w = 0;
    CData/*3:0*/ jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_he214ed84__0;
    jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_he214ed84__0 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_h4e4ccb19__0;
    jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_h4e4ccb19__0 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_hc40b6459__0;
    jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_hc40b6459__0 = 0;
    IData/*31:0*/ jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod;
    jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod = 0;
    IData/*31:0*/ jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mux;
    jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mux = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_illegal_instr_exc;
    jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_illegal_instr_exc = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_write;
    jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_write = 0;
    IData/*31:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__FA_1b_0____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__FA_1b_0____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__1__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__1__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__2__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__2__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__3__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__3__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__4__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__4__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__5__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__5__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__6__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__6__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__7__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__7__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__8__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__8__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__9__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__9__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__10__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__10__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__11__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__11__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__12__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__12__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__13__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__13__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__14__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__14__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__15__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__15__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__16__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__16__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__17__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__17__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__18__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__18__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__19__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__19__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__20__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__20__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__21__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__21__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__22__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__22__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__23__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__23__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__24__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__24__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__25__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__25__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__26__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__26__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__27__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__27__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__28__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__28__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__29__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__29__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__30__KET____DOT__FA_1b____pinNumber5;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__30__KET____DOT__FA_1b____pinNumber5 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__FA_1b_0__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__FA_1b_0__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__1__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__1__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__2__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__2__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__3__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__3__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__4__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__4__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__5__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__5__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__6__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__6__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__7__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__7__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__8__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__8__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__9__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__9__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__10__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__10__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__11__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__11__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__12__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__12__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__13__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__13__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__14__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__14__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__15__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__15__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__16__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__16__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__17__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__17__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__18__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__18__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__19__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__19__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__20__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__20__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__21__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__21__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__22__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__22__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__23__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__23__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__24__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__24__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__25__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__25__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__26__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__26__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__27__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__27__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__28__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__28__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__29__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__29__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__30__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__30__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__31__KET____DOT__FA_1b__DOT__sum;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__31__KET____DOT__FA_1b__DOT__sum = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_0____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_0____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_1____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_1____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_0____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_0____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_1____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_1____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_2____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_2____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_3____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_3____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_0____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_0____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_1____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_1____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_2____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_2____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_3____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_3____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_4____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_4____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_5____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_5____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_6____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_6____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_7____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_7____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_30____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_30____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_31____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_31____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_28____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_28____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_29____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_29____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_30____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_30____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_31____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_31____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_24____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_24____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_25____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_25____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_26____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_26____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_27____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_27____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_28____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_28____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_29____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_29____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_30____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_30____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_31____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_31____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_16____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_16____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_17____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_17____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_18____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_18____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_19____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_19____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_20____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_20____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_21____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_21____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_22____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_22____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_23____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_23____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_24____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_24____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_25____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_25____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_26____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_26____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_27____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_27____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_28____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_28____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_29____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_29____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_30____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_30____pinNumber4 = 0;
    CData/*0:0*/ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_31____pinNumber4;
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_31____pinNumber4 = 0;
    CData/*7:0*/ jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_byte;
    jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_byte = 0;
    SData/*15:0*/ jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_hword;
    jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_hword = 0;
    SData/*12:0*/ __Vtableidx1;
    __Vtableidx1 = 0;
    CData/*7:0*/ __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0;
    __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0 = 0;
    SData/*11:0*/ __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0;
    __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0 = 0;
    CData/*7:0*/ __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1;
    __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1 = 0;
    SData/*11:0*/ __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1;
    __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1 = 0;
    CData/*7:0*/ __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2;
    __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2 = 0;
    SData/*11:0*/ __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2;
    __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2 = 0;
    CData/*7:0*/ __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3;
    __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3 = 0;
    SData/*11:0*/ __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3;
    __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3 = 0;
    IData/*31:0*/ __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0 = 0;
    IData/*31:0*/ __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1 = 0;
    IData/*31:0*/ __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2 = 0;
    CData/*2:0*/ __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r = 0;
    CData/*0:0*/ __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r = 0;
    IData/*31:0*/ __VdlyVal__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0;
    __VdlyVal__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0 = 0;
    CData/*4:0*/ __VdlyDim0__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0;
    __VdlyDim0__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0 = 0;
    CData/*0:0*/ __Vdly__jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load_hold;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load_hold = 0;
    CData/*0:0*/ __Vdly__jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold = 0;
    CData/*0:0*/ __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0;
    __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0 = 0;
    CData/*0:0*/ __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1;
    __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1 = 0;
    CData/*0:0*/ __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2;
    __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2 = 0;
    CData/*0:0*/ __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3;
    __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3 = 0;
    CData/*0:0*/ __VdlySet__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0;
    __VdlySet__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0 = 0;
    CData/*0:0*/ __VdlySet__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v1;
    __VdlySet__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v1 = 0;
    // Body
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load_hold 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load_hold;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0;
    __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0 = 0U;
    __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1 = 0U;
    __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2 = 0U;
    __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3 = 0U;
    __VdlySet__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0 = 0U;
    __VdlySet__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v1 = 0U;
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load_hold 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl_valid)
                ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load)
                : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load_hold)));
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (1U & ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl_valid)
                      ? ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl) 
                         >> 3U) : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold))));
    __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_pulse) 
               | ((1U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__next)) 
                  & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r))));
    if ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__we))) {
        __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0 
            = (0xffU & vlSelf->jedro_1_addi_tb__DOT__wdata);
        __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0 
            = (0xfffU & (vlSelf->jedro_1_addi_tb__DOT__addr 
                         >> 2U));
        __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0 = 1U;
    }
    if ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__we))) {
        __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1 
            = (0xffU & (vlSelf->jedro_1_addi_tb__DOT__wdata 
                        >> 8U));
        __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1 
            = (0xfffU & (vlSelf->jedro_1_addi_tb__DOT__addr 
                         >> 2U));
        __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1 = 1U;
    }
    if ((4U & (IData)(vlSelf->jedro_1_addi_tb__DOT__we))) {
        __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2 
            = (0xffU & (vlSelf->jedro_1_addi_tb__DOT__wdata 
                        >> 0x10U));
        __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2 
            = (0xfffU & (vlSelf->jedro_1_addi_tb__DOT__addr 
                         >> 2U));
        __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2 = 1U;
    }
    if ((8U & (IData)(vlSelf->jedro_1_addi_tb__DOT__we))) {
        __VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3 
            = (vlSelf->jedro_1_addi_tb__DOT__wdata 
               >> 0x18U);
        __VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3 
            = (0xfffU & (vlSelf->jedro_1_addi_tb__DOT__addr 
                         >> 2U));
        __VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3 = 1U;
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_decoder_ops_eq 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (1U & (~ (IData)((0U != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res)))));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mip_meip_r 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__ext_irq_i));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mip_mtip_r 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__timer_irq_i));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mip_msip_r 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__sw_irq_i));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_mtie_r 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_mtie_n));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_msie_r 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_msie_n));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_meie_r 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_meie_n));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_bus_error = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_1_mux4_is_alu_write 
        = ((1U & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__rstn))) 
           || (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux4_is_alu_write));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_illegal_instr 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_ecall 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__ecall_w));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_ebreak 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__ebreak_w));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_store 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_store));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_load 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_csr_exception 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__is_exception));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_r 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_exception) 
                | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_mret))
                ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_exc)
                : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_n)));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_r 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_exception) 
                | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_mret))
                ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_exc)
                : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_n)));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_jmp_instr 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_we 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_we_w));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm_we 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_uimm_we_w));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_mux4_wb 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           & (((IData)(vlSelf->jedro_1_addi_tb__DOT__ack) 
               & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold))) 
              & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load_hold))));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux3_use_alu_jmp_addr 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_wb 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && ((~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_ifu_trap)) 
               & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_wb)));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__prev_ready 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_use_pc 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux_is_imm 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (1U & (~ ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w) 
                        & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w)))));
    if (vlSelf->jedro_1_addi_tb__DOT__rstn) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_temp_r 
            = (((0x800000ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next) 
                | (0x10000000ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next))
                ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_decoder_data
                : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_temp_r);
        if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl_valid) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res;
        } else {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_addr;
        }
        if (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_begin_pulse) 
             & (2U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state)))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_instr;
        } else {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_instr;
        }
        if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_instr;
        } else {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_instr;
        }
        if (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_begin_pulse_r) 
             & (4U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state)))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_instr;
        } else {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_instr;
        }
        if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__jmp_instr) {
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r = 1U;
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux3_ifu_jmp_addr;
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux3_ifu_jmp_addr;
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux3_ifu_jmp_addr;
        } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_pulse) {
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r = 1U;
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_addr;
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_addr;
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_addr;
        } else if ((1U & ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r) 
                          | (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready))))) {
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r;
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0;
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1;
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2;
        } else {
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r 
                = (7U & VL_SHIFTL_III(3,3,32, (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r), 1U));
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r 
                = (1U | (IData)(__Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r));
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0 
                = ((IData)(4U) + vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0);
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1;
            __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0;
        }
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r 
            = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2 
            = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r 
            = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_addr 
            = (((2U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state)) 
                & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready)))
                ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0
                : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_addr);
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0 
            = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__byte_addr_r 
            = (3U & (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl_valid) 
                      & (~ ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl) 
                            >> 3U))) ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res
                      : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__byte_addr_r)));
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_save_r 
            = ((0x80ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                ? (0xfffffffeU & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res)
                : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_save_r);
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__data_r 
            = (((IData)(vlSelf->jedro_1_addi_tb__DOT__ack) 
                & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold)))
                ? vlSelf->jedro_1_addi_tb__DOT__rdata
                : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__data_r);
        if (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux4_rf_wb) 
             & (0U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux4_rf_dest_addr)))) {
            __VdlyVal__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux4_rf_data;
            __VdlyDim0__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux4_rf_dest_addr;
            __VdlySet__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0 = 1U;
        }
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_temp_r = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_addr = 0U;
        __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r = 1U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r 
            = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_instr = 0U;
        __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0 = 0x80000000U;
        __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1 = 0x80000000U;
        __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2 = 0x80000000U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2 
            = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r2;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r 
            = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_instr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_instr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0 
            = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r0;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__byte_addr_r = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_save_r = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__data_r = 0U;
        __VdlySet__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v1 = 1U;
    }
    if (__VdlySet__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[__VdlyDim0__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0] 
            = __VdlyVal__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v0;
    }
    if (__VdlySet__jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile__v1) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[1U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[2U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[3U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[4U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[5U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[6U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[7U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[8U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[9U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0xaU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0xbU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0xcU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0xdU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0xeU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0xfU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x10U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x11U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x12U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x13U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x14U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x15U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x16U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x17U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x18U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x19U] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x1aU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x1bU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x1cU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x1dU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x1eU] = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile[0x1fU] = 0U;
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load_hold 
        = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load_hold;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold 
        = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__is_write_hold;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_begin_pulse_r 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_begin_pulse));
    jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_byte = 0U;
    if (((0U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r)) 
         | (4U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r)))) {
        jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_byte 
            = (0xffU & ((0U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__byte_addr_r))
                         ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__data_r
                         : ((1U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__byte_addr_r))
                             ? (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__data_r 
                                >> 8U) : ((2U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__byte_addr_r))
                                           ? (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__data_r 
                                              >> 0x10U)
                                           : (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__data_r 
                                              >> 0x18U)))));
    }
    jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_hword = 0U;
    if ((1U & (~ ((0U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r)) 
                  | (4U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r)))))) {
        if (((1U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r)) 
             | (5U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r)))) {
            jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_hword 
                = (0xffffU & ((0U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__byte_addr_r))
                               ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__data_r
                               : (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__data_r 
                                  >> 0x10U)));
        }
    }
    vlSelf->jedro_1_addi_tb__DOT__rdata = vlSelf->jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM
        [(0xfffU & (vlSelf->jedro_1_addi_tb__DOT__addr 
                    >> 2U))];
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux4_is_alu_write 
        = ((1U & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__rstn))) 
           || (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w));
    jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_illegal_instr_exc = 0U;
    if (vlSelf->jedro_1_addi_tb__DOT__rstn) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mscratch_r 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mscratch_n;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_wmode 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_wmode_w;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_uimm_data_w;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_mux4_regdest 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_regdest;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_dest_addr 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_dest_addr;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_csr_fault_addr 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux3_ifu_jmp_addr;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_jmp_addr 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_addr_w;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr 
            = ((0x63U == (0x7fU & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))
                ? 0U : (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                 >> 7U)));
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_ifu_mtvec 
            = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_exception)
                ? (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtvec_base_r 
                   << 2U) : ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_mret)
                              ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_r
                              : 0U));
        if (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_exception) 
             | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_mret))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_r 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_r 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_r 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc;
        } else {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_r 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_n;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_r 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_n;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_r 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_n;
        }
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_rf_addr_a 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux_imm_ex 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_rf_addr_b 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_1_mux2_instr_addr 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_decoder_data 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_n;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_addr 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_instr 
            = vlSelf->jedro_1_addi_tb__DOT__iram_rdata;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__next;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next;
        vlSelf->jedro_1_addi_tb__DOT__wdata = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_write_word;
        vlSelf->jedro_1_addi_tb__DOT__we = (((8U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))
                                              ? ((8U 
                                                  == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))
                                                  ? 
                                                 ((0U 
                                                   == 
                                                   (3U 
                                                    & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res))
                                                   ? 1U
                                                   : 
                                                  ((1U 
                                                    == 
                                                    (3U 
                                                     & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res))
                                                    ? 2U
                                                    : 
                                                   ((2U 
                                                     == 
                                                     (3U 
                                                      & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res))
                                                     ? 4U
                                                     : 8U)))
                                                  : 
                                                 ((9U 
                                                   == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))
                                                   ? 
                                                  ((0U 
                                                    == 
                                                    (3U 
                                                     & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res))
                                                    ? 3U
                                                    : 0xcU)
                                                   : 0xfU))
                                              : 0U) 
                                            & (- (IData)(
                                                         ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl_valid) 
                                                          & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_store))))));
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_regdest 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_dest_addr 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtvec_base_r 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtvec_base_n;
        vlSelf->jedro_1_addi_tb__DOT__ack = vlSelf->jedro_1_addi_tb__DOT__stb;
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mscratch_r = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_wmode = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_mux4_regdest = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_dest_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_csr_fault_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_r = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_r = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_jmp_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_ifu_mtvec = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_rf_addr_a = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux_imm_ex = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_rf_addr_b = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_1_mux2_instr_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_decoder_data = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_instr = 0x13U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state = 1U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state = 1ULL;
        vlSelf->jedro_1_addi_tb__DOT__wdata = 0U;
        vlSelf->jedro_1_addi_tb__DOT__we = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_regdest = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_dest_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtvec_base_r = 0x100000U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_r = 0U;
        vlSelf->jedro_1_addi_tb__DOT__ack = 0U;
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_wb 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_ifu_trap 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_exception) 
               | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_mret)));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready 
        = ((1U & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__rstn))) 
           || (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__ready_w));
    jedro_1_addi_tb__DOT__dut__DOT__rf_alu_data_b = 
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile
        [vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_rf_addr_b];
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1 
        = __Vdly__jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__pc_shift_r1;
    if (__VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0) {
        vlSelf->jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM[__VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0] 
            = ((0xffffff00U & vlSelf->jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM
                [__VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0]) 
               | (IData)(__VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v0));
    }
    if (__VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1) {
        vlSelf->jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM[__VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1] 
            = ((0xffff00ffU & vlSelf->jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM
                [__VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1]) 
               | ((IData)(__VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v1) 
                  << 8U));
    }
    if (__VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2) {
        vlSelf->jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM[__VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2] 
            = ((0xff00ffffU & vlSelf->jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM
                [__VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2]) 
               | ((IData)(__VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v2) 
                  << 0x10U));
    }
    if (__VdlySet__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3) {
        vlSelf->jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM[__VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3] 
            = ((0xffffffU & vlSelf->jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM
                [__VdlyDim0__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3]) 
               | ((IData)(__VdlyVal__jedro_1_addi_tb__DOT__data_mem__DOT__data_ram__DOT__RAM__v3) 
                  << 0x18U));
    }
    if (((((((((0xf11U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr)) 
               | (0xf12U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
              | (0xf13U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
             | (0xf14U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
            | (0x300U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
           | (0x301U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
          | (0x305U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
         | (0x344U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr)))) {
        if ((0xf11U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
            jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_illegal_instr_exc 
                = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_we) 
                   | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm_we));
        } else if ((0xf12U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
            jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_illegal_instr_exc 
                = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_we) 
                   | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm_we));
        } else if ((0xf13U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
            jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_illegal_instr_exc 
                = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_we) 
                   | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm_we));
        } else if ((0xf14U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
            jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_illegal_instr_exc 
                = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_we) 
                   | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm_we));
        }
    } else if ((0x304U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
        if ((0x340U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
            if ((0x341U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                if ((0x342U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                    if ((0x343U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                        jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_illegal_instr_exc 
                            = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_we) 
                               | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm_we));
                    }
                }
            }
        }
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_exception 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_csr_exception) 
           | ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_load) 
              | ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_bus_error) 
                 | ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_store) 
                    | ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_ecall) 
                       | ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_illegal_instr) 
                          | ((IData)(jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_illegal_instr_exc) 
                             | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_ebreak))))))));
    vlSelf->jedro_1_addi_tb__DOT__stb = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
                                         && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl_valid));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_exc = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc = 0U;
    jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_write 
        = ((~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_exception)) 
           & ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm_we) 
              | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_we)));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_mret 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w));
    jedro_1_addi_tb__DOT__dut__DOT____Vcellinp__ifu_inst__jmp_instr_i 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_jmp_instr) 
           | ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_ifu_trap) 
              | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux3_use_alu_jmp_addr)));
    jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT____VdfgRegularize_h53ae3cf6_0_1 
        = ((~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready)) 
           & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__prev_ready));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_pulse 
        = ((IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT____VdfgRegularize_h53ae3cf6_0_1) 
           & ((~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r)) 
              & ((8U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state)) 
                 | (0x10U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state)))));
    if (vlSelf->jedro_1_addi_tb__DOT__rstn) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr;
        vlSelf->jedro_1_addi_tb__DOT__addr = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res;
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__addr = 0U;
    }
    if ((1U & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__rstn)))) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res = 0U;
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn)
            ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w)
            : 0U);
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res 
        = ((8U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
            ? ((4U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                ? ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                    ? 0U : ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                             ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_res
                             : 0U)) : ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                                        ? 0U : ((1U 
                                                 & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                                                 ? 0U
                                                 : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__adder_res)))
            : ((4U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                ? ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                    ? ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                        ? (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                           & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                        : (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                           | vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b))
                    : ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                        ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_res
                        : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res))
                : ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                    ? ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                        ? VL_SHIFTR_III(32,32,32, vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2, 0x1fU)
                        : ((0U == ((2U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                                          >> 0x1eU)) 
                                   | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                      >> 0x1fU))) ? 
                           (0x7fffffffU & VL_SHIFTR_III(31,31,32, vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2, 0x1eU))
                            : ((2U == ((2U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                                              >> 0x1eU)) 
                                       | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                          >> 0x1fU)))
                                ? 1U : ((1U == ((2U 
                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                                                    >> 0x1eU)) 
                                                | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                   >> 0x1fU)))
                                         ? 0U : (0x7fffffffU 
                                                 & VL_SHIFTR_III(31,31,32, vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2, 0x1eU))))))
                    : ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
                        ? ((((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                              ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_15____pinNumber4)
                              : ((8U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                  ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4)
                                  : ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                      ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4)
                                      : ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                          ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4)
                                          : ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                              ? (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                                                 >> 0x1eU)
                                              : (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                                                 >> 0x1fU)))))) 
                            << 0x1fU) | ((0x40000000U 
                                          & (((0x10U 
                                               & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                               ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_14____pinNumber4)
                                               : ((8U 
                                                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                   ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4)
                                                   : 
                                                  ((4U 
                                                    & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                    ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4)
                                                    : 
                                                   ((2U 
                                                     & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                     ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4)
                                                     : 
                                                    ((1U 
                                                      & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                      ? 
                                                     (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                                                      >> 0x1dU)
                                                      : 
                                                     (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                                                      >> 0x1eU)))))) 
                                             << 0x1eU)) 
                                         | ((((0x10U 
                                               & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                               ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_13____pinNumber4)
                                               : ((8U 
                                                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                   ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4)
                                                   : 
                                                  ((4U 
                                                    & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                    ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4)
                                                    : 
                                                   ((2U 
                                                     & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                     ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4)
                                                     : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4))))) 
                                             << 0x1dU) 
                                            | ((((0x10U 
                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                  ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_12____pinNumber4)
                                                  : 
                                                 ((8U 
                                                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                   ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4)
                                                   : 
                                                  ((4U 
                                                    & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                    ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4)
                                                    : 
                                                   ((2U 
                                                     & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                     ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4)
                                                     : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4))))) 
                                                << 0x1cU) 
                                               | ((((0x10U 
                                                     & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                     ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_11____pinNumber4)
                                                     : 
                                                    ((8U 
                                                      & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                      ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4)
                                                      : 
                                                     ((4U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                       ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4)
                                                       : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4)))) 
                                                   << 0x1bU) 
                                                  | ((((0x10U 
                                                        & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                        ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_10____pinNumber4)
                                                        : 
                                                       ((8U 
                                                         & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                         ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4)
                                                         : 
                                                        ((4U 
                                                          & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                          ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4)
                                                          : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4)))) 
                                                      << 0x1aU) 
                                                     | ((((0x10U 
                                                           & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                           ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_9____pinNumber4)
                                                           : 
                                                          ((8U 
                                                            & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                            ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4)
                                                            : 
                                                           ((4U 
                                                             & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                             ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4)
                                                             : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4)))) 
                                                         << 0x19U) 
                                                        | ((((0x10U 
                                                              & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                              ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_8____pinNumber4)
                                                              : 
                                                             ((8U 
                                                               & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                               ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4)
                                                               : 
                                                              ((4U 
                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4)
                                                                : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4)))) 
                                                            << 0x18U) 
                                                           | ((((0x10U 
                                                                 & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                 ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_7____pinNumber4)
                                                                 : 
                                                                ((8U 
                                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                  ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4)
                                                                  : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4))) 
                                                               << 0x17U) 
                                                              | ((((0x10U 
                                                                    & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                    ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_6____pinNumber4)
                                                                    : 
                                                                   ((8U 
                                                                     & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                     ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4)
                                                                     : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4))) 
                                                                  << 0x16U) 
                                                                 | ((((0x10U 
                                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                       ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_5____pinNumber4)
                                                                       : 
                                                                      ((8U 
                                                                        & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                        ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4)
                                                                        : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4))) 
                                                                     << 0x15U) 
                                                                    | ((((0x10U 
                                                                          & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                          ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_4____pinNumber4)
                                                                          : 
                                                                         ((8U 
                                                                           & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                           ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4)
                                                                           : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4))) 
                                                                        << 0x14U) 
                                                                       | ((((0x10U 
                                                                             & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                             ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_3____pinNumber4)
                                                                             : 
                                                                            ((8U 
                                                                              & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                              ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4)
                                                                              : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4))) 
                                                                           << 0x13U) 
                                                                          | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_2____pinNumber4)
                                                                                : 
                                                                               ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4)
                                                                                 : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4))) 
                                                                              << 0x12U) 
                                                                             | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_1____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4)
                                                                                 : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4))) 
                                                                                << 0x11U) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_0____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4)
                                                                                 : (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4))) 
                                                                                << 0x10U) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_15____pinNumber4)) 
                                                                                << 0xfU) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_14____pinNumber4)) 
                                                                                << 0xeU) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_13____pinNumber4)) 
                                                                                << 0xdU) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_12____pinNumber4)) 
                                                                                << 0xcU) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_11____pinNumber4)) 
                                                                                << 0xbU) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_10____pinNumber4)) 
                                                                                << 0xaU) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_9____pinNumber4)) 
                                                                                << 9U) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_8____pinNumber4)) 
                                                                                << 8U) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_7____pinNumber4)) 
                                                                                << 7U) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_6____pinNumber4)) 
                                                                                << 6U) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_5____pinNumber4)) 
                                                                                << 5U) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_4____pinNumber4)) 
                                                                                << 4U) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_3____pinNumber4)) 
                                                                                << 3U) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_2____pinNumber4)) 
                                                                                << 2U) 
                                                                                | ((((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_1____pinNumber4)) 
                                                                                << 1U) 
                                                                                | ((~ 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
                                                                                >> 4U)) 
                                                                                & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_0____pinNumber4)))))))))))))))))))))))))))))))))
                        : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__adder_res))));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn)
            ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w)
            : 0U);
    if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_1_mux4_is_alu_write) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux4_rf_dest_addr 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_dest_addr;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux4_rf_wb 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_wb;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux4_rf_data 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res;
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux4_rf_dest_addr 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_mux4_regdest;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux4_rf_wb 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_mux4_wb;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux4_rf_data 
            = ((8U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))
                ? 0U : ((8U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r))
                         ? 0U : ((4U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r))
                                  ? ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r))
                                      ? 0U : ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r))
                                               ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_hword)
                                               : (IData)(jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_byte)))
                                  : ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r))
                                      ? ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r))
                                          ? 0U : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__data_r)
                                      : ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__ctrl_save_r))
                                          ? (((- (IData)(
                                                         (1U 
                                                          & ((IData)(jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_hword) 
                                                             >> 0xfU)))) 
                                              << 0x10U) 
                                             | (IData)(jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_hword))
                                          : (((- (IData)(
                                                         (1U 
                                                          & ((IData)(jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_byte) 
                                                             >> 7U)))) 
                                              << 8U) 
                                             | (IData)(jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_byte)))))));
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl_valid 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__rstn) 
           && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_exc = 0U;
    if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_exception) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_exc 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_r;
        if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_illegal_instr) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc = 2U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr;
        } else if (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_illegal_instr_exc) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc = 2U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr;
        } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_csr_exception) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_1_mux2_instr_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_csr_fault_addr;
        } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_ecall) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc = 0xbU;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc = 0U;
        } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_ebreak) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc = 3U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr;
        } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_store) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc = 6U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_1_mux2_instr_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_addr;
        } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_load) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc = 4U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_1_mux2_instr_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_addr;
        } else {
            if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_bus_error) {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc = 5U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc 
                    = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_addr;
            } else {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_exc = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_exc = 0U;
            }
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_exc 
                = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_csr_misaligned_load)
                    ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_1_mux2_instr_addr
                    : 0U);
        }
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_exc = 0U;
    } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_mret) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_exc 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_r;
    }
    jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_r) 
           | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall_pulse));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_use_pc)
            ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux2_instr_addr
            : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile
           [vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_rf_addr_a]);
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux_is_imm)
            ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux_imm_ex
            : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__regfile_inst__DOT__regfile
           [vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_rf_addr_b]);
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod 
        = ((8U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel))
            ? (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
            : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b);
    if ((0x20U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
        if ((0x10U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if ((8U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if ((4U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_instr;
        }
    } else if ((0x10U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
        if ((8U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if ((4U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready) {
            if (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready) 
                 & (IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall))) {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0x13U;
            } else {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr 
                    = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_addr;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                    = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_instr;
            }
        } else {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_instr;
        }
    } else if ((8U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
        if ((4U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r1_instr;
        } else {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_instr;
        }
    } else if ((4U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
        if ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__after_stall_r0_instr;
        } else {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_instr;
        }
    } else if ((2U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
        if ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr = 0U;
        } else if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready) {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__dout_r_instr;
        } else {
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_addr;
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_r_instr;
        }
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_addr = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
            = ((1U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))
                ? 0x13U : 0U);
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_write_word = 0U;
    if ((8U & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__active_write_word 
            = ((8U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))
                ? ((0U == (3U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res))
                    ? (0xffU & jedro_1_addi_tb__DOT__dut__DOT__rf_alu_data_b)
                    : ((1U == (3U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res))
                        ? (0xff00U & (jedro_1_addi_tb__DOT__dut__DOT__rf_alu_data_b 
                                      << 8U)) : ((2U 
                                                  == 
                                                  (3U 
                                                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res))
                                                  ? 
                                                 (0xff0000U 
                                                  & (jedro_1_addi_tb__DOT__dut__DOT__rf_alu_data_b 
                                                     << 0x10U))
                                                  : 
                                                 (jedro_1_addi_tb__DOT__dut__DOT__rf_alu_data_b 
                                                  << 0x18U))))
                : ((9U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))
                    ? ((0U == (3U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res))
                        ? (0xffffU & jedro_1_addi_tb__DOT__dut__DOT__rf_alu_data_b)
                        : (jedro_1_addi_tb__DOT__dut__DOT__rf_alu_data_b 
                           << 0x10U)) : jedro_1_addi_tb__DOT__dut__DOT__rf_alu_data_b));
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux3_ifu_jmp_addr 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_ifu_trap)
            ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_ifu_mtvec
            : ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_mux3_use_alu_jmp_addr)
                ? (0xfffffffeU & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res)
                : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_jmp_addr));
    jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mux 
        = ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm_we)
            ? (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_uimm)
            : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a);
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__xor_res 
        = (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
           ^ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b);
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w0 
        = (0x7fffffffU & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                             ^ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w1 
        = (0x7fffffffU & ((~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a) 
                          & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w1 
        = ((~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a) 
           & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b);
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_0____pinNumber4 
        = (1U & ((~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b) 
                 & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a));
    if (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl_valid) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_store = 0U;
        if (((((((((0U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl)) 
                   | (4U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) 
                  | (1U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) 
                 | (5U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) 
                | (2U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) 
               | (8U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) 
              | (9U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) 
             | (0xaU == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl)))) {
            if ((0U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load = 0U;
            } else if ((4U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load = 0U;
            } else if ((1U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load 
                    = (1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res);
            } else if ((5U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load 
                    = (1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res);
            } else if ((2U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load 
                    = (0U != (3U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res));
            }
            if ((0U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
                if ((4U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
                    if ((1U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
                        if ((5U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
                            if ((2U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))) {
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_store 
                                    = ((8U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl)) 
                                       && (1U & ((9U 
                                                  == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_lsu_ctrl))
                                                  ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res
                                                  : 
                                                 (0U 
                                                  != 
                                                  (3U 
                                                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res)))));
                            }
                        }
                    }
                }
            }
        }
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_load = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_inst__DOT__misaligned_store = 0U;
    }
    jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_he214ed84__0 
        = ((8U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                  >> 2U)) | (7U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                   >> 0xcU)));
    jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__I_imm_sign_extended_w 
        = (((- (IData)((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                        >> 0x1fU))) << 0xcU) | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 0x14U));
    jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__B_imm_sign_extended_w 
        = (((- (IData)((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                        >> 0x1fU))) << 0xdU) | ((0x1000U 
                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                    >> 0x13U)) 
                                                | ((0x800U 
                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                       << 4U)) 
                                                   | ((0x7e0U 
                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                          >> 0x14U)) 
                                                      | (0x1eU 
                                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                            >> 7U))))));
    jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_h4e4ccb19__0 
        = (IData)(((0x5000U == (0x7000U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) 
                   & ((0U == (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                              >> 0x19U)) | (0x20U == 
                                            (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                             >> 0x19U)))));
    jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_hc40b6459__0 
        = ((1U == (7U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                         >> 0xcU))) | (5U == (7U & 
                                              (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                               >> 0xcU))));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__is_exception 
        = ((IData)(jedro_1_addi_tb__DOT__dut__DOT____Vcellinp__ifu_inst__jmp_instr_i) 
           && (0U != (3U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux3_ifu_jmp_addr)));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__jmp_instr 
        = ((IData)(jedro_1_addi_tb__DOT__dut__DOT____Vcellinp__ifu_inst__jmp_instr_i) 
           && (0U == (3U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux3_ifu_jmp_addr)));
    jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod 
        = ((0U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_wmode))
            ? jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mux
            : ((1U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_wmode))
                ? (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_decoder_data 
                   | jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mux)
                : ((~ jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mux) 
                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_decoder_data)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_0____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 1U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_0____pinNumber4));
    if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1bU));
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1cU));
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x19U));
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1aU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x17U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x18U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x15U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x16U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x13U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x14U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x11U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x12U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xfU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x10U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xdU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xeU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xbU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xcU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 9U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xaU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 3U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 4U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 7U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 8U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 5U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 6U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 3U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 4U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 1U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 2U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_1____pinNumber4 
            = (1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a);
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1cU));
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1dU));
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1aU));
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1bU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x18U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x19U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x16U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x17U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x14U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x15U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x12U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x13U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x10U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x11U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xeU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xfU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xcU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xdU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xaU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xbU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 2U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 3U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 8U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 9U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 6U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 7U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 4U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 5U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 2U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 3U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_1____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 1U));
    }
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_1____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 1U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_1____pinNumber4));
    __Vtableidx1 = (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__instr_valid_shift_r) 
                     << 0xaU) | (((IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall) 
                                  << 9U) | (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready) 
                                             << 8U) 
                                            | (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__is_exception) 
                                                << 7U) 
                                               | (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__jmp_instr) 
                                                   << 6U) 
                                                  | (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state))))));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__next 
        = Vjedro_1_addi_tb__ConstPool__TABLE_h6d1ecb11_0
        [__Vtableidx1];
    jedro_1_addi_tb__DOT__dut__DOT__ifu_decoder_instr_valid 
        = (1U & (~ ((1U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state)) 
                    | ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__jmp_instr) 
                       | (((0x10U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state)) 
                           & ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready) 
                              & (IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_in_stall))) 
                          | (0x20U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__state)))))));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_mtie_n 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_mtie_r;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtvec_base_n 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtvec_base_r;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mscratch_n 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mscratch_r;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_msie_n 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_msie_r;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_n 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_r;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_n 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_r;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_n 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_r;
    if (((((((((0xf11U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr)) 
               | (0xf12U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
              | (0xf13U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
             | (0xf14U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
            | (0x300U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
           | (0x301U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
          | (0x305U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
         | (0x344U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr)))) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_n 
            = ((0xf11U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                ? 0U : ((0xf12U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                         ? 0U : ((0xf13U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                                  ? 0U : ((0xf14U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                                           ? 0U : (
                                                   (0x300U 
                                                    == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                                                    ? 
                                                   (VL_SHIFTL_III(32,32,32, (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_r), 3U) 
                                                    | VL_SHIFTL_III(32,32,32, (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_r), 7U))
                                                    : 
                                                   ((0x301U 
                                                     == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                                                     ? 0x40000100U
                                                     : 
                                                    ((0x305U 
                                                      == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                                                      ? 
                                                     (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtvec_base_r 
                                                      << 2U)
                                                      : 
                                                     (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mip_meip_r) 
                                                       << 0xbU) 
                                                      | (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mip_mtip_r) 
                                                          << 7U) 
                                                         | ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mip_msip_r) 
                                                            << 3U))))))))));
        if ((0xf11U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
            if ((0xf12U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                if ((0xf13U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                    if ((0xf14U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                        if ((0x300U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                            if ((0x301U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                                if ((0x305U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                                    if (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_write) {
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtvec_base_n 
                                            = (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod 
                                               >> 2U);
                                    }
                                }
                            }
                        }
                        if ((0x300U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                            if (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_write) {
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mie_n 
                                    = (1U & (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod 
                                             >> 3U));
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mstatus_mpie_n 
                                    = (1U & (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod 
                                             >> 7U));
                            }
                        }
                    }
                }
            }
        }
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_n 
            = ((0x304U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                ? (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_meie_r) 
                    << 0xbU) | (((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_mtie_r) 
                                 << 7U) | ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_msie_r) 
                                           << 3U)))
                : ((0x340U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                    ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mscratch_r
                    : ((0x341U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                        ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_r
                        : ((0x342U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                            ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_r
                            : ((0x343U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))
                                ? vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_r
                                : 0U)))));
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_meie_n 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_meie_r;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_n 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_r;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_n 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_r;
    if ((1U & (~ ((((((((0xf11U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr)) 
                        | (0xf12U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
                       | (0xf13U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
                      | (0xf14U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
                     | (0x300U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
                    | (0x301U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
                   | (0x305U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) 
                  | (0x344U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr)))))) {
        if ((0x304U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
            if (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_write) {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_mtie_n 
                    = (1U & (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod 
                             >> 7U));
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_msie_n 
                    = (1U & (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod 
                             >> 3U));
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mie_meie_n 
                    = (1U & (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod 
                             >> 0xbU));
            }
        }
        if ((0x304U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
            if ((0x340U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                if (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_write) {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mscratch_n 
                        = jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod;
                }
            }
            if ((0x340U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                if ((0x341U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                    if ((0x342U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                        if (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_write) {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mcause_n 
                                = jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod;
                        }
                    }
                    if ((0x342U != (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                        if ((0x343U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                            if (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_write) {
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mtval_n 
                                    = jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod;
                            }
                        }
                    }
                }
                if ((0x341U == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_csr_addr))) {
                    if (jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__is_write) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__csr_mepc_n 
                            = jedro_1_addi_tb__DOT__dut__DOT__csr_inst__DOT__data_mod;
                    }
                }
            }
        }
    }
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_0____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 2U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_0____pinNumber4));
    if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_2____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_0____pinNumber4;
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_2____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4;
    }
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_2____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 2U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_2____pinNumber4));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_1____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 2U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_1____pinNumber4));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_3____pinNumber4 
        = ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
            ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_1____pinNumber4)
            : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_3____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 2U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_3____pinNumber4));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign 
        = (IData)((((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel) 
                    >> 3U) & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                              >> 0x1fU)));
    if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)) {
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 5U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 6U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 7U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 8U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 9U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xaU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xbU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xcU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xdU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xeU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xfU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x10U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x11U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x12U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x13U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x14U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x15U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x16U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x17U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x18U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x19U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1aU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1bU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1cU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1dU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1eU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_30____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1fU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_31____pinNumber4 
            = (1U & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign));
    } else {
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 4U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 5U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 6U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 7U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 8U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 9U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xaU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xbU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xcU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xdU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xeU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0xfU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x10U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x11U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x12U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x13U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x14U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x15U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x16U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x17U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x18U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x19U));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1aU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1bU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1cU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1dU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_30____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1eU));
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_31____pinNumber4 
            = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     >> 0x1fU));
    }
    if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)) {
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_28____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_30____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_30____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_29____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_31____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_31____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
    } else {
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_6____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_7____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_8____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_9____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_10____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_11____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_12____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_13____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_14____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_15____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_16____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_17____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_18____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_19____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_20____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_21____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_22____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_23____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_24____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_25____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_26____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_27____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_28____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_28____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_30____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_30____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_29____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_29____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_31____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_31____pinNumber4;
    }
    if ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_4____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_0____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_6____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_2____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_5____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_1____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_7____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_3____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_24____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_28____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_28____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_26____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_30____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_30____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_25____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_29____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_29____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_27____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_31____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_31____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_4____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_6____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_5____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_7____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_12____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_13____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_14____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_15____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_16____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_17____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_18____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_19____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_20____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_21____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_22____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_23____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_24____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_24____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_28____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_28____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_26____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_26____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_30____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_30____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_25____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_25____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_29____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_29____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_27____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_27____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_31____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_31____pinNumber4;
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__stall_begin_pulse 
        = ((IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_decoder_instr_valid) 
           & (IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT____VdfgRegularize_h53ae3cf6_0_1));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__ebreak_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__ecall_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_addr_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_wmode_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_we_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_uimm_data_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_uimm_we_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__ready_w 
        = ((1U & (~ (IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_decoder_instr_valid))) 
           || ((0x40U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                ? ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                          >> 5U)) && ((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                       ? ((1U & (~ 
                                                 (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                  >> 3U))) 
                                          && ((1U & 
                                               (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 2U))) 
                                              && ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                      && (1U 
                                                          & ((0U 
                                                              != 
                                                              (7U 
                                                               & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                  >> 0xcU)))
                                                              ? 
                                                             ((IData)(jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_hc40b6459__0)
                                                               ? 
                                                              ((1U 
                                                                & (~ 
                                                                   (((((0x200000ULL 
                                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                       & (0x400000ULL 
                                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                      & (0x800000ULL 
                                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                     & (0x1000000ULL 
                                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                    & (0U 
                                                                       != 
                                                                       (0x1fU 
                                                                        & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                           >> 7U)))))) 
                                                               && ((0x200000ULL 
                                                                    != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                   && ((0x400000ULL 
                                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                       && ((1U 
                                                                            & (~ (IData)(
                                                                                ((0U 
                                                                                == 
                                                                                (0xf80U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) 
                                                                                & ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr) 
                                                                                == 
                                                                                (0x1fU 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                                >> 0xfU))))))) 
                                                                           && ((1U 
                                                                                & (~ 
                                                                                ((0x800000ULL 
                                                                                == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                                | (0U 
                                                                                == 
                                                                                (0x1fU 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                                >> 7U)))))) 
                                                                               || (0U 
                                                                                == 
                                                                                (0x1fU 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                                >> 7U))))))))
                                                               : 
                                                              ((1U 
                                                                & (~ 
                                                                   ((((0x4000000ULL 
                                                                       != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                      & (0x8000000ULL 
                                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                     & (0x10000000ULL 
                                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                    & (0x20000000ULL 
                                                                       != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                               && ((0x4000000ULL 
                                                                    != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                   && ((0x8000000ULL 
                                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                       && (1U 
                                                                           & (~ 
                                                                              ((0x10000000ULL 
                                                                                == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                               & (0U 
                                                                                != 
                                                                                (0x1fU 
                                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                                >> 0xfU))))))))))
                                                              : 
                                                             ((0x30200073U 
                                                               == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                                               ? 
                                                              (~ 
                                                               ((0x80000000ULL 
                                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                & (0x100000000ULL 
                                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))
                                                               : 
                                                              ((0x73U 
                                                                != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                               && ((0x100073U 
                                                                    != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                                   && (0x10500073U 
                                                                       == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))))))))))
                                       : ((8U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                           ? ((1U & 
                                               (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 2U)) 
                                              && ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                      && ((1U 
                                                           & (~ 
                                                              ((((4ULL 
                                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                 & (8ULL 
                                                                    != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                & (0x10ULL 
                                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                               & (0x20ULL 
                                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                          && ((4ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                              && (8ULL 
                                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))))
                                           : ((1U & 
                                               (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 2U))) 
                                              && ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                      && ((1U 
                                                           & (~ 
                                                              ((((((((((0x1fU 
                                                                        & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                           >> 0xfU)) 
                                                                       == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                      & (0U 
                                                                         != 
                                                                         (0x1fU 
                                                                          & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                             >> 0xfU)))) 
                                                                     | (((0x1fU 
                                                                          & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                             >> 0x14U)) 
                                                                         == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                        & (0U 
                                                                           != 
                                                                           (0x1fU 
                                                                            & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                               >> 0x14U))))) 
                                                                    & (0x800ULL 
                                                                       != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                   & (0x1000ULL 
                                                                      != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                  & (0x2000ULL 
                                                                     != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                 & (0x4000ULL 
                                                                    != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                & (0x8000ULL 
                                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                               & (2ULL 
                                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                          && ((1U 
                                                               & (~ 
                                                                  (((((0x800ULL 
                                                                       != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                      & (0x1000ULL 
                                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                     & (0x2000ULL 
                                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                    & (0x4000ULL 
                                                                       != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                   & (0x8000ULL 
                                                                      != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                              && ((0x800ULL 
                                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                  && ((0x1000ULL 
                                                                       != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                      && (0x2000ULL 
                                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))))))))))
                : ((0x20U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                    ? ((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                        ? ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                     >> 3U))) && ((4U 
                                                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                                   ? 
                                                  ((1U 
                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                       >> 1U)) 
                                                   && (1U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))
                                                   : 
                                                  ((1U 
                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                       >> 1U)) 
                                                   && ((1U 
                                                        & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                       && (1U 
                                                           & (~ 
                                                              (((((0x1fU 
                                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                      >> 0xfU)) 
                                                                  == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                 & (0U 
                                                                    != 
                                                                    (0x1fU 
                                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                        >> 0xfU)))) 
                                                                | (((0x1fU 
                                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                        >> 0x14U)) 
                                                                    == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                   & (0U 
                                                                      != 
                                                                      (0x1fU 
                                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                          >> 0x14U))))) 
                                                               & (2ULL 
                                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))))))
                        : ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                     >> 3U))) && ((1U 
                                                   & (~ 
                                                      (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                       >> 2U))) 
                                                  && ((1U 
                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                          >> 1U)) 
                                                      && ((1U 
                                                           & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                          && ((1U 
                                                               & (~ 
                                                                  (((((0x1fU 
                                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                          >> 0xfU)) 
                                                                      == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                     & (0U 
                                                                        != 
                                                                        (0x1fU 
                                                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                            >> 0xfU)))) 
                                                                    | (((0x1fU 
                                                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                            >> 0x14U)) 
                                                                        == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                       & (0U 
                                                                          != 
                                                                          (0x1fU 
                                                                           & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                              >> 0x14U))))) 
                                                                   & ((2ULL 
                                                                       != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                      & (0x10000ULL 
                                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) 
                                                              && (0x10000ULL 
                                                                  == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))))))
                    : ((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                        ? ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                     >> 3U))) && ((4U 
                                                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                                   ? 
                                                  ((1U 
                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                       >> 1U)) 
                                                   && (1U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))
                                                   : 
                                                  ((1U 
                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                       >> 1U)) 
                                                   && ((1U 
                                                        & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                       && (1U 
                                                           & (~ 
                                                              ((((0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0xfU)) 
                                                                 == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                & (0U 
                                                                   != 
                                                                   (0x1fU 
                                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                       >> 0xfU)))) 
                                                               & (2ULL 
                                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))))))
                        : ((8U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                            ? ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                      >> 2U)) && ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)))
                            : ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                         >> 2U))) && 
                               ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                       >> 1U)) && (
                                                   (1U 
                                                    & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                   && ((1U 
                                                        & (~ 
                                                           (((((((0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0xfU)) 
                                                                 == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                & (0U 
                                                                   != 
                                                                   (0x1fU 
                                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                       >> 0xfU)))) 
                                                               & (2ULL 
                                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                              & (0x40000ULL 
                                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                             & (0x80000ULL 
                                                                != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                            & (0x100000ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                       && ((1U 
                                                            & (~ 
                                                               ((((0x40000ULL 
                                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                  & (0x80000ULL 
                                                                     != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                 & (0x100000ULL 
                                                                    != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                                | (((0x100000ULL 
                                                                     == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                    & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready)) 
                                                                   & (IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_decoder_instr_valid))))) 
                                                           && ((0x40000ULL 
                                                                != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                               && (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__lsu_mux4_wb))))))))))));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
    if (jedro_1_addi_tb__DOT__dut__DOT__ifu_decoder_instr_valid) {
        if ((0x40U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
            if ((0x20U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                if ((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    if ((8U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    } else if ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    } else if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                        if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                            if ((0U == (7U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                              >> 0xcU)))) {
                                if ((0x30200073U != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                    if ((0x73U != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                        if ((0x100073U 
                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                            if ((0x10500073U 
                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                                            }
                                        }
                                    }
                                }
                                if ((0x30200073U == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w 
                                        = ((0x80000000ULL 
                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                           & (0x100000000ULL 
                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state));
                                }
                            }
                            if ((0U != (7U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                              >> 0xcU)))) {
                                if (jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_hc40b6459__0) {
                                    if ((1U & (~ ((
                                                   (((0x200000ULL 
                                                      != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                     & (0x400000ULL 
                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                    & (0x800000ULL 
                                                       != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                   & (0x1000000ULL 
                                                      != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                  & (0U 
                                                     != 
                                                     (0x1fU 
                                                      & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                         >> 7U))))))) {
                                        if ((0x200000ULL 
                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                            if ((0x400000ULL 
                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                if (
                                                    (1U 
                                                     & (~ (IData)(
                                                                  ((0U 
                                                                    == 
                                                                    (0xf80U 
                                                                     & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) 
                                                                   & ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr) 
                                                                      == 
                                                                      (0x1fU 
                                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                          >> 0xfU)))))))) {
                                                    if (
                                                        ((0x800000ULL 
                                                          == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                         | (0U 
                                                            == 
                                                            (0x1fU 
                                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                >> 7U))))) {
                                                        if (
                                                            (1U 
                                                             == 
                                                             (7U 
                                                              & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                 >> 0xcU)))) {
                                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                                                                = 
                                                                (0x1fU 
                                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                    >> 0xfU));
                                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 1U;
                                                        }
                                                    } else {
                                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 1U;
                                                    }
                                                    if (
                                                        (1U 
                                                         & (~ 
                                                            ((0x800000ULL 
                                                              == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                             | (0U 
                                                                == 
                                                                (0x1fU 
                                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                    >> 7U))))))) {
                                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                                                            = 
                                                            (0x1fU 
                                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                >> 7U));
                                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 1U;
                                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 1U;
                                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                                                            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_temp_r;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                                        = ((((((0x200000ULL 
                                                != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                               & (0x400000ULL 
                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                              & (0x800000ULL 
                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                             & (0x1000000ULL 
                                                != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                            & (0U != 
                                               (0x1fU 
                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 7U))))
                                            ? 0x200000ULL
                                            : ((0x200000ULL 
                                                == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                                ? 0x400000ULL
                                                : (
                                                   (0x400000ULL 
                                                    == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                                    ? 0x800000ULL
                                                    : 
                                                   ((IData)(
                                                            ((0U 
                                                              == 
                                                              (0xf80U 
                                                               & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) 
                                                             & ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr) 
                                                                == 
                                                                (0x1fU 
                                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                    >> 0xfU)))))
                                                     ? 2ULL
                                                     : 
                                                    (((0x800000ULL 
                                                       == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                      | (0U 
                                                         == 
                                                         (0x1fU 
                                                          & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                             >> 7U))))
                                                      ? 0x1000000ULL
                                                      : 0x2000000ULL)))));
                                } else {
                                    if ((1U & (~ ((
                                                   ((0x4000000ULL 
                                                     != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                    & (0x8000000ULL 
                                                       != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                   & (0x10000000ULL 
                                                      != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                  & (0x20000000ULL 
                                                     != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) {
                                        if ((0x4000000ULL 
                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                            if ((0x8000000ULL 
                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                if (
                                                    ((0x10000000ULL 
                                                      == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                     & (0U 
                                                        != 
                                                        (0x1fU 
                                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                            >> 0xfU))))) {
                                                    if (
                                                        (1U 
                                                         & (~ 
                                                            (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                             >> 0xeU)))) {
                                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                                                            = 
                                                            (0x1fU 
                                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                >> 0xfU));
                                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 1U;
                                                    }
                                                } else {
                                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 1U;
                                                }
                                                if (
                                                    (1U 
                                                     & (~ 
                                                        ((0x10000000ULL 
                                                          == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                         & (0U 
                                                            != 
                                                            (0x1fU 
                                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                >> 0xfU))))))) {
                                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                                                        = 
                                                        (0x1fU 
                                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                            >> 7U));
                                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 1U;
                                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 1U;
                                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                                                        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_temp_r;
                                                }
                                            }
                                        }
                                    }
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                                        = (((((0x4000000ULL 
                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                              & (0x8000000ULL 
                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                             & (0x10000000ULL 
                                                != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                            & (0x20000000ULL 
                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))
                                            ? 0x4000000ULL
                                            : ((0x4000000ULL 
                                                == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                                ? 0x8000000ULL
                                                : (
                                                   (0x8000000ULL 
                                                    == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                                    ? 0x10000000ULL
                                                    : 
                                                   (((0x10000000ULL 
                                                      == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                     & (0U 
                                                        != 
                                                        (0x1fU 
                                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                            >> 0xfU))))
                                                     ? 0x20000000ULL
                                                     : 0x40000000ULL))));
                                }
                            } else {
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                                    = ((0x30200073U 
                                        == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                        ? (((0x80000000ULL 
                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                            & (0x100000000ULL 
                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))
                                            ? 0x80000000ULL
                                            : 0x100000000ULL)
                                        : ((0x73U == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                            ? ((((0x200000000ULL 
                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                 & (0x400000000ULL 
                                                    != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                & (0x800000000ULL 
                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))
                                                ? 0x200000000ULL
                                                : (
                                                   (0x200000000ULL 
                                                    == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                                    ? 0x400000000ULL
                                                    : 0x800000000ULL))
                                            : ((0x100073U 
                                                == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                                ? (
                                                   (((0x1000000000ULL 
                                                      != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                     & (0x2000000000ULL 
                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                    & (0x4000000000ULL 
                                                       != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))
                                                    ? 0x1000000000ULL
                                                    : 
                                                   ((0x1000000000ULL 
                                                     == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                                     ? 0x2000000000ULL
                                                     : 0x4000000000ULL))
                                                : (
                                                   (0x10500073U 
                                                    == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                                    ? 1ULL
                                                    : 0x8000000000ULL))));
                            }
                        } else {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                        }
                        if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        }
                    } else {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    }
                    if ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                  >> 3U)))) {
                        if ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                      >> 2U)))) {
                            if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                    if ((0U == (7U 
                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 0xcU)))) {
                                        if ((0x30200073U 
                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                            if ((0x73U 
                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                                if (
                                                    (0x100073U 
                                                     == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                                    if (
                                                        (1U 
                                                         & (~ 
                                                            (((0x1000000000ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                              & (0x2000000000ULL 
                                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                             & (0x4000000000ULL 
                                                                != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) {
                                                        if (
                                                            (0x1000000000ULL 
                                                             == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__ebreak_w = 1U;
                                                        }
                                                    }
                                                }
                                            }
                                            if ((0x73U 
                                                 == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                                if (
                                                    (1U 
                                                     & (~ 
                                                        (((0x200000000ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                          & (0x400000000ULL 
                                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                         & (0x800000000ULL 
                                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) {
                                                    if (
                                                        (0x200000000ULL 
                                                         == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__ecall_w = 1U;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if ((0U != (7U 
                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 0xcU)))) {
                                        if (jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_hc40b6459__0) {
                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_addr_w 
                                                = (0xfffU 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 0x14U));
                                            if ((1U 
                                                 & (~ 
                                                    (((((0x200000ULL 
                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                        & (0x400000ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                       & (0x800000ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                      & (0x1000000ULL 
                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                     & (0U 
                                                        != 
                                                        (0x1fU 
                                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                            >> 7U))))))) {
                                                if (
                                                    (0x200000ULL 
                                                     != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                    if (
                                                        (0x400000ULL 
                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                        if (
                                                            (1U 
                                                             & (~ (IData)(
                                                                          ((0U 
                                                                            == 
                                                                            (0xf80U 
                                                                             & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) 
                                                                           & ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr) 
                                                                              == 
                                                                              (0x1fU 
                                                                               & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                                >> 0xfU)))))))) {
                                                            if (
                                                                ((0x800000ULL 
                                                                  == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                 | (0U 
                                                                    == 
                                                                    (0x1fU 
                                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                        >> 7U))))) {
                                                                if (
                                                                    (1U 
                                                                     == 
                                                                     (7U 
                                                                      & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                         >> 0xcU)))) {
                                                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_we_w = 1U;
                                                                }
                                                                if (
                                                                    (1U 
                                                                     != 
                                                                     (7U 
                                                                      & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                         >> 0xcU)))) {
                                                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_uimm_data_w 
                                                                        = 
                                                                        (0x1fU 
                                                                         & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                            >> 0xfU));
                                                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_uimm_we_w = 1U;
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        } else {
                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_addr_w 
                                                = (0xfffU 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 0x14U));
                                            if ((1U 
                                                 & (~ 
                                                    ((((0x4000000ULL 
                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                       & (0x8000000ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                      & (0x10000000ULL 
                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                     & (0x20000000ULL 
                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) {
                                                if (
                                                    (0x4000000ULL 
                                                     != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                    if (
                                                        (0x8000000ULL 
                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                        if (
                                                            ((0x10000000ULL 
                                                              == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                             & (0U 
                                                                != 
                                                                (0x1fU 
                                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                    >> 0xfU))))) {
                                                            if (
                                                                (1U 
                                                                 & (~ 
                                                                    (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0xeU)))) {
                                                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_we_w = 1U;
                                                            }
                                                            if (
                                                                (0x4000U 
                                                                 & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_uimm_data_w 
                                                                    = 
                                                                    (0x1fU 
                                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                        >> 0xfU));
                                                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_uimm_we_w = 1U;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        if ((1U & (~ (IData)(jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_hc40b6459__0)))) {
                                            if ((1U 
                                                 & (~ 
                                                    ((((0x4000000ULL 
                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                       & (0x8000000ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                      & (0x10000000ULL 
                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                     & (0x20000000ULL 
                                                        != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) {
                                                if (
                                                    (0x4000000ULL 
                                                     != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                    if (
                                                        (0x8000000ULL 
                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                        if (
                                                            ((0x10000000ULL 
                                                              == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                             & (0U 
                                                                != 
                                                                (0x1fU 
                                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                    >> 0xfU))))) {
                                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_wmode_w 
                                                                = 
                                                                ((0x1000U 
                                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                                                  ? 2U
                                                                  : 1U);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else if ((8U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    if ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                        if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                            if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                            }
                            if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                if ((1U & (~ ((((4ULL 
                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                & (8ULL 
                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                               & (0x10ULL 
                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                              & (0x20ULL 
                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) {
                                    if ((4ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                        if ((8ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 1U;
                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                                                = (0x1fU 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 7U));
                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w 
                                                = (0xfffffffeU 
                                                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res);
                                        }
                                    }
                                }
                                if (((((4ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                       & (8ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                      & (0x10ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                     & (0x20ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))) {
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 1U;
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 4ULL;
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                                        = (((- (IData)(
                                                       (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                        >> 0x1fU))) 
                                            << 0x15U) 
                                           | ((0x100000U 
                                               & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                  >> 0xbU)) 
                                              | ((0xff000U 
                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                 | ((0x800U 
                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                        >> 9U)) 
                                                    | (0x7feU 
                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                          >> 0x14U))))));
                                } else {
                                    if ((4ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                        if ((8ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w 
                                                = (1U 
                                                   & (~ 
                                                      (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res 
                                                       >> 1U)));
                                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 4U;
                                        }
                                    }
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                                        = ((4ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                            ? 8ULL : 
                                           ((8ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                             ? 0x10ULL
                                             : 0x20ULL));
                                }
                            } else {
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                            }
                        } else {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                        }
                    } else {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    }
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w 
                        = ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                  >> 2U)) && ((1U & 
                                               (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)));
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w 
                        = ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                  >> 2U)) && ((1U & 
                                               (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)));
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                } else if ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                        if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        }
                        if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                            if ((((((((((0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                  >> 0xfU)) 
                                        == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                       & (0U != (0x1fU 
                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                    >> 0xfU)))) 
                                      & (0x40ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                     & (0x80ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                    & (0x100ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                   & (0x200ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                  & (0x400ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                 & (2ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))) {
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 2ULL;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                            } else if ((((((0x40ULL 
                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                           & (0x80ULL 
                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                          & (0x100ULL 
                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                         & (0x200ULL 
                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                        & (0x400ULL 
                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))) {
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                                    = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 0xfU));
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 1U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x40ULL;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                                    = jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__I_imm_sign_extended_w;
                            } else {
                                if ((0x40ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                    if ((0x80ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 1U;
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                                            = (0x1fU 
                                               & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                  >> 7U));
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w 
                                            = (1U & 
                                               (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res 
                                                   >> 1U)));
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 4U;
                                    } else if ((0x100ULL 
                                                == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                                            = jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__I_imm_sign_extended_w;
                                    }
                                }
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                                    = ((0x40ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                        ? 0x80ULL : 
                                       ((0x80ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                         ? 0x100ULL
                                         : ((0x100ULL 
                                             == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                             ? 0x200ULL
                                             : 0x400ULL)));
                            }
                            if ((1U & (~ (((((((((0x1fU 
                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                     >> 0xfU)) 
                                                 == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                & (0U 
                                                   != 
                                                   (0x1fU 
                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                       >> 0xfU)))) 
                                               & (0x40ULL 
                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                              & (0x80ULL 
                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                             & (0x100ULL 
                                                != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                            & (0x200ULL 
                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                           & (0x400ULL 
                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                          & (2ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) {
                                if ((1U & (~ (((((0x40ULL 
                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                 & (0x80ULL 
                                                    != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                & (0x100ULL 
                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                               & (0x200ULL 
                                                  != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                              & (0x400ULL 
                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) {
                                    if ((0x40ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                        if ((0x80ULL 
                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                            if ((0x100ULL 
                                                 == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 1U;
                                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w 
                                                    = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_save_r;
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                        }
                    } else {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    }
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w 
                        = ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                  >> 1U)) && (1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr));
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                } else {
                    if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                        if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        }
                        if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                            if (((((((((((0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 0xfU)) 
                                         == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                        & (0U != (0x1fU 
                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                     >> 0xfU)))) 
                                       | (((0x1fU & 
                                            (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                             >> 0x14U)) 
                                           == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                          & (0U != 
                                             (0x1fU 
                                              & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                 >> 0x14U))))) 
                                      & (0x800ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                     & (0x1000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                    & (0x2000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                   & (0x4000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                  & (0x8000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                 & (2ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))) {
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 2ULL;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                            } else if ((((((0x800ULL 
                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                           & (0x1000ULL 
                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                          & (0x2000ULL 
                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                         & (0x4000ULL 
                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                        & (0x8000ULL 
                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))) {
                                if ((0x1000U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w 
                                        = (0x1fU & 
                                           (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0xfU));
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                                        = (0x1fU & 
                                           (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0x14U));
                                } else {
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w 
                                        = (0x1fU & 
                                           (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0x14U));
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                                        = (0x1fU & 
                                           (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0xfU));
                                }
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w 
                                    = (3U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                             >> 0xdU));
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x800ULL;
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                            } else {
                                if ((0x800ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w 
                                        = (0x1fU & 
                                           (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0x14U));
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                                        = (0x1fU & 
                                           (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0xfU));
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x1000ULL;
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                                        = jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__B_imm_sign_extended_w;
                                } else if ((0x1000ULL 
                                            == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w 
                                        = (0x1fU & 
                                           (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0x14U));
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                                        = (0x1fU & 
                                           (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0xfU));
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                                        = (((((((0U 
                                                 != 
                                                 (7U 
                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                     >> 0xcU))) 
                                                & (1U 
                                                   != 
                                                   (7U 
                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                       >> 0xcU)))) 
                                               & (1U 
                                                  == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_mux4_res)) 
                                              | (((5U 
                                                   == 
                                                   (7U 
                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                       >> 0xcU))) 
                                                  | (7U 
                                                     == 
                                                     (7U 
                                                      & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                         >> 0xcU)))) 
                                                 & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_decoder_ops_eq))) 
                                             | (IData)(
                                                       ((0U 
                                                         == 
                                                         (0x7000U 
                                                          & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) 
                                                        & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_decoder_ops_eq)))) 
                                            | (IData)(
                                                      ((0x1000U 
                                                        == 
                                                        (0x7000U 
                                                         & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) 
                                                       & (~ (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_decoder_ops_eq)))))
                                            ? 0x2000ULL
                                            : 0x8000ULL);
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                                        = jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__B_imm_sign_extended_w;
                                } else {
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w 
                                        = (0x1fU & 0U);
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                                        = (0x1fU & 0U);
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                                        = ((0x2000ULL 
                                            == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                            ? 0x4000ULL
                                            : 0x8000ULL);
                                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                                }
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                            }
                        } else {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                        }
                    } else {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    }
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w 
                        = ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                  >> 1U)) && ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                              && ((1U 
                                                   & (~ 
                                                      ((((((((((0x1fU 
                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                   >> 0xfU)) 
                                                               == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                              & (0U 
                                                                 != 
                                                                 (0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0xfU)))) 
                                                             | (((0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0x14U)) 
                                                                 == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                & (0U 
                                                                   != 
                                                                   (0x1fU 
                                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                       >> 0x14U))))) 
                                                            & (0x800ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                           & (0x1000ULL 
                                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                          & (0x2000ULL 
                                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                         & (0x4000ULL 
                                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                        & (0x8000ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                       & (2ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                  && ((1U 
                                                       & (~ 
                                                          (((((0x800ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                              & (0x1000ULL 
                                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                             & (0x2000ULL 
                                                                != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                            & (0x4000ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                           & (0x8000ULL 
                                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                      && ((0x800ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                          && ((0x1000ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                              && (0x2000ULL 
                                                                  == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))))));
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w 
                        = ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                  >> 1U)) && ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                              && ((1U 
                                                   & (~ 
                                                      ((((((((((0x1fU 
                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                   >> 0xfU)) 
                                                               == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                              & (0U 
                                                                 != 
                                                                 (0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0xfU)))) 
                                                             | (((0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0x14U)) 
                                                                 == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                & (0U 
                                                                   != 
                                                                   (0x1fU 
                                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                       >> 0x14U))))) 
                                                            & (0x800ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                           & (0x1000ULL 
                                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                          & (0x2000ULL 
                                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                         & (0x4000ULL 
                                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                        & (0x8000ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                       & (2ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                  && (((((0x800ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                         & (0x1000ULL 
                                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                        & (0x2000ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                       & (0x4000ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                      & (0x8000ULL 
                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))));
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w 
                        = ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                  >> 1U)) && ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                              && ((1U 
                                                   & (~ 
                                                      ((((((((((0x1fU 
                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                   >> 0xfU)) 
                                                               == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                              & (0U 
                                                                 != 
                                                                 (0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0xfU)))) 
                                                             | (((0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0x14U)) 
                                                                 == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                & (0U 
                                                                   != 
                                                                   (0x1fU 
                                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                       >> 0x14U))))) 
                                                            & (0x800ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                           & (0x1000ULL 
                                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                          & (0x2000ULL 
                                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                         & (0x4000ULL 
                                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                        & (0x8000ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                       & (2ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                  && ((1U 
                                                       & (~ 
                                                          (((((0x800ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                              & (0x1000ULL 
                                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                             & (0x2000ULL 
                                                                != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                            & (0x4000ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                           & (0x8000ULL 
                                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                      && ((0x800ULL 
                                                           == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                          || (0x1000ULL 
                                                              == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))));
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w 
                        = ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                  >> 1U)) && ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                              && ((1U 
                                                   & (~ 
                                                      ((((((((((0x1fU 
                                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                   >> 0xfU)) 
                                                               == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                              & (0U 
                                                                 != 
                                                                 (0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0xfU)))) 
                                                             | (((0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0x14U)) 
                                                                 == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                & (0U 
                                                                   != 
                                                                   (0x1fU 
                                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                       >> 0x14U))))) 
                                                            & (0x800ULL 
                                                               != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                           & (0x1000ULL 
                                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                          & (0x2000ULL 
                                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                         & (0x4000ULL 
                                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                        & (0x8000ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                       & (2ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                  && (((((0x800ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                         & (0x1000ULL 
                                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                        & (0x2000ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                       & (0x4000ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                      & (0x8000ULL 
                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))));
                }
            } else {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
            }
        } else if ((0x20U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
            if ((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                if ((8U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                } else if ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                        if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        }
                        if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                                = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 7U));
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 1ULL;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                                = (0xfffff000U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr);
                        } else {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                                = (0x1fU & 0U);
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                        }
                    } else {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                            = (0x1fU & 0U);
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    }
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                } else {
                    if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                        if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                        }
                        if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w 
                                = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0x14U));
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                                = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0xfU));
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                                = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 7U));
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w 
                                = ((8U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                          >> 0x1bU)) 
                                   | (7U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0xcU)));
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                                = ((((((0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                 >> 0xfU)) 
                                       == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                      & (0U != (0x1fU 
                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 0xfU)))) 
                                     | (((0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 0x14U)) 
                                         == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                        & (0U != (0x1fU 
                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                     >> 0x14U))))) 
                                    & (2ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))
                                    ? 2ULL : 1ULL);
                        } else {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                                = (0x1fU & 0U);
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        }
                    } else {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                            = (0x1fU & 0U);
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    }
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w 
                        = ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                  >> 1U)) && (1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr));
                }
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w 
                    = ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                 >> 3U))) && ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                               ? ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))
                                               : ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))));
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w 
                    = ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                 >> 3U))) && ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                               ? ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))
                                               : ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                      && (1U 
                                                          & (~ 
                                                             (((((0x1fU 
                                                                  & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                     >> 0xfU)) 
                                                                 == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                & (0U 
                                                                   != 
                                                                   (0x1fU 
                                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                       >> 0xfU)))) 
                                                               | (((0x1fU 
                                                                    & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                       >> 0x14U)) 
                                                                   == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                  & (0U 
                                                                     != 
                                                                     (0x1fU 
                                                                      & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                         >> 0x14U))))) 
                                                              & (2ULL 
                                                                 != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))))));
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w 
                    = ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                 >> 3U))) && ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                               ? ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))
                                               : ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))));
            } else {
                if ((8U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                } else if ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                } else if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                    }
                    if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w 
                            = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                        >> 0x14U));
                        if ((((((0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                          >> 0xfU)) 
                                == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                               & (0U != (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                  >> 0xfU)))) 
                              | (((0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0x14U)) 
                                  == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                 & (0U != (0x1fU & 
                                           (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                            >> 0x14U))))) 
                             & ((2ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                & (0x10000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 2ULL;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                        } else if ((0x10000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x10000ULL;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                                = (((- (IData)((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 0x1fU))) 
                                    << 0xcU) | ((0xfe0U 
                                                 & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                    >> 0x14U)) 
                                                | (0x1fU 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 7U))));
                        } else {
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w 
                                = jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_he214ed84__0;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x20000ULL;
                            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                        }
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                            = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                        >> 0xfU));
                    } else {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    }
                } else {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                }
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w 
                    = ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                 >> 3U))) && ((1U & 
                                               (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 2U))) 
                                              && ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                      && ((1U 
                                                           & (~ 
                                                              (((((0x1fU 
                                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                      >> 0xfU)) 
                                                                  == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                 & (0U 
                                                                    != 
                                                                    (0x1fU 
                                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                        >> 0xfU)))) 
                                                                | (((0x1fU 
                                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                        >> 0x14U)) 
                                                                    == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                   & (0U 
                                                                      != 
                                                                      (0x1fU 
                                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                          >> 0x14U))))) 
                                                               & ((2ULL 
                                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                  & (0x10000ULL 
                                                                     != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) 
                                                          && (0x10000ULL 
                                                              == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))));
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w 
                    = ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                 >> 3U))) && ((1U & 
                                               (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 2U))) 
                                              && ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                      && ((1U 
                                                           & (~ 
                                                              (((((0x1fU 
                                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                      >> 0xfU)) 
                                                                  == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                 & (0U 
                                                                    != 
                                                                    (0x1fU 
                                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                        >> 0xfU)))) 
                                                                | (((0x1fU 
                                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                        >> 0x14U)) 
                                                                    == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                   & (0U 
                                                                      != 
                                                                      (0x1fU 
                                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                          >> 0x14U))))) 
                                                               & ((2ULL 
                                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                  & (0x10000ULL 
                                                                     != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) 
                                                          && (0x10000ULL 
                                                              == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))));
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w 
                    = ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                 >> 3U))) && ((1U & 
                                               (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 2U))) 
                                              && ((1U 
                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                      && ((1U 
                                                           & (~ 
                                                              (((((0x1fU 
                                                                   & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                      >> 0xfU)) 
                                                                  == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                 & (0U 
                                                                    != 
                                                                    (0x1fU 
                                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                        >> 0xfU)))) 
                                                                | (((0x1fU 
                                                                     & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                        >> 0x14U)) 
                                                                    == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                                   & (0U 
                                                                      != 
                                                                      (0x1fU 
                                                                       & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                          >> 0x14U))))) 
                                                               & ((2ULL 
                                                                   != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                                  & (0x10000ULL 
                                                                     != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) 
                                                          && (0x10000ULL 
                                                              != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))));
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
            }
        } else if ((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
            if ((8U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
            } else if ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                    }
                    if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                            = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                        >> 7U));
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 1ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                            = (0xfffff000U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr);
                    } else {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                            = (0x1fU & 0U);
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    }
                } else {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                        = (0x1fU & 0U);
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                }
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w 
                    = ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                              >> 1U)) && (1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr));
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
            } else if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                }
                if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                        = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                    >> 0xfU));
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                        = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                    >> 7U));
                    if (jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_h4e4ccb19__0) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w 
                            = ((8U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                      >> 0x1bU)) | 
                               (7U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                      >> 0xcU)));
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                            = (((- (IData)((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                  >> 0x18U)))) 
                                << 5U) | (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 0x14U)));
                    } else {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w 
                            = (7U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                     >> 0xcU));
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                            = jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__I_imm_sign_extended_w;
                    }
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                        = (((((0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                        >> 0xfU)) == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                             & (0U != (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 0xfU)))) 
                            & (2ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))
                            ? 2ULL : 1ULL);
                } else {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                        = (0x1fU & 0U);
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                }
            } else {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w 
                    = (0x1fU & 0U);
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
            }
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w 
                = ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                             >> 3U))) && ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                           ? ((1U & 
                                               (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))
                                           : ((1U & 
                                               (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))));
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w 
                = ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                             >> 3U))) && ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                           ? ((1U & 
                                               (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))
                                           : ((1U & 
                                               (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                                  && (1U 
                                                      & (~ 
                                                         ((((0x1fU 
                                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                >> 0xfU)) 
                                                            == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                           & (0U 
                                                              != 
                                                              (0x1fU 
                                                               & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                  >> 0xfU)))) 
                                                          & (2ULL 
                                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))))));
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w 
                = ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                             >> 3U))) && ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                                           ? ((1U & 
                                               (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))
                                           : ((1U & 
                                               (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))));
        } else if ((8U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
            if ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    }
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                        = ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)
                            ? 1ULL : 0x8000000000ULL);
                } else {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                }
            } else {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
            }
        } else {
            if ((4U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
            } else if ((2U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                if ((1U & (~ vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr))) {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                }
                if ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr)) {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w 
                        = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                    >> 7U));
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w 
                        = jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT____VdfgExtracted_he214ed84__0;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w 
                        = (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                    >> 0xfU));
                    if ((1U & (~ (((((((0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                 >> 0xfU)) 
                                       == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                      & (0U != (0x1fU 
                                                & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                   >> 0xfU)))) 
                                     & (2ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                    & (0x40000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                   & (0x80000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                  & (0x100000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))))) {
                        if ((1U & (~ ((((0x40000ULL 
                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                        & (0x80000ULL 
                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                       & (0x100000ULL 
                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                      | (((0x100000ULL 
                                           == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                          & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready)) 
                                         & (IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_decoder_instr_valid)))))) {
                            if ((0x40000ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) {
                                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 1U;
                            }
                        }
                    }
                    if ((((((((0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                        >> 0xfU)) == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                             & (0U != (0x1fU & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                >> 0xfU)))) 
                            & (2ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                           & (0x40000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                          & (0x80000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                         & (0x100000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state))) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 2ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    } else if (((((0x40000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                  & (0x80000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                 & (0x100000ULL != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                | (((0x100000ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                    & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready)) 
                                   & (IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_decoder_instr_valid)))) {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x40000ULL;
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w 
                            = jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__I_imm_sign_extended_w;
                    } else {
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next 
                            = ((0x40000ULL == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)
                                ? 0x80000ULL : 0x100000ULL);
                        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                    }
                } else {
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
                }
            } else {
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 1U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_regdest_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__csr_mret_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_alu_jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_b_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__use_pc_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_instr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__rf_addr_a_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_dest_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__is_alu_write_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__lsu_ctrl_valid_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_wb_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__jmp_addr_w = 0U;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x8000000000ULL;
                vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__imm_ext_w = 0U;
            }
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_op_a_w 
                = ((1U & (~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                             >> 2U))) && ((1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                 >> 1U)) 
                                          && ((1U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr) 
                                              && ((1U 
                                                   & (~ 
                                                      (((((((0x1fU 
                                                             & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                >> 0xfU)) 
                                                            == (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__prev_dest_addr)) 
                                                           & (0U 
                                                              != 
                                                              (0x1fU 
                                                               & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__ifu_inst__DOT__out_instr 
                                                                  >> 0xfU)))) 
                                                          & (2ULL 
                                                             != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                         & (0x40000ULL 
                                                            != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                        & (0x80000ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                       & (0x100000ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)))) 
                                                  && ((((0x40000ULL 
                                                         != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                        & (0x80000ULL 
                                                           != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                       & (0x100000ULL 
                                                          != vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state)) 
                                                      | (((0x100000ULL 
                                                           == vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__state) 
                                                          & (IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_ifu_ready)) 
                                                         & (IData)(jedro_1_addi_tb__DOT__dut__DOT__ifu_decoder_instr_valid)))))));
            vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__alu_sel_w = 0U;
        }
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__illegal_instr_w = 0U;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_inst__DOT__next = 0x10000000000ULL;
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_0____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 3U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_0____pinNumber4));
    if ((8U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)) {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_8____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_0____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_12____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_4____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_10____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_2____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_14____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_6____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_9____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_1____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_13____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_5____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_11____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_3____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_15____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_7____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_16____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_24____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_24____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_20____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_28____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_28____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_18____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_26____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_26____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_22____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_30____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_30____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_17____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_25____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_25____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_21____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_29____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_29____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_19____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_27____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_27____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_23____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_31____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_31____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign;
    } else {
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_8____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_12____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_10____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_14____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_9____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_13____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_11____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4;
        vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_15____pinNumber4 
            = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_16____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_24____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_24____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_20____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_28____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_28____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_18____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_26____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_26____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_22____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_30____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_30____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_17____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_25____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_25____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_21____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_29____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_29____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_19____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_27____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_27____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_23____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4;
        jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_31____pinNumber4 
            = jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_31____pinNumber4;
    }
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_4____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 3U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_4____pinNumber4));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_2____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 3U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_2____pinNumber4));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_6____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 3U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_6____pinNumber4));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_1____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 3U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_1____pinNumber4));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_5____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 3U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_5____pinNumber4));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_3____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 3U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_3____pinNumber4));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_8_7____pinNumber4 
        = ((~ (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b 
               >> 3U)) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_left_32b_inst__DOT____Vcellout__ins_4_7____pinNumber4));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__31__KET____DOT__FA_1b__DOT__sum 
        = ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
            ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
           >> 0x1fU);
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__30__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x1eU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__29__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x1dU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__28__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x1cU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__27__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x1bU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__26__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x1aU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__25__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x19U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__24__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x18U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__23__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x17U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__22__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x16U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__21__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x15U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__20__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x14U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__19__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x13U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__18__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x12U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__17__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x11U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__16__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0x10U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__15__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0xfU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__14__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0xeU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__13__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0xdU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__12__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0xcU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__11__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0xbU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__10__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 0xaU));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__9__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 9U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__8__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 8U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__7__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 7U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__6__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 6U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__5__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 5U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__4__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 4U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__3__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 3U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__2__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 2U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__1__KET____DOT__FA_1b__DOT__sum 
        = (1U & ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                  ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                 >> 1U));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__FA_1b_0__DOT__sum 
        = (1U & (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                 ^ jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__FA_1b_0____pinNumber5 
        = (1U & ((((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel) 
                   >> 3U) & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__FA_1b_0__DOT__sum)) 
                 | (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                    & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__1__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__FA_1b_0____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__1__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 1U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__2__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__1__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__2__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 2U)));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_res 
        = ((((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
              ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
              : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_31____pinNumber4)) 
            << 0x1fU) | ((((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                            ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                            : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_30____pinNumber4)) 
                          << 0x1eU) | ((((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                          ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                          : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_29____pinNumber4)) 
                                        << 0x1dU) | 
                                       ((((0x10U & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                           ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                           : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_28____pinNumber4)) 
                                         << 0x1cU) 
                                        | ((((0x10U 
                                              & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                              ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                              : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_27____pinNumber4)) 
                                            << 0x1bU) 
                                           | ((((0x10U 
                                                 & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_26____pinNumber4)) 
                                               << 0x1aU) 
                                              | ((((0x10U 
                                                    & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                    ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                    : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_25____pinNumber4)) 
                                                  << 0x19U) 
                                                 | ((((0x10U 
                                                       & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                       ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                       : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_24____pinNumber4)) 
                                                     << 0x18U) 
                                                    | ((((0x10U 
                                                          & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                          ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                          : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_23____pinNumber4)) 
                                                        << 0x17U) 
                                                       | ((((0x10U 
                                                             & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                             ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                             : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_22____pinNumber4)) 
                                                           << 0x16U) 
                                                          | ((((0x10U 
                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                                : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_21____pinNumber4)) 
                                                              << 0x15U) 
                                                             | ((((0x10U 
                                                                   & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                   ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                                   : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_20____pinNumber4)) 
                                                                 << 0x14U) 
                                                                | ((((0x10U 
                                                                      & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                      ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                                      : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_19____pinNumber4)) 
                                                                    << 0x13U) 
                                                                   | ((((0x10U 
                                                                         & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                         ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                                         : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_18____pinNumber4)) 
                                                                       << 0x12U) 
                                                                      | ((((0x10U 
                                                                            & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                            ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                                            : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_17____pinNumber4)) 
                                                                          << 0x11U) 
                                                                         | ((((0x10U 
                                                                               & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                               ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT__mux_sign)
                                                                               : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_16____pinNumber4)) 
                                                                             << 0x10U) 
                                                                            | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_31____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_23____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4))) 
                                                                                << 0xfU) 
                                                                               | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_30____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_22____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4))) 
                                                                                << 0xeU) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_29____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_21____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4))) 
                                                                                << 0xdU) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_28____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_20____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4))) 
                                                                                << 0xcU) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_27____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_19____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4))) 
                                                                                << 0xbU) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_26____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_18____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4))) 
                                                                                << 0xaU) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_25____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_17____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4))) 
                                                                                << 9U) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_24____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_16____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4))) 
                                                                                << 8U) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_23____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_15____pinNumber4)
                                                                                 : 
                                                                                ((4U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_11____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4)))) 
                                                                                << 7U) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_22____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_14____pinNumber4)
                                                                                 : 
                                                                                ((4U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_10____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4)))) 
                                                                                << 6U) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_21____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_13____pinNumber4)
                                                                                 : 
                                                                                ((4U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_9____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4)))) 
                                                                                << 5U) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_20____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_12____pinNumber4)
                                                                                 : 
                                                                                ((4U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_8____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4)))) 
                                                                                << 4U) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_19____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_11____pinNumber4)
                                                                                 : 
                                                                                ((4U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_7____pinNumber4)
                                                                                 : 
                                                                                ((2U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_5____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4))))) 
                                                                                << 3U) 
                                                                                | ((((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_18____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_10____pinNumber4)
                                                                                 : 
                                                                                ((4U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_6____pinNumber4)
                                                                                 : 
                                                                                ((2U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_4____pinNumber4)
                                                                                 : (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4))))) 
                                                                                << 2U) 
                                                                                | ((2U 
                                                                                & (((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_17____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_9____pinNumber4)
                                                                                 : 
                                                                                ((4U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_5____pinNumber4)
                                                                                 : 
                                                                                ((2U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_3____pinNumber4)
                                                                                 : 
                                                                                ((1U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                                                                                >> 2U)
                                                                                 : 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                                                                                >> 1U)))))) 
                                                                                << 1U)) 
                                                                                | (1U 
                                                                                & ((0x10U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_8_16____pinNumber4)
                                                                                 : 
                                                                                ((8U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_4_8____pinNumber4)
                                                                                 : 
                                                                                ((4U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_2_4____pinNumber4)
                                                                                 : 
                                                                                ((2U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__shifter_right_32b_inst__DOT____Vcellout__ins_1_2____pinNumber4)
                                                                                 : 
                                                                                ((1U 
                                                                                & vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux_alu_op_b)
                                                                                 ? 
                                                                                (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                                                                                >> 1U)
                                                                                 : vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a)))))))))))))))))))))))))))))))))))));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__3__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__2__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__3__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 3U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__4__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__3__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__4__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 4U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__5__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__4__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__5__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 5U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__6__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__5__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__6__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 6U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__7__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__6__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__7__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 7U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__8__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__7__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__8__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 8U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__9__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__8__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__9__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 9U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__10__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__9__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__10__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0xaU)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__11__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__10__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__11__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0xbU)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__12__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__11__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__12__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0xcU)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__13__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__12__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__13__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0xdU)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__14__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__13__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__14__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0xeU)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__15__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__14__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__15__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0xfU)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__16__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__15__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__16__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x10U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__17__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__16__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__17__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x11U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__18__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__17__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__18__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x12U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__19__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__18__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__19__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x13U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__20__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__19__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__20__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x14U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__21__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__20__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__21__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x15U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__22__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__21__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__22__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x16U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__23__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__22__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__23__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x17U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__24__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__23__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__24__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x18U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__25__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__24__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__25__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x19U)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__26__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__25__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__26__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x1aU)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__27__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__26__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__27__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x1bU)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__28__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__27__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__28__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x1cU)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__29__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__28__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__29__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x1dU)));
    jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__30__KET____DOT__FA_1b____pinNumber5 
        = (1U & (((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__29__KET____DOT__FA_1b____pinNumber5) 
                  & (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__30__KET____DOT__FA_1b__DOT__sum)) 
                 | ((vlSelf->jedro_1_addi_tb__DOT__dut__DOT__mux2_alu_op_a 
                     & jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__b_mod) 
                    >> 0x1eU)));
    vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__adder_res 
        = ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__31__KET____DOT__FA_1b__DOT__sum) 
             ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__30__KET____DOT__FA_1b____pinNumber5)) 
            << 0x1fU) | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__30__KET____DOT__FA_1b__DOT__sum) 
                           ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__29__KET____DOT__FA_1b____pinNumber5)) 
                          << 0x1eU) | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__29__KET____DOT__FA_1b__DOT__sum) 
                                         ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__28__KET____DOT__FA_1b____pinNumber5)) 
                                        << 0x1dU) | 
                                       ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__28__KET____DOT__FA_1b__DOT__sum) 
                                          ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__27__KET____DOT__FA_1b____pinNumber5)) 
                                         << 0x1cU) 
                                        | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__27__KET____DOT__FA_1b__DOT__sum) 
                                             ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__26__KET____DOT__FA_1b____pinNumber5)) 
                                            << 0x1bU) 
                                           | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__26__KET____DOT__FA_1b__DOT__sum) 
                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__25__KET____DOT__FA_1b____pinNumber5)) 
                                               << 0x1aU) 
                                              | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__25__KET____DOT__FA_1b__DOT__sum) 
                                                   ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__24__KET____DOT__FA_1b____pinNumber5)) 
                                                  << 0x19U) 
                                                 | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__24__KET____DOT__FA_1b__DOT__sum) 
                                                      ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__23__KET____DOT__FA_1b____pinNumber5)) 
                                                     << 0x18U) 
                                                    | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__23__KET____DOT__FA_1b__DOT__sum) 
                                                         ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__22__KET____DOT__FA_1b____pinNumber5)) 
                                                        << 0x17U) 
                                                       | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__22__KET____DOT__FA_1b__DOT__sum) 
                                                            ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__21__KET____DOT__FA_1b____pinNumber5)) 
                                                           << 0x16U) 
                                                          | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__21__KET____DOT__FA_1b__DOT__sum) 
                                                               ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__20__KET____DOT__FA_1b____pinNumber5)) 
                                                              << 0x15U) 
                                                             | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__20__KET____DOT__FA_1b__DOT__sum) 
                                                                  ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__19__KET____DOT__FA_1b____pinNumber5)) 
                                                                 << 0x14U) 
                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__19__KET____DOT__FA_1b__DOT__sum) 
                                                                     ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__18__KET____DOT__FA_1b____pinNumber5)) 
                                                                    << 0x13U) 
                                                                   | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__18__KET____DOT__FA_1b__DOT__sum) 
                                                                        ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__17__KET____DOT__FA_1b____pinNumber5)) 
                                                                       << 0x12U) 
                                                                      | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__17__KET____DOT__FA_1b__DOT__sum) 
                                                                           ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__16__KET____DOT__FA_1b____pinNumber5)) 
                                                                          << 0x11U) 
                                                                         | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__16__KET____DOT__FA_1b__DOT__sum) 
                                                                              ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__15__KET____DOT__FA_1b____pinNumber5)) 
                                                                             << 0x10U) 
                                                                            | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__15__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__14__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 0xfU) 
                                                                               | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__14__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__13__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 0xeU) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__13__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__12__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 0xdU) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__12__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__11__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 0xcU) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__11__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__10__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 0xbU) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__10__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__9__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 0xaU) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__9__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__8__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 9U) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__8__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__7__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 8U) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__7__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__6__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 7U) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__6__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__5__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 6U) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__5__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__4__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 5U) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__4__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__3__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 4U) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__3__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__2__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 3U) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__2__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__genblk1__BRA__1__KET____DOT__FA_1b____pinNumber5)) 
                                                                                << 2U) 
                                                                                | ((((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__genblk1__BRA__1__KET____DOT__FA_1b__DOT__sum) 
                                                                                ^ (IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT____Vcellout__FA_1b_0____pinNumber5)) 
                                                                                << 1U) 
                                                                                | ((IData)(jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__ripple_carry_adder_32b_inst__DOT__FA_1b_0__DOT__sum) 
                                                                                ^ 
                                                                                ((IData)(vlSelf->jedro_1_addi_tb__DOT__dut__DOT__decoder_alu_sel) 
                                                                                >> 3U)))))))))))))))))))))))))))))))));
}

void Vjedro_1_addi_tb___024root___timing_resume(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___timing_resume\n"); );
    // Body
    if ((4ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VtrigSched_hddf0f50c__0.resume("@(posedge jedro_1_addi_tb.clk)");
    }
    if ((8ULL & vlSelf->__VactTriggered.word(0U))) {
        vlSelf->__VdlySched.resume();
    }
}

void Vjedro_1_addi_tb___024root___timing_commit(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___timing_commit\n"); );
    // Body
    if ((! (4ULL & vlSelf->__VactTriggered.word(0U)))) {
        vlSelf->__VtrigSched_hddf0f50c__0.commit("@(posedge jedro_1_addi_tb.clk)");
    }
}

void Vjedro_1_addi_tb___024root___eval_triggers__act(Vjedro_1_addi_tb___024root* vlSelf);

bool Vjedro_1_addi_tb___024root___eval_phase__act(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<4> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vjedro_1_addi_tb___024root___eval_triggers__act(vlSelf);
    Vjedro_1_addi_tb___024root___timing_commit(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vjedro_1_addi_tb___024root___timing_resume(vlSelf);
        Vjedro_1_addi_tb___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vjedro_1_addi_tb___024root___eval_phase__nba(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vjedro_1_addi_tb___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vjedro_1_addi_tb___024root___dump_triggers__nba(Vjedro_1_addi_tb___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vjedro_1_addi_tb___024root___dump_triggers__act(Vjedro_1_addi_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Vjedro_1_addi_tb___024root___eval(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vjedro_1_addi_tb___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("jedro_1_addi_tb.sv", 4, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vjedro_1_addi_tb___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("jedro_1_addi_tb.sv", 4, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vjedro_1_addi_tb___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vjedro_1_addi_tb___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vjedro_1_addi_tb___024root___eval_debug_assertions(Vjedro_1_addi_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_addi_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_addi_tb___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG
