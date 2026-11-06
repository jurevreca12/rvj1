    .section .text
    .globl _start
_start:
    lui   x3, 0x80000
    csrw  mscratch, x3
    csrsi mscratch, 0x2
    csrr  x4, mscratch
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
