    .section .text
    .globl _start
_start:
    lui  x1, 0xFEBED
    addi x1, x1, 0x123
    lui  x2, 0xDEADB
    addi x2, x2, 0x234
    addi x3, x0, 1234
    sra x4, x1, x2
    sra x5, x2, x1
    sra x6, x1, x0
    sra x7, x2, x3
    sra x8, x2, x1
    sra x9, x1, x3
    addi x31, x0, 1
_end:
    j _end
