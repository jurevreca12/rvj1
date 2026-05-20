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
    InstructionMRET,
    InstructionEBREAK,
)
from riscvmodel.isa import Instruction
from riscvmodel.regnames import x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x28, x29, x30, x31
from riscvmodel.csrnames import misa, mscratch, mtvec, mepc, mcause, mstatus, mtval, dcsr, dpc, dscratch0, dscratch1
from riscvmodel.program import Program

from dataclasses import dataclass

BOOT_ADDR = 0x8000_0000
DATA_ADDR = 0x8000_0400

class MetaInstruction(Instruction):
    def __init__(self, encoding: int):
        self.encoding = encoding
    def encode(self) -> int:
        return self.encoding
    def execute(self, model):
        pass

def InstructionCustomEBREAK() -> MetaInstruction:
    return MetaInstruction(0x00100073) 


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


class EBreakToDebugROM(Program):
    """
    After encountering an ebreak instruction the CPU should jump to the debug ROM.
    The Debug ROM is located at 0x8000_0050.
    """
    def __init__(self):
        insns = [
            InstructionLUI  (x28, 0x80000),      # 0x8000_0000
            InstructionADDI (x28, x28, 0x20),    # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec),    # 0x8000_0008
            InstructionADDI(x1, x0, 1),          # 0x8000_000c
            InstructionADDI(x2, x0, 2),          # 0x8000_0010
            InstructionADDI(x3, x0, 3),          # 0x8000_0014
            InstructionCustomEBREAK(),           # 0x8000_0018 ---
            InstructionADDI(x4, x0, 4),          # 0x8000_001c   |
            InstructionADDI(x5, x0, 5),          # 0x8000_0020   |
            InstructionADDI(x31, x0, 1),         # 0x8000_0024   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0028   |
            InstructionADDI(x0, x0, 1),          # 0x8000_002c   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0030   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0034   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0038   |
            InstructionADDI(x0, x0, 1),          # 0x8000_003c   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0040   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0044   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0048   |
            InstructionADDI(x0, x0, 1),          # 0x8000_004c   |
            InstructionADDI(x6, x0, 6),          # 0x8000_0050 <--
            InstructionADDI(x31, x0, 1),         # 0x8000_0054
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {x1: 1, x2: 2, x3: 3, x4: 0, x5:0, x6:6}

@dataclass
class DCSRExpVal:
    prv = 3
    step = 0
    nmip = 0
    mprev = 0
    cause = 1
    stoptime = 0
    stopcount = 0
    stepie = 0
    ebreaku = 0
    ebreaks = 0
    ebreakm = 1
    xdebugver = 4

    def encode(self) -> int:
        return (prv       << 0  |
                step      << 2  |
                nmip      << 3  |
                mprven    << 4  |
                cause     << 6  |
                stoptime  << 9  |
                stopcount << 10 |
                stepie    << 11 |
                ebreaku   << 12 |
                ebreaks   << 13 |
                ebreakm   << 15 |
                xdebugver << 28)
               
    
class DebugRegAccessTest(Program):
    """
    After encountering an ebreak instruction the CPU should jump to the debug ROM and enter debug mode.
    The Debug ROM is located at 0x8000_0050. Hence after debug registers should be accessible.
    """
    def __init__(self):
        insns = [
            InstructionLUI  (x28, 0x80000),      # 0x8000_0000
            InstructionADDI (x28, x28, 0x20),    # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec),    # 0x8000_0008
            InstructionADDI(x1, x0, 1),          # 0x8000_000c
            InstructionADDI(x2, x0, 2),          # 0x8000_0010
            InstructionADDI(x3, x0, 3),          # 0x8000_0014
            InstructionCustomEBREAK(),           # 0x8000_0018 ---
            InstructionADDI(x4, x0, 4),          # 0x8000_001c   |
            InstructionADDI(x5, x0, 5),          # 0x8000_0020   |
            InstructionADDI(x31, x0, 1),         # 0x8000_0024   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0028   |
            InstructionADDI(x0, x0, 1),          # 0x8000_002c   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0030   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0034   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0038   |
            InstructionADDI(x0, x0, 1),          # 0x8000_003c   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0040   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0044   |
            InstructionADDI(x0, x0, 1),          # 0x8000_0048   |
            InstructionADDI(x0, x0, 1),          # 0x8000_004c   |
            InstructionADDI(x6, x0, 6),          # 0x8000_0050 <--
            InstructionCSRRW(x7, x0, dcsr),      # 0x0800_0054
            InstructionCSRRW(x8, x0, dpc),       # 0x0800_0058
            InstructionADDI(x31, x0, 1),         # 0x8000_005c
        ]
        super().__init__(insns)

    def dcsr_exp_val() -> int:
        return prv
    
    def expects(self) -> dict:
        return {x1: 1, x2: 2, x3: 3, x4: 0, x5:0, x6:6, x7:DCSRExpVal().encode(), x8: 0x8000_001c}


SDEXT_TESTS = {
    "sdext-dcsr-exc":      DCSRExceptionTest(),
    "sdext-dpc-exc":       DPCExceptionTest(),
    "sdext-dscratch0-exc": DScratch0ExceptionTest(),
    "sdext-dscratch1-exc": DScratch1ExceptionTest(),
    "sdext-ebreak-dbgrom": EBreakToDebugROM(),
}
