    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC
    addi x2, x2, 0x0DE
    la   x1, _data
    sb   x2, (x1)
    srli x2, x2, 8
    sb   x2, 1(x1)
    srli x2, x2, 8
    sb   x2, 2(x1)
    srli x2, x2, 8
    sb   x2, 3(x1)
    lbu  x3, 0(x1)
    lbu  x4, 1(x1)
    lbu  x5, 2(x1)
    lbu  x6, 3(x1)
    addi x31, x0, 1
_end:
    j _end

    .section .data
_data: .word 0x0
