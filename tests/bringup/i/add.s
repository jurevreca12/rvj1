    .section .text
    .globl _start
_start:
    lui  x1,  0xFEBED
    add  x2,  x0, x1
    add  x3,  x1, x1
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{1: 0xfebed000, 2: 0xfebed000, 3: 0xfd7da000}"

