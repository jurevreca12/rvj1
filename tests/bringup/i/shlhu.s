    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC
    addi x2, x2, 0x0DE
    la   x1, _data
    sh   x1, x2, 0
    srli x2, x2, 16
    sh   x1, x2, 2
    lhu  x3, x1, 0
    lhu  x4, x1, 2
    addi x31, x0, 1
_end:
    j _end

    .section .data
_data: .word 0x0
