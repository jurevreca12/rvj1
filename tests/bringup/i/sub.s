    .section .text
    .globl _start
_start:
    lui  x1,  0xFEBED
    sub  x2,  x0, x1
    sub  x3,  x1, x1
    addi x31, x0, 1
_end:
    j _end
