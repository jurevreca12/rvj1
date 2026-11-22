    .section .text
    .globl _start
_start:
    lui  x1, 0xFEBED
    slli x2, x1, 12
    slli x3, x1, 2
    slli x4, x3, 10
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{
            1: 0xfebed000, 
            2: 0xed000000, 
            3: 0xfafb4000, 
            4: 0xed000000
        }"