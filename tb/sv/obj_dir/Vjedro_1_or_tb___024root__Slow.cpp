// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vjedro_1_or_tb.h for the primary calling header

#include "Vjedro_1_or_tb__pch.h"
#include "Vjedro_1_or_tb__Syms.h"
#include "Vjedro_1_or_tb___024root.h"

void Vjedro_1_or_tb___024root___ctor_var_reset(Vjedro_1_or_tb___024root* vlSelf);

Vjedro_1_or_tb___024root::Vjedro_1_or_tb___024root(Vjedro_1_or_tb__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vjedro_1_or_tb___024root___ctor_var_reset(this);
}

void Vjedro_1_or_tb___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vjedro_1_or_tb___024root::~Vjedro_1_or_tb___024root() {
}
