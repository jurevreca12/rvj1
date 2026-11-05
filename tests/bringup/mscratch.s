    .section .text
    .globl _start
_start:
    lui  x3, 0x80000
    addi x3, x3, 0x123
    csrw mscratch, x3
    nop
    nop
    csrr x4, mscratch
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
