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
from riscvmodel.regnames import x0, x1, x2, x3, x4, x5, x6, x7, x8, x9, x10, x11, x12, x20, x21, x28, x29, x30, x31
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

def InstructionCustomDRET() -> MetaInstruction:
    return MetaInstruction(0x7b200073) 

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
            InstructionBEQ(x21, x6, 24),         # 0x8000_0054 --|
            InstructionADDI(x20, x0, 1),         # 0x8000_0058   |
            InstructionSLLI(x20, x20, 15),       # 0x8000_005c   |
            InstructionCSRRS(x0, x20, dcsr),     # 0x8000_0060   |    
            InstructionADDI(x21, x0, 6),         # 0x8000_0064   |    
            InstructionCustomDRET(),             # 0x8000_0068   |
            InstructionADDI(x31, x0, 1),         # 0x8000_006c <--
            InstructionADDI(x0, x0, 1),
            InstructionADDI(x0, x0, 1),
            InstructionADDI(x0, x0, 1),
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {x1: 1, x2: 2, x3: 3, x4: 0, x5:0, x6:6}
    
    def extra_env(self) -> dict:
        return {
            'TEST_DEBUG_REQ' : 1
        }

@dataclass
class DCSRExpVal:
    prv: int = 3
    step: int = 0
    nmip: int = 0
    mprven: int = 0
    cause: int = 1
    stoptime: int = 0
    stopcount: int = 0
    stepie: int = 0
    ebreaku: int = 0
    ebreaks: int = 0
    ebreakm: int = 0
    xdebugver: int = 4

    def encode(self) -> int:
        return (self.prv       << 0  |
                self.step      << 2  |
                self.nmip      << 3  |
                self.mprven    << 4  |
                self.cause     << 6  |
                self.stoptime  << 9  |
                self.stopcount << 10 |
                self.stepie    << 11 |
                self.ebreaku   << 12 |
                self.ebreaks   << 13 |
                self.ebreakm   << 15 |
                self.xdebugver << 28)
               
    
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
            InstructionADDI(x6, x0, 1),          # 0x8000_0050 <--
            InstructionBEQ (x1, x6, 28),         # 0x8000_0054 --| 
            InstructionCSRRS(x7, x0, dcsr),      # 0x0800_0058   |
            InstructionCSRRS(x8, x0, dpc),       # 0x0800_005c   |
            InstructionADDI(x20, x0, 1),         # 0x8000_0060   |
            InstructionSLLI(x20, x20, 15),       # 0x8000_0064   |
            InstructionCSRRS(x0, x20, dcsr),     # 0x8000_0068   |    
            InstructionCustomDRET(),             # 0x8000_006c   |
            InstructionCSRRS(x9,  x0, dcsr),     # 0x0800_0070 <--
            InstructionCSRRS(x10, x0, dpc),      # 0x0800_0074
            InstructionADDI(x12, x10, 4),        # 0x8000_0078
            InstructionCSRRW(x0, x12, dpc),      # 0x8000_007c
            InstructionCustomDRET(),             # 0x8000_0080
            InstructionADDI(x11, x0, 1),
            InstructionADDI(x0, x0, 1),
            InstructionADDI(x0, x0, 1),
        ]
        super().__init__(insns)

    
    def expects(self) -> dict:
        return {
            x1: 1, 
            x2: 2, 
            x3: 3, 
            x4: 4, 
            x5: 5, 
            x6: 1, 
            x7:DCSRExpVal(cause=3).encode(), 
            x8: 0x8000_0000,
            x9: DCSRExpVal(ebreakm=1).encode(),
            x10: 0x8000_0018,
            x11: 0}

    def extra_env(self) -> dict:
        return {
            'TEST_DEBUG_REQ' : 1
        }


class DebugStepTest(Program):
    """
    Test if the step functionality of the debug module works. Each time the CPU enters debug mode,
    a counter is incremented. This signals if the CPU is correctly stepping through instructions.
    """
    def __init__(self):
        insns = [
            InstructionLUI  (x28, 0x80000),      # 0x8000_0000
            InstructionADDI (x28, x28, 0x20),    # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec),    # 0x8000_0008
            InstructionADDI(x1, x0, 1),          # 0x8000_000c
            InstructionADDI(x2, x0, 2),          # 0x8000_0010
            InstructionADDI(x3, x0, 3),          # 0x8000_0014
            InstructionADDI(x4, x0, 2),          # 0x8000_0018 
            InstructionADDI(x4, x0, 4),          # 0x8000_001c
            InstructionADDI(x5, x0, 5),          # 0x8000_0020
            InstructionADDI(x31, x0, 1),         # 0x8000_0024
            InstructionADDI(x0, x0, 1),          # 0x8000_0028  
            InstructionADDI(x0, x0, 1),          # 0x8000_002c
            InstructionADDI(x0, x0, 1),          # 0x8000_0030
            InstructionADDI(x0, x0, 1),          # 0x8000_0034
            InstructionADDI(x0, x0, 1),          # 0x8000_0038
            InstructionADDI(x0, x0, 1),          # 0x8000_003c
            InstructionADDI(x0, x0, 1),          # 0x8000_0040
            InstructionADDI(x0, x0, 1),          # 0x8000_0044
            InstructionADDI(x0, x0, 1),          # 0x8000_0048
            InstructionADDI(x0, x0, 1),          # 0x8000_004c
            InstructionADDI(x6, x6, 1),          # 0x8000_0050 <--
            InstructionCSRRSI(x0, 0x4, dcsr),    # 0x8000_0054   | step = 1
            InstructionCustomDRET(),             # 0x8000_0058   |
            InstructionADDI(x0, x0, 1),
            InstructionADDI(x0, x0, 1),
        ]
        super().__init__(insns)

    
    def expects(self) -> dict:
        return {
            x1: 1, 
            x2: 2, 
            x3: 3, 
            x4: 4, 
            x5: 5, 
            x6: 10
        }

    def extra_env(self) -> dict:
        return {
            'TEST_DEBUG_REQ' : 1
        }


SDEXT_TESTS = {
    "sdext-dcsr-exc":      DCSRExceptionTest(),
    "sdext-dpc-exc":       DPCExceptionTest(),
    "sdext-dscratch0-exc": DScratch0ExceptionTest(),
    "sdext-dscratch1-exc": DScratch1ExceptionTest(),
    "sdext-ebreak-dbgrom": EBreakToDebugROM(),
    "sdext-dbg-regs-acc":  DebugRegAccessTest(),
    "sdext-step":          DebugStepTest(),
}
