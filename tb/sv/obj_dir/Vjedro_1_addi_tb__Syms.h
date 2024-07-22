// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VJEDRO_1_ADDI_TB__SYMS_H_
#define VERILATED_VJEDRO_1_ADDI_TB__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vjedro_1_addi_tb.h"

// INCLUDE MODULE CLASSES
#include "Vjedro_1_addi_tb___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vjedro_1_addi_tb__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vjedro_1_addi_tb* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vjedro_1_addi_tb___024root     TOP;

    // CONSTRUCTORS
    Vjedro_1_addi_tb__Syms(VerilatedContext* contextp, const char* namep, Vjedro_1_addi_tb* modelp);
    ~Vjedro_1_addi_tb__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
