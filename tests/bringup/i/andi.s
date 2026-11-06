    .section .text
    .globl _start
_start:
    andi x1,  x0, 0x7FF
    andi x2,  x1, 0x7FF
    andi x3,  x1, 0x001
    andi x4,  x1, -0x800
    addi x31, x0, 1
_end:
    j _end
