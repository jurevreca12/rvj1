// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vjedro_1_ifu__pch.h"
#include "Vjedro_1_ifu.h"
#include "Vjedro_1_ifu___024root.h"

// FUNCTIONS
Vjedro_1_ifu__Syms::~Vjedro_1_ifu__Syms()
{
}

Vjedro_1_ifu__Syms::Vjedro_1_ifu__Syms(VerilatedContext* contextp, const char* namep, Vjedro_1_ifu* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
{
        // Check resources
        Verilated::stackCheck(1180);
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-9);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
}
