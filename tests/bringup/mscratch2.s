    .section .text
    .globl _start
_start:
    lui  x3, 0x80000
    addi x3, x3, 0x1
    csrw mscratch, x3
    addi x2, x0, 2
    csrs mscratch, x2
    csrr x4, mscratch
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
