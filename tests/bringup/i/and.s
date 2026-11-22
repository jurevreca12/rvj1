    .section .text
    .globl _start
_start:
    lui  x1, 0xFEBED
    addi x1, x1, 0x123
    lui  x2, 0xDEADB
    addi x2, x2, 0x234
    addi x3, x0, 1234
    and x4, x1, x2
    and x5, x2, x1
    and x6, x1, x0
    and x7, x2, x3
    and x8, x2, x1
    and x9, x1, x3
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{
            1: 0xfebed123,
            2: 0xdeadb234,
            3: 0x000004d2,
            4: 0xdeac9020,
            5: 0xdeac9020,
            6: 0x0,
            7: 0x00000010,
            8: 0xdeac9020,
            9: 0x2
    }"