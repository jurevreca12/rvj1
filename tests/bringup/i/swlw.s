    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC
    addi x2, x2, 0x0DE
    la   x1, _data
    sw   x2, (x1)
    lw   x3, (x1)
    lw   x4, (x1)
    addi x31, x0, 1
_end:
    j _end
    .section .data
_data: 
    .word 0x0
    .section .rodata
    .ascii "{
            1: 0x80000400,
            2: 0xdeadc0de,
            3: 0xdeadc0de,
            4: 0xdeadc0de,
            31: 0x1
        }"
