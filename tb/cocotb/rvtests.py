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
from riscvmodel.csrnames import misa, mscratch, mtvec, mepc, mcause, mstatus, mtval
from riscvmodel.program import Program

from collections.abc import Iterable


BOOT_ADDR = 0x8000_0000
DATA_ADDR = 0x8000_0400

def load_addr(addr: int, reg: int) -> list:
    upper_addr = addr & 0xFFFFF_000
    lower_addr = addr & 0x00000_FFF
    ret = [
        InstructionLUI(reg, (upper_addr >> 12)),
    ]
    if lower_addr != 0:
        ret.append(
            InstructionADDI(reg, reg, lower_addr)
        )
    return ret

def flatten_list(items, ignore_types=(bytes, str)):
    for x in items:
        if isinstance(x, Iterable) and not isinstance(x, ignore_types):
            yield from flatten_list(x)
        else:
            yield x

class LUITest(Program):
    """Basic test of LUI instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0),
            InstructionLUI(x2, 1),
            InstructionLUI(x3, 0x80000),
            InstructionLUI(x4, 0xFFFFF),
            InstructionLUI(x0, 0xFFFFF),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {x1: 0, x2: 0x00001000, x3: 0x80000000, x4: 0xfffff000}


class AUIPCTest(Program):
    """Basic test of AUIPC instruction"""

    def __init__(self):
        insns = [
            InstructionAUIPC(x1, 0),
            InstructionAUIPC(x2, 1),
            InstructionAUIPC(x3, 0x80000),
            InstructionAUIPC(x4, 0xFFFFF),
            InstructionAUIPC(x0, 0xFFFFF),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {
            x1:  0x8000_0000, 
            x2:  0x8000_0000 + 4   + (1 << 12), 
            x3: (0x8000_0000 + 8   + 0x8000_0000) & 0xFFFF_FFFF, 
            x4: (0x8000_0000 + 0xC + 0xffff_f000) & 0xFFFF_FFFF
        }


class ADDITest(Program):
    """Basic test of ADDI instruction"""

    def __init__(self):
        insns = [
            InstructionADDI(x1, x0, x0),
            InstructionADDI(x1, x1, 2),
            InstructionADDI(x2, x1, -1),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {x1: 2, x2: 1}


class SLTITest(Program):
    """Basic test of SLTI instruction"""

    def __init__(self):
        insns = [
            InstructionSLTI(x1, x0, 0),  # x1=0
            InstructionSLTI(x2, x1, 0),  # x2=0
            InstructionSLTI(x3, x0, 1),  # x3=1
            InstructionSLTI(x4, x3, 1),  # x4=0
            InstructionLUI(x5, 0x80000),
            InstructionSLTI(x6, x5, 0),  # x6=1
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
        def expects(self) -> dict:
            return {x1: 0, x2: 0, x3: 1, x4: 0, x5: 0x8000_0000, x6: 1}


class SLTIUTest(Program):
    """Basic test of SLTIU instruction"""

    def __init__(self):
        insns = [
            InstructionSLTIU(x1, x0, 0),
            InstructionSLTIU(x2, x1, 0),
            InstructionSLTIU(x3, x0, 1),
            InstructionSLTIU(x4, x3, 1),
            InstructionLUI(x5, 0x80000),
            InstructionSLTIU(x6, x5, 0),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
        
    def expects(self) -> dict:
        return {x1: 0, x2: 0, x3: 1, x4: 0, x5: 0x8000_0000, x6: 0}


class XORITest(Program):
    """Basic test of XORI instruction"""

    def __init__(self):
        insns = [
            InstructionXORI(x1, x0, 0x7FF),
            InstructionXORI(x2, x1, 0x001),
            InstructionXORI(x3, x0, -0x800),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {x1: 0x7FF, x2: 0x7FE, x3: 0xfffff800}


class ORITest(Program):
    """Basic test of ORI instruction"""

    def __init__(self):
        insns = [
            InstructionORI(x1, x0, 0x7FF),
            InstructionORI(x2, x1, 0x001),
            InstructionORI(x3, x0, -0x800),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {x1: 0x7FF, x2: 0x7FF, x3: 0xfffff800}


class ANDITest(Program):
    """Basic test of ANDI instruction"""

    def __init__(self):
        insns = [
            InstructionADDI(x1, x0, 0x7FF),
            InstructionANDI(x2, x1, 0x7FF),
            InstructionANDI(x3, x1, 0x001),
            InstructionANDI(x4, x1, -0x800),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {x1: 0x7FF, x2: 0x7FF, x3: 1, x4: 0x0}


class SLLITest(Program):
    """Basic test of SLLI instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionSLLI(x2, x1, 12),
            InstructionSLLI(x3, x1, 2),
            InstructionSLLI(x4, x3, 10),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {
            x1: 0xfebed000, 
            x2: 0xed000000, 
            x3: 0xfafb4000, 
            x4: 0xed000000
        }


class SRLITest(Program):
    """Basic test of SRLI instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionSRLI(x2, x1, 12),
            InstructionSRLI(x3, x1, 2),
            InstructionSRLI(x4, x3, 10),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {
            x1: 0xfebed000, 
            x2: 0x000febed, 
            x3: 0x3fafb400, 
            x4: 0x000febed
        }


class SRAITest(Program):
    """Basic test of SRAI instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionSRAI(x2, x1, 12),
            InstructionSRAI(x3, x1, 2),
            InstructionSRAI(x4, x3, 10),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {
            x1: 0xfebed000, 
            x2: 0xffffebed,
            x3: 0xffafb400,
            x4: 0xffffebed
        }


