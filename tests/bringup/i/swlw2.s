# A tougher test of SW and LW instructions. This test has many consecutive 
# store and load instructions. The goal of this test is to try to congest the 
# load/store buffers and see if the control logic correctly stalls the pipeline.
    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC
    addi x2, x2, 0x0DE
    la   x1, _data
    sw   x2, 0(x1)
    sw   x2, 4(x1)
    sw   x2, 8(x1)
    sw   x2, 12(x1)
    sw   x2, 16(x1)
    sw   x2, 20(x1)
    nop
    lw   x3, 0(x1)
    lw   x4, 4(x1)
    lw   x5, 8(x1)
    lw   x6, 12(x1)
    lw   x7, 16(x1)
    lw   x8, 20(x1)
    addi x31, x0, 1
_end:
    j _end

    .section .data
_data: .word 0x0
