    .section .text
    .globl _start
_start:
    auipc x1, 0x0
    addi  x1, x1, 0
    addi  x3, x0, 3
    jalr  x10, x1, 0x14
    addi  x4, x0, 4
    addi  x5, x0, 5
    addi  x6, x0, 6
    addi  x7, x0, 7
    addi  x8, x0, 8
    addi  x9, x0, 9
    addi x31, x0, 1
_end:
    j _end
