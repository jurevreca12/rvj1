# Test that accessing debug PC outside of debug mode raises an exception.
    .section .text
    .globl _start
_start:
    lui   x28, 0x80000
    addi  x28, x28, 0x20
    csrrw x0, mtvec, x28
    addi  x1, x0, 1
    addi  x2, x0, 2
    addi  x3, x0, 3
    csrrw x0, dpc, x1
    addi  x4, x0, 4
    addi  x5, x0, 5
    addi x31, x0, 1
_end:
    j _end
