    .section .text
    .globl _start
_start:
    lui  x1, 0xFFFFF
    bge  x0, x1, br0
    addi x2, x0, 2
br0:
    addi x3, x0, 3
    bge  x1, x0, br1
    addi x4, x0, 4
br1:
    addi x5, x0, 5
    addi x6, x0, 6
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{1: 0xFFFFF000, 2: 0, 3: 3, 4: 4, 5: 5, 6: 6}"