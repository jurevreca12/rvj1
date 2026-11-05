    .section .text
    .globl _start
_start:
    sltiu x1, x0, 0
    sltiu x2, x1, 0
    sltiu x3, x0, 1
    sltiu x4, x3, 1
    lui   x5, 0x80000
    sltiu x6, x5, 0
    addi x31, x0, 1
_end:
    j _end
