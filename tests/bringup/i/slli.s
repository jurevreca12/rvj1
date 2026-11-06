    .section .text
    .globl _start
_start:
    lui  x1, 0xFEBED
    slli x2, x1, 12
    slli x3, x1, 2
    slli x4, x3, 10
    addi x31, x0, 1
_end:
    j _end
