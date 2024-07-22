// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vjedro_1_or_tb.h for the primary calling header

#include "Vjedro_1_or_tb__pch.h"
#include "Vjedro_1_or_tb__Syms.h"
#include "Vjedro_1_or_tb___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vjedro_1_or_tb___024root___dump_triggers__act(Vjedro_1_or_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Vjedro_1_or_tb___024root___eval_triggers__act(Vjedro_1_or_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_or_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_or_tb___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, (vlSelf->jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                     != vlSelf->__Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2__1));
    vlSelf->__VactTriggered.set(1U, (vlSelf->jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                     != vlSelf->__Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2__1));
    vlSelf->__VactTriggered.set(2U, ((IData)(vlSelf->jedro_1_or_tb__DOT__clk) 
                                     & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__clk__0))));
    vlSelf->__VactTriggered.set(3U, vlSelf->__VdlySched.awaitingCurrentTime());
    vlSelf->__Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2__1 
        = vlSelf->jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2;
    vlSelf->__Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2__1 
        = vlSelf->jedro_1_or_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2;
    vlSelf->__Vtrigprevexpr___TOP__jedro_1_or_tb__DOT__clk__0 
        = vlSelf->jedro_1_or_tb__DOT__clk;
    if (VL_UNLIKELY((1U & (~ (IData)(vlSelf->__VactDidInit))))) {
        vlSelf->__VactDidInit = 1U;
        vlSelf->__VactTriggered.set(0U, 1U);
        vlSelf->__VactTriggered.set(1U, 1U);
    }
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vjedro_1_or_tb___024root___dump_triggers__act(vlSelf);
    }
#endif
}
