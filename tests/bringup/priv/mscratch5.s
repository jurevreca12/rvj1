    .section .text
    .globl _start
_start:
    lui   x3, 0x80000
    addi  x3, x3, 0x7
    csrw  mscratch, x3
    csrci mscratch, 0x1
    csrr  x4, mscratch
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{3: 0x80000007, 4: 0x80000006}"