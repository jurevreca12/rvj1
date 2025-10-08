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
)
from riscvmodel.regnames import x0, x1, x2, x3, x4, x5, x6, x7, x8, x9
from riscvmodel.program import Program


class LUITest(Program):
    """Basic test of LUI instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0),
            InstructionLUI(x2, 1),
            InstructionLUI(x3, 0x80000),
            InstructionLUI(x4, 0xFFFFF),
            InstructionLUI(x0, 0xFFFFF),
        ]
        super().__init__(insns)


class AUIPCTest(Program):
    """Basic test of AUIPC instruction"""

    def __init__(self):
        insns = [
            InstructionAUIPC(x1, 0),
            InstructionAUIPC(x2, 1),
            InstructionAUIPC(x3, 0x80000),
            InstructionAUIPC(x4, 0xFFFFF),
            InstructionAUIPC(x0, 0xFFFFF),
        ]
        super().__init__(insns)


class ADDITest(Program):
    """Basic test of ADDI instruction"""

    def __init__(self):
        insns = [
            InstructionADDI(x1, x0, x0),
            InstructionADDI(x1, x1, 1),
            InstructionADDI(x2, x1, -2),
        ]
        super().__init__(insns)


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
        ]
        super().__init__(insns)


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
        ]
        super().__init__(insns)


class XORITest(Program):
    """Basic test of XORI instruction"""

    def __init__(self):
        insns = [
            InstructionXORI(x1, x0, 0x7FF),
            InstructionXORI(x2, x1, 0x001),
            InstructionXORI(x3, x0, -0x800),
        ]
        super().__init__(insns)


class ORITest(Program):
    """Basic test of ORI instruction"""

    def __init__(self):
        insns = [
            InstructionORI(x1, x0, 0x7FF),
            InstructionORI(x2, x1, 0x001),
            InstructionORI(x3, x0, -0x800),
        ]
        super().__init__(insns)


class ANDITest(Program):
    """Basic test of ANDI instruction"""

    def __init__(self):
        insns = [
            InstructionANDI(x1, x0, 0x7FF),
            InstructionANDI(x2, x1, 0x001),
            InstructionANDI(x3, x0, -0x800),
        ]
        super().__init__(insns)


class SLLITest(Program):
    """Basic test of SLLI instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionSLLI(x2, x1, 12),
            InstructionSLLI(x3, x1, 2),
            InstructionSLLI(x4, x3, 10),
        ]
        super().__init__(insns)


class SRLITest(Program):
    """Basic test of SRLI instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionSRLI(x2, x1, 12),
            InstructionSRLI(x3, x1, 2),
            InstructionSRLI(x4, x3, 10),
        ]
        super().__init__(insns)


class SRAITest(Program):
    """Basic test of SRAI instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionSRAI(x2, x1, 12),
            InstructionSRAI(x3, x1, 2),
            InstructionSRAI(x4, x3, 10),
        ]
        super().__init__(insns)


class ADDTest(Program):
    """Basic test of ADD instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionADD(x2, x0, x1),
            InstructionADD(x3, x1, x1),
        ]
        super().__init__(insns)


class SUBTest(Program):
    """Basic test of SUB instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionSUB(x2, x0, x1),
            InstructionSUB(x3, x1, x1),
        ]
        super().__init__(insns)


class SLLTest(Program):
    """Basic test of SLL instruction"""

    def __init__(self):
        insns = [
            InstructionLUI(x1, 0xFEBED),
            InstructionSLL(x2, x1, x1),
            InstructionORI(x3, x0, 7),
            InstructionSLL(x4, x1, x3),
        ]
        super().__init__(insns)


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
        ]
        super().__init__(insns)


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
        ]
        super().__init__(insns)


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
        ]
        super().__init__(insns)


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
        ]
        super().__init__(insns)


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
        ]
        super().__init__(insns)


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
        ]
        super().__init__(insns)


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
        ]
        super().__init__(insns)


class SBLBTest(Program):
    """Basic test of LB instruction."""

    def __init__(self):
        insns = [
            InstructionLUI(x2, 0xDEADC),
            InstructionADDI(x2, x2, 0x0DE),
            InstructionLUI(x1, 0x60000),
            InstructionSB(x1, x2, 0),
            InstructionSRLI(x2, x2, 8),
            InstructionSB(x1, x2, 1),
            InstructionSRLI(x2, x2, 8),
            InstructionSB(x1, x2, 2),
            InstructionSRLI(x2, x2, 8),
            InstructionSB(x1, x2, 3),
            InstructionLB(x3, x2, 0),
            InstructionLB(x4, x2, 1),
            InstructionLB(x5, x2, 2),
            InstructionLB(x6, x2, 3),
        ]
        super().__init__(insns)


RV32ITests = [
    LUITest,
    AUIPCTest,
    ADDITest,
    SLTITest,
    SLTIUTest,
    XORITest,
    ORITest,
    ANDITest,
    SLLITest,
    SRLITest,
    SRAITest,
    ADDTest,
    SUBTest,
    SLLTest,
    SLTTest,
    SLTUTest,
    XORTest,
    SRLTest,
    SRATest,
    ORTest,
    ANDTest,
    SBLBTest,
]
