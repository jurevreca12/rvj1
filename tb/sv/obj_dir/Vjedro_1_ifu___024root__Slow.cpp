// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vjedro_1_ifu.h for the primary calling header

#include "Vjedro_1_ifu__pch.h"
#include "Vjedro_1_ifu__Syms.h"
#include "Vjedro_1_ifu___024root.h"

void Vjedro_1_ifu___024root___ctor_var_reset(Vjedro_1_ifu___024root* vlSelf);

Vjedro_1_ifu___024root::Vjedro_1_ifu___024root(Vjedro_1_ifu__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vjedro_1_ifu___024root___ctor_var_reset(this);
}

void Vjedro_1_ifu___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vjedro_1_ifu___024root::~Vjedro_1_ifu___024root() {
}
