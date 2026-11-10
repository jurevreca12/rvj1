    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC
    addi x2, x2, 0x0DE
    la   x1, _data
    sh   x2, (x1)
    srli x2, x2, 16
    sh   x2, 2(x1)
    lh   x3, (x1)
    lh   x4, 2(x1)
    addi x31, x0, 1
_end:
    j _end

    .section .data
_data: .word 0x0
