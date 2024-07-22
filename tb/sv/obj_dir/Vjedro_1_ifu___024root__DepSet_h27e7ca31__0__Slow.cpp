// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vjedro_1_ifu.h for the primary calling header

#include "Vjedro_1_ifu__pch.h"
#include "Vjedro_1_ifu__Syms.h"
#include "Vjedro_1_ifu___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vjedro_1_ifu___024root___dump_triggers__stl(Vjedro_1_ifu___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vjedro_1_ifu___024root___eval_triggers__stl(Vjedro_1_ifu___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vjedro_1_ifu__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vjedro_1_ifu___024root___eval_triggers__stl\n"); );
    // Body
    vlSelf->__VstlTriggered.set(0U, (IData)(vlSelf->__VstlFirstIteration));
    vlSelf->__VstlTriggered.set(1U, (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2 
                                     != vlSelf->__Vtrigprevexpr___TOP__jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2__0));
    vlSelf->__VstlTriggered.set(2U, (vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2 
                                     != vlSelf->__Vtrigprevexpr___TOP__jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2__0));
    vlSelf->__Vtrigprevexpr___TOP__jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2__0 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_unsign_32b_inst__DOT__w2;
    vlSelf->__Vtrigprevexpr___TOP__jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2__0 
        = vlSelf->jedro_1_addi_tb__DOT__dut__DOT__alu_inst__DOT__less_than_sign_32b_inst__DOT__less_than_unsign_31b_inst__DOT__w2;
    if (VL_UNLIKELY((1U & (~ (IData)(vlSelf->__VstlDidInit))))) {
        vlSelf->__VstlDidInit = 1U;
        vlSelf->__VstlTriggered.set(1U, 1U);
        vlSelf->__VstlTriggered.set(2U, 1U);
    }
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vjedro_1_ifu___024root___dump_triggers__stl(vlSelf);
    }
#endif
}
