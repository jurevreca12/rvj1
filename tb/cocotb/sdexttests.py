from riscvmodel.insn import (
    InstructionLUI,
    InstructionAUIPC,
    InstructionADDI,
    InstructionSLTI,
    InstructionSLTIU,
    InstructionXORI,
    InstructionORI,
    InstructionANDI,
    InstructionSLLI,
    InstructionSRLI,
    InstructionSRAI,
    InstructionSUB,
    InstructionADD,
    InstructionSLT,
    InstructionSLTU,
    InstructionSLL,
    InstructionXOR,
    InstructionSRL,
    InstructionSRA,
    InstructionOR,
    InstructionAND,
    InstructionSB,
    InstructionLB,
    InstructionSW,
    InstructionLW,
    InstructionSH,
    InstructionLH,
    InstructionLBU,
    InstructionLHU,
    InstructionJAL,
    InstructionJALR,
    InstructionBEQ,
    InstructionBNE,
    InstructionBLT,
    InstructionBGE,
    InstructionBLTU,
    InstructionBGEU,
    InstructionCSRRW,
    InstructionCSRRS,
    InstructionCSRRC,
    InstructionCSRRWI,
    InstructionCSRRSI,
    InstructionCSRRCI,
    InstructionNOP,
    InstructionECALL,
    InstructionMRET
)
from riscvmodel.regnames import x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x28, x29, x30, x31
from riscvmodel.csrnames import misa, mscratch, mtvec, mepc, mcause, mstatus, mtval, dcsr, dpc, dscratch0, dscratch1
from riscvmodel.program import Program



BOOT_ADDR = 0x8000_0000
DATA_ADDR = 0x8000_0400


class DCSRExceptionTest(Program):
    """Test that accessing debug CSR outside of debug mode raises an exception"""

    def __init__(self):
        insns = [
            InstructionLUI  (x28, 0x80000),   # 0x8000_0000
            InstructionADDI (x28, x28, 0x20), # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec), # 0x8000_0008
            InstructionADDI(x1, x0, 1),       # 0x8000_000c
            InstructionADDI(x2, x0, 2),       # 0x8000_0010
            InstructionADDI(x3, x0, 3),       # 0x8000_0014
            InstructionCSRRW(x0, x1, dcsr),   # 0x8000_0018
            InstructionADDI(x4, x0, 4),       # 0x8000_001c
            InstructionADDI(x5, x0, 5),       # 0x8000_0020
            InstructionADDI(x31, x0, 1),      # 0x8000_0024
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {x1: 1, x2: 2, x3: 3, x4: 0, x5:5}

class DPCExceptionTest(Program):
    """Test that accessing debug PC outside of debug mode raises an exception"""

    def __init__(self):
        insns = [
            InstructionLUI  (x28, 0x80000),   # 0x8000_0000
            InstructionADDI (x28, x28, 0x20), # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec), # 0x8000_0008
            InstructionADDI(x1, x0, 1),       # 0x8000_000c
            InstructionADDI(x2, x0, 2),       # 0x8000_0010
            InstructionADDI(x3, x0, 3),       # 0x8000_0014
            InstructionCSRRW(x0, x1, dpc),    # 0x8000_0018
            InstructionADDI(x4, x0, 4),       # 0x8000_001c
            InstructionADDI(x5, x0, 5),       # 0x8000_0020
            InstructionADDI(x31, x0, 1),      # 0x8000_0024
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {x1: 1, x2: 2, x3: 3, x4: 0, x5:5}

class DScratch0ExceptionTest(Program):
    """Test that accessing debug PC outside of debug mode raises an exception"""

    def __init__(self):
        insns = [
            InstructionLUI  (x28, 0x80000),      # 0x8000_0000
            InstructionADDI (x28, x28, 0x20),    # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec),    # 0x8000_0008
            InstructionADDI(x1, x0, 1),          # 0x8000_000c
            InstructionADDI(x2, x0, 2),          # 0x8000_0010
            InstructionADDI(x3, x0, 3),          # 0x8000_0014
            InstructionCSRRW(x0, x1, dscratch0), # 0x8000_0018
            InstructionADDI(x4, x0, 4),          # 0x8000_001c
            InstructionADDI(x5, x0, 5),          # 0x8000_0020
            InstructionADDI(x31, x0, 1),         # 0x8000_0024
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {x1: 1, x2: 2, x3: 3, x4: 0, x5:5}

class DScratch1ExceptionTest(Program):
    """Test that accessing debug PC outside of debug mode raises an exception"""

    def __init__(self):
        insns = [
            InstructionLUI  (x28, 0x80000),      # 0x8000_0000
            InstructionADDI (x28, x28, 0x20),    # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec),    # 0x8000_0008
            InstructionADDI(x1, x0, 1),          # 0x8000_000c
            InstructionADDI(x2, x0, 2),          # 0x8000_0010
            InstructionADDI(x3, x0, 3),          # 0x8000_0014
            InstructionCSRRW(x0, x1, dscratch1), # 0x8000_0018
            InstructionADDI(x4, x0, 4),          # 0x8000_001c
            InstructionADDI(x5, x0, 5),          # 0x8000_0020
            InstructionADDI(x31, x0, 1),         # 0x8000_0024
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {x1: 1, x2: 2, x3: 3, x4: 0, x5:5}


SDEXT_TESTS = {
    "sdext-dcsr-exc":      DCSRExceptionTest(),
    "sdext-dpc-exc":       DPCExceptionTest(),
    "sdext-dscratch0-exc": DScratch0ExceptionTest(),
    "sdext-dscratch1-exc": DScratch1ExceptionTest(),
}
