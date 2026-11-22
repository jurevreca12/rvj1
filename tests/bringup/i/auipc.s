    .section .text
    .globl _start
_start:
    auipc x1, 0x0
    auipc x2, 0x1
    auipc x3, 0x80000
    auipc x4, 0xFFFFF
    auipc x0, 0xFFFFF
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{1: 0x8000_0000, 2: 0x8000_1004, 3: 0x8, 4: 0x7ffff00c}"