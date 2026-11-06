    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC
    addi x2, x2, 0x0DE
    la   x1, _data
    sb   x1, x2, 0
    srli x2, x2, 8
    sb   x1, x2, 1
    srli x2, x2, 8
    sb   x1, x2, 2
    srli x2, x2, 8
    sb   x1, x2, 3
    lb   x3, x1, 0
    lb   x4, x1, 1
    lb   x5, x1, 2
    lb   x6, x1, 3
    addi x31, x0, 1
_end:
    j _end

    .section .data
_data: .word 0x0
