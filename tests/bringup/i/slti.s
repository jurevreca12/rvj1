    .section .text
    .globl _start
_start:
    slti x1, x0, 0
    slti x2, x1, 0
    slti x3, x0, 1
    slti x4, x3, 1
    lui  x5, 0x80000
    slti x6, x5, 0
    addi x31, x0, 1
_end:
    j _end
