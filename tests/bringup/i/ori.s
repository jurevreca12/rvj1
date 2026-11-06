    .section .text
    .globl _start
_start:
    ori x1, x0, 0x7FF
    ori x2, x1, 0x001
    ori x3, x0, -0x800
    addi x31, x0, 1
_end:
    j _end
