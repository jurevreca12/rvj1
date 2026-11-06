    .section .text
    .globl _start
_start:
    addi x1, x0, 0
    addi x1, x1, 2
    addi x2, x1, -1
    addi x31, x0, 1
_end:
    j _end
