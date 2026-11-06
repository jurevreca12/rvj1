    .section .text
    .globl _start
_start:
    addi x1, x0, 1
    addi x2, x0, -1
    addi x3, x0, 55
    sltu x4, x3, x2
    sltu x5, x3, x1
    sltu x6, x1, x2
    sltu x7, x2, x3
    sltu x8, x1, x3
    addi x31, x0, 1
_end:
    j _end
