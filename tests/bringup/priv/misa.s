    .section .text
    .globl _start
_start:
    nop
    nop
    nop
    csrr x2, misa
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
