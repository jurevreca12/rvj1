    .section .text
    .globl _start
_start:
    lui x1, 0xFEBED
    sll x2, x1, x1
    ori x3, x0, 7
    sll x4, x1, x3
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{
            1: 0xfebed000, 
            2: 0xfebed000, 
            3: 0x00000007, 
            4: 0x5f680000
        }"