    .section .text
    .globl _start
_start:
    addi x10, x0, 3
    beq  x0,  x10, 8
    addi x1, x0, 1
    beq  x1, x10, 8
    addi x2, x0, 2
    beq  x2, x10, 8
    addi x3, x0, 3
    beq  x3, x10, 8
    addi x4, x0, 4
    beq  x4, x10, 8
    addi x5, x0, 5
    addi x6, x0, 6
    addi x7, x0, 7
    addi x8, x0, 8
    addi x9, x0, 9
    addi x31, x0, 1
_end:
    j _end
