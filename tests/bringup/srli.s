    .section .text
    .globl _start
_start:
    lui  x1, 0xFEBED
    srli x2, x1, 12
    srli x3, x1, 2
    srli x4, x3, 10
    addi x31, x0, 1
_end:
    j _end
