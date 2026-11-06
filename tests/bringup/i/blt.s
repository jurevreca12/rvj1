    .section .text
    .globl _start
_start:
    lui  x1, 0xFFFFF
    blt  x0, x1, 8
    addi x2, x0, 2
    addi x3, x0, 3
    blt  x1, x0, 8
    addi x4, x0, 4
    addi x5, x0, 5
    addi x6, x0, 6
    addi x31, x0, 1
_end:
    j _end