class ADDTest(Program):
    """Basic test of ADD instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionADD(x2, x0, x1),
            InstructionADD(x3, x1, x1),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {x1: 0xfebed000, x2: 0xfebed000, x3: 0xfd7da000}


class SUBTest(Program):
    """Basic test of SUB instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionSUB(x2, x0, x1),
            InstructionSUB(x3, x1, x1),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {x1: 0xfebed000, x2: 0x01413000, x3: 0x0}


class SLLTest(Program):
    """Basic test of SLL instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionSLL(x2, x1, x1),
            InstructionORI(x3, x0, 7),
            InstructionSLL(x4, x1, x3),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {
            x1: 0xfebed000, 
            x2: 0xfebed000, 
            x3: 0x00000007, 
            x4: 0x5f680000
        }


class SLTTest(Program):
    """Basic test of SLT instruction"""

    def __init__(self):
        insns = [
            InstructionADDI(x1, x0, 1),
            InstructionADDI(x2, x0, -1),
            InstructionADDI(x3, x0, 55),
            InstructionSLT(x4, x3, x2),
            InstructionSLT(x5, x3, x1),
            InstructionSLT(x6, x1, x2),
            InstructionSLT(x7, x2, x3),
            InstructionSLT(x8, x1, x3),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {
            x1: 1,
            x2: 0xffffffff,
            x3: 0x00000037,
            x4: 0,
            x5: 0,
            x6: 0,
            x7: 1,
            x8: 1
        }


class SLTUTest(Program):
    """Basic test of SLTU instruction"""

    def __init__(self):
        insns = [
            InstructionADDI(x1, x0, 1),
            InstructionADDI(x2, x0, -1),
            InstructionADDI(x3, x0, 55),
            InstructionSLTU(x4, x3, x2),
            InstructionSLTU(x5, x3, x1),
            InstructionSLTU(x6, x1, x2),
            InstructionSLTU(x7, x2, x3),
            InstructionSLTU(x8, x1, x3),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {
            x1: 1,
            x2: 0xffffffff,
            x3: 0x00000037,
            x4: 1,
            x5: 0,
            x6: 1,
            x7: 0,
            x8: 1
        }


class XORTest(Program):
    """Basic test of XOR instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionADDI(x1, x1, 0x123),
            InstructionLUI(x2, 0xDEADB),
            InstructionADDI(x2, x2, 0x234),
            InstructionADDI(x3, x0, 1234),
            InstructionXOR(x4, x1, x2),
            InstructionXOR(x5, x2, x1),
            InstructionXOR(x6, x1, x0),
            InstructionXOR(x7, x2, x3),
            InstructionXOR(x8, x2, x1),
            InstructionXOR(x9, x1, x3),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {
          x1: 0xfebed123,
          x2: 0xdeadb234,
          x3: 0x000004d2,
          x4: 0x20136317,
          x5: 0x20136317,
          x6: 0xfebed123,
          x7: 0xdeadb6e6,
          x8: 0x20136317,
          x9: 0xfebed5f1
        }


class SRLTest(Program):
    """Basic test of SRL instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionADDI(x1, x1, 0x123),
            InstructionLUI(x2, 0xDEADB),
            InstructionADDI(x2, x2, 0x234),
            InstructionADDI(x3, x0, 1234),
            InstructionSRL(x4, x1, x2),
            InstructionSRL(x5, x2, x1),
            InstructionSRL(x6, x1, x0),
            InstructionSRL(x7, x2, x3),
            InstructionSRL(x8, x2, x1),
            InstructionSRL(x9, x1, x3),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {
            x1: 0xfebed123,
            x2: 0xdeadb234,
            x3: 0x000004d2,
            x4: 0x00000feb,
            x5: 0x1bd5b646,
            x6: 0xfebed123,
            x7: 0x000037ab,
            x8: 0x1bd5b646,
            x9: 0x00003faf
        }


class SRATest(Program):
    """Basic test of SRA instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionADDI(x1, x1, 0x123),
            InstructionLUI(x2, 0xDEADB),
            InstructionADDI(x2, x2, 0x234),
            InstructionADDI(x3, x0, 1234),
            InstructionSRA(x4, x1, x2),
            InstructionSRA(x5, x2, x1),
            InstructionSRA(x6, x1, x0),
            InstructionSRA(x7, x2, x3),
            InstructionSRA(x8, x2, x1),
            InstructionSRA(x9, x1, x3),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        return {
            x1: 0xfebed123,
            x2: 0xdeadb234,
            x3: 0x000004d2,
            x4: 0xffffffeb,
            x5: 0xfbd5b646,
            x6: 0xfebed123,
            x7: 0xfffff7ab,
            x8: 0xfbd5b646,
            x9: 0xffffffaf
        }


