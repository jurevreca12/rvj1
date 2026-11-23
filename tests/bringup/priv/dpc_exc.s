# Test that accessing debug PC outside of debug mode raises an exception.
    .section .text
    .globl _start
_start:
    la    x28, trap_vec
    csrw  mtvec, x28
    addi  x1, x0, 1
    addi  x2, x0, 2
    addi  x3, x0, 3
    csrw  dpc, x1
    addi  x4, x0, 4
trap_vec:
    addi  x5, x0, 5
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{1: 1, 2: 2, 3: 3, 4: 0, 5:5}"