    .section .text
    .globl _start
_start:
    addi x10, x0, 3
    bne  x0,  x0, br0
    addi x1,  x0, 1
br0:
    bne  x10, x10, br1
    addi x2,  x0, 2
br1:
    bne  x2, x2, br2
    addi x3, x0, 3
br2:
    bne  x3, x0, br3
    addi x4, x0, 4
br3:
    bne  x4, x4, br4
    addi x5, x0, 5
br4:
    addi x6, x0, 6
    addi x7, x0, 7
    addi x8, x0, 8
    addi x9, x0, 9
    addi x31, x0, 1
_end:
    j _end