class ORTest(Program):
    """Basic test of OR instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionADDI(x1, x1, 0x123),
            InstructionLUI(x2, 0xDEADB),
            InstructionADDI(x2, x2, 0x234),
            InstructionADDI(x3, x0, 1234),
            InstructionOR(x4, x1, x2),
            InstructionOR(x5, x2, x1),
            InstructionOR(x6, x1, x0),
            InstructionOR(x7, x2, x3),
            InstructionOR(x8, x2, x1),
            InstructionOR(x9, x1, x3),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {
            x1: 0xfebed123,
            x2: 0xdeadb234,
            x3: 0x000004d2,
            x4: 0xfebff337, 
            x5: 0xfebff337,
            x6: 0xfebed123,
            x7: 0xdeadb6f6,
            x8: 0xfebff337,
            x9: 0xfebed5f3
        }


class ANDTest(Program):
    """Basic test of AND instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionADDI(x1, x1, 0x123),
            InstructionLUI(x2, 0xDEADB),
            InstructionADDI(x2, x2, 0x234),
            InstructionADDI(x3, x0, 1234),
            InstructionAND(x4, x1, x2),
            InstructionAND(x5, x2, x1),
            InstructionAND(x6, x1, x0),
            InstructionAND(x7, x2, x3),
            InstructionAND(x8, x2, x1),
            InstructionAND(x9, x1, x3),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {
            x1: 0xfebed123,
            x2: 0xdeadb234,
            x3: 0x000004d2,
            x4: 0xdeac9020,
            x5: 0xdeac9020,
            x6: 0x0,
            x7: 0x00000010,
            x8: 0xdeac9020,
            x9: 0x2
        }

