    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC     # 0x8000_0000
    addi x2, x2, 0x0DE   # 0x8000_0004
    la   x1, _data       # 0x8000_0008
    sw   x2, (x1)        # 0x8000_0010
    lw   x3, (x1)        # 0x8000_0014
    lw   x4, (x1)        # 0x8000_0018
    addi x31, x0, 1      # 0x8000_001c
_end:
    j _end               # 0x8000_0020
    .section .data
_data: 
    .section .rodata
    .ascii "{
            2: 0xdeadc0de,
            3: 0xdeadc0de,
            4: 0xdeadc0de,
            31: 0x1
        }"
