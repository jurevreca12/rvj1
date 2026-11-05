# A tougher test of SW and LW instructions. This test has many consecutive 
# store and load instructions. The goal of this test is to try to congest the 
# load/store buffers and see if the control logic correctly stalls the pipeline.
    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC
    addi x2, x2, 0x0DE
    la   x1, _data
    sw   x1, x2, 0
    sw   x1, x2, 4
    sw   x1, x2, 8
    sw   x1, x2, 12
    sw   x1, x2, 16
    sw   x1, x2, 20
    nop
    lw   x3, x1, 0
    lw   x4, x1, 4
    lw   x5, x1, 8
    lw   x6, x1, 12
    lw   x7, x1, 16
    lw   x8, x1, 20
    addi x31, x0, 1
_end:
    j _end

    .section .data
_data: .word 0x0
