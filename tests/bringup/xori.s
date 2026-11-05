    .section .text
    .globl _start
_start:
    xori x1, x0, 0x7FF
    xori x2, x1, 0x001
    xori x3, x0, -0x800
    addi x31, x0, 1
_end:
    j _end
