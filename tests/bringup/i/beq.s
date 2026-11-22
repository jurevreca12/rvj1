    .section .text
    .globl _start
_start:
    addi x10, x0, 3
    beq  x0,  x10, br0
    addi x1, x0, 1
br0:
    beq  x1, x10, br1
    addi x2, x0, 2
br1:
    beq  x2, x10, br2
    addi x3, x0, 3
br2:
    beq  x3, x10, br3
    addi x4, x0, 4
br3:
    beq  x4, x10, br4
    addi x5, x0, 5
br4:
    addi x6, x0, 6
    addi x7, x0, 7
    addi x8, x0, 8
    addi x9, x0, 9
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{0: 0, 1: 1, 2: 2, 3: 3, 4: 0, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9, 10: 3}"