class SBLBTest(Program):
    """Basic test of SB and LB instructions."""

    def __init__(self):
        insns = [
            InstructionLUI(x2, 0xDEADC),
            InstructionADDI(x2, x2, 0x0DE),
            load_addr(DATA_ADDR, x1),
            InstructionSB(x1, x2, 0),
            InstructionSRLI(x2, x2, 8),
            InstructionSB(x1, x2, 1),
            InstructionSRLI(x2, x2, 8),
            InstructionSB(x1, x2, 2),
            InstructionSRLI(x2, x2, 8),
            InstructionSB(x1, x2, 3),
            InstructionLB(x3, x1, 0),
            InstructionLB(x4, x1, 1),
            InstructionLB(x5, x1, 2),
            InstructionLB(x6, x1, 3),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(list(flatten_list(insns)))
    
    def expects(self) -> dict:
        return {
            x1: 0x80000400,
            x2: 0x000000de,
            x3: 0xffffffde,
            x4: 0xffffffc0,
            x5: 0xffffffad,
            x6: 0xffffffde,
            x31: 0x1
        }


class SWLWTest(Program):
    """Basic test of SW and LW instructions."""

    def __init__(self):
        insns = [
            InstructionLUI(x2, 0xDEADC),
            InstructionADDI(x2, x2, 0x0DE),
            load_addr(DATA_ADDR, x1),
            InstructionSW(x1, x2, 0),
            InstructionLW(x3, x1, 0),
            InstructionLW(x4, x1, 0),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(list(flatten_list(insns)))

    def expects(self) -> dict:
        return {
            x1: 0x80000400,
            x2: 0xdeadc0de,
            x3: 0xdeadc0de,
            x4: 0xdeadc0de,
            x31: 0x1
        }


class SWLWTest2(Program):
    """A tougher test of SW and LW instructions. This test has many consecutive store and load instructions.
       The goal of this test is to try to congest the load store buffers and see if the control logic correctly
       stalls the pipeline.
    """

    def __init__(self):
        insns = [
            InstructionLUI(x2, 0xDEADC),
            InstructionADDI(x2, x2, 0x0DE),
            load_addr(DATA_ADDR, x1),
            InstructionSW(x1, x2, 0),
            InstructionSW(x1, x2, 4),
            InstructionSW(x1, x2, 8),
            InstructionSW(x1, x2, 12),
            InstructionSW(x1, x2, 16),
            InstructionSW(x1, x2, 20),
            InstructionADDI(x0, x0, 1),
            InstructionLW(x3, x1, 0),
            InstructionLW(x4, x1, 4),
            InstructionLW(x5, x1, 8),
            InstructionLW(x6, x1, 12),
            InstructionLW(x7, x1, 16),
            InstructionLW(x8, x1, 20),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(list(flatten_list(insns)))

    def expects(self) -> dict:
        return {
            x1: 0x80000400,
            x2: 0xdeadc0de,
            x3: 0xdeadc0de,
            x4: 0xdeadc0de,
            x5: 0xdeadc0de,
            x6: 0xdeadc0de,
            x7: 0xdeadc0de,
            x8: 0xdeadc0de,
            x31: 0x1
        }


class SHLHTest(Program):
    """Basic test of SH and LH instructions."""

    def __init__(self):
        insns = [
            InstructionLUI(x2, 0xDEADC),
            InstructionADDI(x2, x2, 0x0DE),
            load_addr(DATA_ADDR, x1),
            InstructionSH(x1, x2, 0),
            InstructionSRLI(x2, x2, 16),
            InstructionSH(x1, x2, 2),
            InstructionLH(x3, x1, 0),
            InstructionLH(x4, x1, 2),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(list(flatten_list(insns)))

    def expects(self) -> dict:
        return {
            x1: 0x80000400,
            x2: 0x0000dead,
            x3: 0xffffc0de,
            x4: 0xffffdead,
        }

class SBLBUTest(Program):
    """Basic test of SB and LBU instruction."""

    def __init__(self):
        insns = [
            InstructionLUI(x2, 0xDEADC),
            InstructionADDI(x2, x2, 0x0DE),
            load_addr(DATA_ADDR, x1),
            InstructionSB(x1, x2, 0),
            InstructionSRLI(x2, x2, 8),
            InstructionSB(x1, x2, 1),
            InstructionSRLI(x2, x2, 8),
            InstructionSB(x1, x2, 2),
            InstructionSRLI(x2, x2, 8),
            InstructionSB(x1, x2, 3),
            InstructionLBU(x3, x1, 0),
            InstructionLBU(x4, x1, 1),
            InstructionLBU(x5, x1, 2),
            InstructionLBU(x6, x1, 3),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(list(flatten_list(insns)))
    
    def expects(self) -> dict:
        return {
            x1: 0x80000400,
            x2: 0x000000de,
            x3: 0xde,
            x4: 0xc0,
            x5: 0xad,
            x6: 0xde,
            x31: 0x1
        }


class SHLHUTest(Program):
    """Basic test of SH and LHU instructions."""

    def __init__(self):
        insns = [
            InstructionLUI(x2, 0xDEADC),
            InstructionADDI(x2, x2, 0x0DE),
            load_addr(DATA_ADDR, x1),
            InstructionSH(x1, x2, 0),
            InstructionSRLI(x2, x2, 16),
            InstructionSH(x1, x2, 2),
            InstructionLHU(x3, x1, 0),
            InstructionLHU(x4, x1, 2),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(list(flatten_list(insns)))

    def expects(self) -> dict:
        return {
            x1: 0x80000400,
            x2: 0x0000dead,
            x3: 0x0000c0de,
            x4: 0x0000dead,
            x31: 0x1
        }


class JALTest(Program):
    """Basic test of JAL instruction."""

    def __init__(self):
        insns = [
            InstructionADDI(x1, x0, 1),  # 0x8000_0000
            InstructionADDI(x2, x0, 2),  # 0x8000_0004
            InstructionADDI(x3, x0, 3),  # 0x8000_0008
            InstructionJAL(x10, 0x8),  # 0x8000_000c ->
            InstructionADDI(x4, x0, 4),  # 0x8000_0010   |
            InstructionADDI(x5, x0, 5),  # 0x8000_0014 <-
            InstructionADDI(x6, x0, 6),  # 0x8000_0018
            InstructionADDI(x7, x0, 7),
            InstructionADDI(x8, x0, 8),
            InstructionADDI(x9, x0, 9),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {
            0: 0,
            1: 1,
            2: 2,
            3: 3,
            10: 0x80000010,
            4: 0,
            5: 5,
            6: 6,
            7: 7,
            8: 8,
            9: 9,
        }


class JALRTest(Program):
    """Basic test of JALR instruction."""

    def __init__(self):
        insns = [
            InstructionAUIPC(x1, 0x0),  # 0x8000_0000
            InstructionADDI(x1, x1, 0),  # 0x8000_0004
            InstructionADDI(x3, x0, 3),  # 0x8000_0008
            InstructionJALR(x10, x1, 0x14),  # 0x8000_000c ->
            InstructionADDI(x4, x0, 4),  # 0x8000_0010   |
            InstructionADDI(x5, x0, 5),  # 0x8000_0014 <-
            InstructionADDI(x6, x0, 6),  # 0x8000_0018
            InstructionADDI(x7, x0, 7),
            InstructionADDI(x8, x0, 8),
            InstructionADDI(x9, x0, 9),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {
            0: 0,
            1: 0x80000000,
            3: 3,
            10: 0x80000010,
            4: 0,
            5: 5,
            6: 6,
            7: 7,
            8: 8,
            9: 9,
        }

class JALRTest2(Program):
    """Test of JALR instruction bit clearning."""

    def __init__(self):
        insns = [
            InstructionAUIPC(x1, 0x0),      # 0x8000_0000
            InstructionADDI(x3, x0, 3),     # 0x8000_0004
            InstructionJALR(x10, x1, 0x15), # 0x8000_0008 ->
            InstructionADDI(x4, x0, 4),     # 0x8000_000c   |
            InstructionADDI(x5, x0, 5),     # 0x8000_0010   |
            InstructionADDI(x6, x0, 6),     # 0x8000_0014 <-|
            InstructionADDI(x7, x0, 7),     # 0x8000_0018
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {
            1: 0x80000000,
            3: 3,
            10: 0x8000000c,
            4: 0,
            5: 0,
            6: 6,
            7: 7,
        }


class BEQTest(Program):
    """Basic test of BEQ instruction."""

    def __init__(self):
        insns = [
            InstructionADDI(x10, x0, 3),
            InstructionBEQ(x0, x10, 8),
            InstructionADDI(x1, x0, 1),
            InstructionBEQ(x1, x10, 8),
            InstructionADDI(x2, x0, 2),
            InstructionBEQ(x2, x10, 8),
            InstructionADDI(x3, x0, 3),
            InstructionBEQ(x3, x10, 8),  # ->|
            InstructionADDI(x4, x0, 4),  #   |
            InstructionBEQ(x4, x10, 8),  # <-|
            InstructionADDI(x5, x0, 5),
            InstructionADDI(x6, x0, 6),
            InstructionADDI(x7, x0, 7),
            InstructionADDI(x8, x0, 8),
            InstructionADDI(x9, x0, 9),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {0: 0, 1: 1, 2: 2, 3: 3, 4: 0, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9, 10: 3}


class BNETest(Program):
    """Basic test of BNE instruction."""

    def __init__(self):
        insns = [
            InstructionADDI(x10, x0, 3),
            InstructionBNE(x0, x0, 8),
            InstructionADDI(x1, x0, 1),
            InstructionBNE(x10, x10, 8),
            InstructionADDI(x2, x0, 2),
            InstructionBNE(x2, x2, 8),
            InstructionADDI(x3, x0, 3),
            InstructionBNE(x3, x0, 8),  # ->|
            InstructionADDI(x4, x0, 4),  #   |
            InstructionBNE(x4, x4, 8),  # <-|
            InstructionADDI(x5, x0, 5),
            InstructionADDI(x6, x0, 6),
            InstructionADDI(x7, x0, 7),
            InstructionADDI(x8, x0, 8),
            InstructionADDI(x9, x0, 9),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {0: 0, 1: 1, 2: 2, 3: 3, 4: 0, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9, 10: 3}


class BLTTest(Program):
    """Basic test of BLT instruction."""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFFFFF),  # 0x80000000
            InstructionBLT(x0, x1, 8),  # 0x80000004
            InstructionADDI(x2, x0, 2),  # 0x80000008
            InstructionADDI(x3, x0, 3),  # 0x8000000c
            InstructionBLT(x1, x0, 8),  # 0x80000010 ->|
            InstructionADDI(x4, x0, 4),  # 0x80000014   |
            InstructionADDI(x5, x0, 5),  # 0x80000018 <-|
            InstructionADDI(x6, x0, 6),  # 0x8000001c
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {1: 0xFFFFF000, 2: 2, 3: 3, 4: 0, 5: 5, 6: 6}


class BGETest(Program):
    """Basic test of BGE instruction."""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFFFFF),  # 0x80000000
            InstructionBGE(x0, x1, 8),  # 0x80000004 ->|
            InstructionADDI(x2, x0, 2),  # 0x80000008   |
            InstructionADDI(x3, x0, 3),  # 0x8000000c <-|
            InstructionBGE(x1, x0, 8),  # 0x80000010
            InstructionADDI(x4, x0, 4),  # 0x80000014
            InstructionADDI(x5, x0, 5),  # 0x80000018
            InstructionADDI(x6, x0, 6),  # 0x8000001c
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {1: 0xFFFFF000, 2: 0, 3: 3, 4: 4, 5: 5, 6: 6}


class BLTUTest(Program):
    """Basic test of BLTU instruction."""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFFFFF),  # 0x80000000
            InstructionBLTU(x0, x1, 8),  # 0x80000004 ->|
            InstructionADDI(x2, x0, 2),  # 0x80000008   |
            InstructionADDI(x3, x0, 3),  # 0x8000000c <-|
            InstructionBLTU(x1, x0, 8),  # 0x80000010
            InstructionADDI(x4, x0, 4),  # 0x80000014
            InstructionADDI(x5, x0, 5),  # 0x80000018
            InstructionADDI(x6, x0, 6),  # 0x8000001c
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {1: 0xFFFFF000, 2: 0, 3: 3, 4: 4, 5: 5, 6: 6}


class BGEUTest(Program):
    """Basic test of BGEU instruction."""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFFFFF),
            InstructionBGEU(x1, x0, 8),
            InstructionADDI(x2, x0, 2),
            InstructionADDI(x3, x0, 3),
            InstructionBGEU(x0, x1, 8),
            InstructionADDI(x4, x0, 4),
            InstructionADDI(x5, x0, 5),
            InstructionADDI(x6, x0, 6),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {1: 0xFFFFF000, 2: 0, 3: 3, 4: 4, 5: 5, 6: 6}

class MISATest(Program):
    "Basic test of CSRRW instruction. Reading the MISA register."

    def __init__(self):
        self.MISA_VALUE= (1 << 8) + (1 << 30)
        insns = [
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionCSRRW(x2, x0, misa), # rd, rs1, csr_addr
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    def expects(self) -> dict:
        return {2:self.MISA_VALUE}

class MSCRATCHTest(Program):
    "Basic test of CSRRW instructions. Save value to mscratch and read it back."

    def __init__(self):
        insns = [
            InstructionLUI (x3, 0x80000),
            InstructionADDI(x3, x3, 0x123),
            InstructionCSRRW(x0, x3, mscratch), # rd, rs1, csr_addr
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionCSRRW(x4, x0, mscratch), # rd, rs1, csr_addr
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {0:0, 3: 0x80000123, 4: 0x80000123}


class MSCRATCHTest2(Program):
    "Basic test of CSRRS instruction."

    def __init__(self):
        insns = [
            InstructionLUI (x3, 0x80000),
            InstructionADDI(x3, x3, 0x1),
            InstructionCSRRW(x0, x3, mscratch), # rd, rs1, csr_addr
            InstructionADDI(x2, x0, 2),
            InstructionCSRRS(x0, x2, mscratch),
            InstructionCSRRW(x4, x0, mscratch), # rd, rs1, csr_addr
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {0:0, 2:2, 3: 0x80000001, 4: 0x80000003}


class MSCRATCHTest3(Program):
    "Basic test of CSRRC instruction."

    def __init__(self):
        insns = [
            InstructionLUI (x3, 0x80000),
            InstructionADDI(x3, x3, 0x1),
            InstructionCSRRW(x0, x3, mscratch), # rd, rs1, csr_addr
            InstructionADDI(x2, x0, 3),
            InstructionCSRRC(x0, x2, mscratch),
            InstructionCSRRW(x4, x0, mscratch), # rd, rs1, csr_addr
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {0:0, 2:3, 3: 0x80000001, 4: 0x80000000}


class MSCRATCHTest4(Program):
    "Basic test of CSRRSI instruction."

    def __init__(self):
        insns = [
            InstructionLUI (x3, 0x80000),
            InstructionCSRRW(x0, x3, mscratch), # rd, rs1, csr_addr
            InstructionCSRRSI(x0, 0x2, mscratch), # rd, rs1, csr_addr
            InstructionCSRRW(x4, x0, mscratch), # rd, rs1, csr_addr
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {0:0, 3: 0x80000000, 4: 0x80000002}


class MSCRATCHTest5(Program):
    "Basic test of CSRRWCI instructions."

    def __init__(self):
        insns = [
            InstructionLUI (x3, 0x80000),
            InstructionADDI(x3, x3, 0x7),
            InstructionCSRRW(x0, x3, mscratch), # rd, rs1, csr_addr
            InstructionCSRRCI(x0, 1, mscratch),
            InstructionCSRRW(x4, x0, mscratch), # rd, rs1, csr_addr
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x0, 0x0),
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {0:0, 3: 0x80000007, 4: 0x80000006}


class ECALLTest(Program):
    "Basic test of an ECALL instruction."
    def __init__(self):
        insns = [
            InstructionLUI  (x28, 0x80000),     # 0x8000_0000
            InstructionADDI (x28, x28, 0x28),   # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec),   # 0x8000_0008  rd, rs1, csr_addr
            InstructionECALL(),                 # 0x8000_000c
            InstructionADDI (x2, x0, 2),        # 0x8000_0010  0x40 - 0x14 = 0x2c
            InstructionJAL  (x10, 0x2c),        # 0x8000_0014 ------------------->
            InstructionADDI (x3, x0, 3),        # 0x8000_0018                    |
            InstructionADDI (x4, x0, 4),        # 0x8000_001c                    |
            InstructionADDI (x5, x0, 5),        # 0x8000_0020                    |
            InstructionADDI (x6, x0, 6),        # 0x8000_0024                    |
            InstructionADDI (x1, x0, 1),        # 0x8000_0028 - TRAP HANDLER |   |
            InstructionCSRRS(x30, x0, mepc),    # 0x8000_002c                |   |
            InstructionADDI (x30, x30, 4),      # 0x8000_0030                |   |
            InstructionCSRRW(x0, x30, mepc),    # 0x8000_0034                |   |
            InstructionCSRRS(x29, x0, mcause),  # 0x8000_0038                |   |
            InstructionMRET (),                 # 0x8000_003c   <------------    |
            InstructionNOP  (),                 # 0x8000_0040 <-------------------
            InstructionNOP  (),                 # 0x8000_0044                
            InstructionNOP  (),                 # 0x8000_0048   
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {0:0, x1:1, x2: 2, x3: 0, x4: 0, x5:0, x6: 0, x28: 0x80000028, x29: 11}


class MSTATUSTest(Program):
    "Test the behavior of MSTATUS register. Specificaly the MIE an MIEP bits usage in ecall and mret."
    def __init__(self):
        insns = [
            InstructionCSRRS (x1, x0, mstatus),  # 0x8000_0000
            InstructionLUI   (x28, 0x80000),     # 0x8000_0004
            InstructionADDI  (x28, x28, 0x20),   # 0x8000_0008
            InstructionCSRRW (x0, x28, mtvec),   # 0x8000_000c  rd, rs1, csr_addr
            InstructionCSRRSI(x0, 0x8, mstatus), # 0x8000_0010 - set MIE
            InstructionCSRRS (x2, x0, mstatus),  # 0x8000_0014
            InstructionECALL (),                 # 0x8000_0018
            InstructionJAL   (x10, 0x18),        # 0x8000_001c  0x34 - 0x1c = 0x18 
            InstructionCSRRS (x3, x0, mstatus),  # 0x8000_0020 - TRAP HANDLER |
            InstructionCSRRS (x30, x0, mepc),    # 0x8000_0024                |
            InstructionADDI  (x30, x30, 4),      # 0x8000_0028                |
            InstructionCSRRW (x0, x30, mepc),    # 0x8000_002c                |
            InstructionMRET  (),                 # 0x8000_0030 ---------------
            InstructionCSRRS (x4, x0, mstatus),  # 0x8000_0034
            InstructionNOP   (),                 # 0x8000_0038
            InstructionNOP   (),                 # 0x8000_003c
            InstructionNOP   (),                 # 0x8000_0040
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)
    
    def expects(self) -> dict:
        MPP = (1 << 11) + (1 << 12)
        return {x1: (0 + MPP), x2: (8 + MPP), x3: ((1 << 7) + MPP), x4: (8 + (1 << 7) + MPP)}


class MISALIGNEDLWTest(Program):
        """
            Test that an exception is triggered on an unaligned memory load.
            x31 - trap address
            x2  - store base address = 0x8000_0402
            x1  - 0xDEADC0DE
            x3  - unaligned load destination addr
            x4  - mstatus value
            x5  - mepc
            x6  - mtval
            x7  - loading

            0x6000_0000 |
            0x6000_0001 |
            0x6000_0002 | 0xDE
            0x6000_0003 | 0xAD
            0x6000_0004 | 0xC0
            0x6000_0005 | 0xDE
            0x6000_0006 |

        """
        def __init__(self):
            insns = [
                InstructionLUI  (x28, 0x80000),    # 0x8000_0000
                InstructionADDI (x28, x28, 0x40),  # 0x8000_0004
                InstructionCSRRW(x0, x28, mtvec),  # 0x8000_0008
                InstructionLUI  (x2, 0x80000),     # 0x8000_000c
                InstructionADDI (x2, x2, 0x402),   # 0x8000_0010
                InstructionLUI  (x1, 0xDEADC),     # 0x8000_0014
                InstructionADDI (x1, x1, 0x0DE),   # 0x8000_0018
                InstructionSB   (x2, x1, 3),       # 0x8000_001c
                InstructionSRLI (x1, x1, 8),       # 0x8000_0020
                InstructionSB   (x2, x1, 2),       # 0x8000_0024
                InstructionSRLI (x1, x1, 8),       # 0x8000_0028
                InstructionSB   (x2, x1, 1),       # 0x8000_002c
                InstructionSRLI (x1, x1, 8),       # 0x8000_0030
                InstructionSB   (x2, x1, 0),       # 0x8000_0034
                InstructionLW   (x3, x2, 0),       # 0x8000_0038
                InstructionJAL  (x0, 0x48),        # 0x8000_003c --------------------
                InstructionCSRRS(x4, x0, mstatus), # 0x8000_0040 -- TRAP HANDLER |  |
                InstructionCSRRS(x5, x0, mepc),    # 0x8000_0044                 |  |
                InstructionADDI (x5, x5, 4),       # 0x8000_0048                 |  |
                InstructionCSRRW(x0, x5, mepc),    # 0x8000_004c                 |  |
                InstructionCSRRW(x6, x0, mtval),   # 0x8000_0050                 |  |
                InstructionLBU  (x7, x6, 0),       # 0x8000_0054                 |  |
                InstructionSLLI (x7, x7, 8),       # 0x8000_0058                 |  |
                InstructionLBU  (x8, x6, 1),       # 0x8000_005c                 |  |
                InstructionXOR  (x7, x7, x8),      # 0x8000_0060                 |  |
                InstructionSLLI (x7, x7, 8),       # 0x8000_0064                 |  |
                InstructionLBU  (x8, x6, 2),       # 0x8000_0068                 |  |
                InstructionXOR  (x7, x7, x8),      # 0x8000_006c                 |  |
                InstructionSLLI (x7, x7, 8),       # 0x8000_0070                 |  |
                InstructionLBU  (x8, x6, 3),       # 0x8000_0074                 |  |
                InstructionXOR  (x7, x7, x8),      # 0x8000_0078                 |  |
                InstructionMRET (),                # 0x8000_007c  <---------------  |
                InstructionADDI (x9, x0, 1),       # 0x8000_0080                    |
                InstructionNOP  (),                # 0x8000_0084 <------------------|
                InstructionNOP  (),                # 0x8000_0088
                InstructionNOP  (),                # 0x8000_008c
                InstructionADDI(x31, x0, 1)
            ]
            super().__init__(insns)

        def expects(self) -> dict:
            return {x0:0, x5: 0x8000003c, x6: 0x80000402, x7: 0xDEADC0DE, x9: 0}
        

class MISALIGNEDJALTest(Program):
    """
            Test that an exception is triggered on an unaligned jump.
    """
    def __init__(self):
        insns = [
            InstructionLUI  (x28, 0x80000),    # 0x8000_0000
            InstructionADDI (x28, x28, 0x18),  # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec),  # 0x8000_0008
            InstructionJAL  (x3, 0xa),         # 0x8000_000c
            InstructionADDI (x1, x0, 0x1),     # 0x8000_0010
            InstructionJAL  (x0, 0x20),        # 0x8000_0014 --------------------
            InstructionCSRRS(x4, x0, mstatus), # 0x8000_0018 -- TRAP HANDLER |  |
            InstructionCSRRS(x5, x0, mepc),    # 0x8000_001c                 |  |
            InstructionADDI (x5, x5, 4),       # 0x8000_0020                 |  |
            InstructionCSRRW(x0, x5, mepc),    # 0x8000_0024                 |  |
            InstructionCSRRW(x6, x0, mtval),   # 0x8000_0028                 |  |
            InstructionMRET (),                # 0x8000_002c  <---------------  |
            InstructionADDI (x2, x0, 1),       # 0x8000_0030                    |
            InstructionADDI (x7, x0, 1),       # 0x8000_0034 <------------------|
            InstructionNOP  (),                # 0x8000_0038
            InstructionNOP  (),                # 0x8000_003c
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {x0:0, x1: 1, x2:0, x3: 0, x5:0x80000010, x6:0x80000016, x7:1}


class CSRWriteFaultTest(Program):
    "Test behavior on write to a non-existant CSR register."
    def __init__(self):
        insns = [
            InstructionLUI  (x28, 0x80000),     # 0x8000_0000
            InstructionADDI (x28, x28, 0x28),   # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec),   # 0x8000_0008  rd, rs1, csr_addr
            InstructionCSRRW(x0, x0,  0x000),   # 0x8000_000c  # illegal write 
            InstructionADDI (x2, x0, 2),        # 0x8000_0010  0x40 - 0x14 = 0x2c
            InstructionJAL  (x10, 0x2c),        # 0x8000_0014 ------------------->
            InstructionADDI (x3, x0, 3),        # 0x8000_0018                    |
            InstructionADDI (x4, x0, 4),        # 0x8000_001c                    |
            InstructionADDI (x5, x0, 5),        # 0x8000_0020                    |
            InstructionADDI (x6, x0, 6),        # 0x8000_0024                    |
            InstructionADDI (x1, x0, 1),        # 0x8000_0028 - TRAP HANDLER |   |
            InstructionCSRRS(x30, x0, mepc),    # 0x8000_002c                |   |
            InstructionADDI (x30, x30, 4),      # 0x8000_0030                |   |
            InstructionCSRRW(x0, x30, mepc),    # 0x8000_0034                |   |
            InstructionCSRRS(x29, x0, mcause),  # 0x8000_0038                |   |
            InstructionMRET (),                 # 0x8000_003c   <------------    |
            InstructionNOP  (),                 # 0x8000_0040 <-------------------
            InstructionNOP  (),                 # 0x8000_0044                
            InstructionNOP  (),                 # 0x8000_0048   
            InstructionADDI(x31, x0, 1)
        ]
        super().__init__(insns)

    def expects(self) -> dict:
        return {0:0, x1:1, x2: 2, x3: 0, x4: 0, x5:0, x6: 0, x28: 0x80000028, x29: 2}


class InsnAccFaultPreciseTest(Program):
    "Assumes! a 256 word long memory (256*4 = 0x400)."
    def __init__(self):
        insns = [
            InstructionLUI(x28, 0x80000),     # 0x8000_0000
            InstructionADDI(x28, x28, 0x10),  # 0x8000_0004
            InstructionCSRRW(x0, x28, mtvec), # 0x8000_0008
            InstructionJAL(x0, (249 * 4)),    # 0x8000_000c ---------------------->
            InstructionADDI(x4, x0 , 5),      # 0x8000_0010 <- TRAP               |
            InstructionCSRRW(x5, x0, mcause), # 0x8000_0014
            InstructionADDI(x31, x0, 1),      # 0x8000_0018 (finish test)         |
            (245 * [InstructionNOP()]),       # 0x8000_001c                       |
            InstructionADDI(x1, x0, 1),       # 0x8000_03f0 <----------------------
            InstructionADDI(x2, x0, 2),       # 0x8000_03f4
            InstructionADDI(x3, x0, 3),       # 0x8000_03f8
            InstructionADDI(x4, x0, 4)        # 0x8000_03fc
        ]
        super().__init__(list(flatten_list(insns)))

    def expects(self) -> dict:
        return {x1: 1, x2: 2, x3: 3, x4: 5, x5: 1}


RV32I_TESTS = {
    "lui": LUITest(),
    "auipc": AUIPCTest(),
    "addi": ADDITest(),
    "slti": SLTITest(),
    "sltiu": SLTIUTest(),
    "xori": XORITest(),
    "ori": ORITest(),
    "andi": ANDITest(),
    "slli": SLLITest(),
    "srli": SRLITest(),
    "srai": SRAITest(),
    "add": ADDTest(),
    "sub": SUBTest(),
    "sll": SLLTest(),
    "slt": SLTTest(),
    "sltu": SLTUTest(),
    "xor": XORTest(),
    "srl": SRLTest(),
    "sra": SRATest(),
    "ort": ORTest(),
    "andt": ANDTest(),
    "sblb": SBLBTest(),
    "swlw": SWLWTest(),
    "swlw2": SWLWTest2(),
    "shlh": SHLHTest(),
    "sblbu": SBLBUTest(),
    "shlhu": SHLHUTest(),
    "jal": JALTest(),
    "jalr": JALRTest(),
    "jalr2": JALRTest2(),
    "beq": BEQTest(),
    "bne": BNETest(),
    "blt": BLTTest(),
    "bge": BGETest(),
    "bltu": BLTUTest(),
    "bgeu": BGEUTest(),
    "misa": MISATest(),
    "mscratch": MSCRATCHTest(),
    "mscratch2": MSCRATCHTest2(),
    "mscratch3": MSCRATCHTest3(),
    "mscratch4": MSCRATCHTest4(),
    "mscratch5": MSCRATCHTest5(),
    "ecall": ECALLTest(),
    "mstatus": MSTATUSTest(),
    "misaligned-lw": MISALIGNEDLWTest(),
    "misaligned-jal": MISALIGNEDJALTest(),
    "csr-write-fault": CSRWriteFaultTest(),
    "precise-insn-acc-fault": InsnAccFaultPreciseTest(),
}
