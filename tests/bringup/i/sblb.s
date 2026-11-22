    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC     # 0x8000_0000
    addi x2, x2, 0x0DE   # 0x8000_0004
    la   x1, _data       # 0x8000_0008
    sb   x2, (x1)        # 0x8000_0010
    srli x2, x2, 8       # 0x8000_0014
    sb   x2, 1(x1)       # 0x8000_0018
    srli x2, x2, 8       # 0x8000_001c
    sb   x2, 2(x1)       # 0x8000_0020
    srli x2, x2, 8       # 0x8000_0024
    sb   x2, 3(x1)       # 0x8000_0028
    lb   x3, (x1)        # 0x8000_002c
    lb   x4, 1(x1)       # 0x8000_0030
    lb   x5, 2(x1)       # 0x8000_0034
    lb   x6, 3(x1)       # 0x8000_0038
    addi x31, x0, 1      # 0x8000_003c
_end:
    j _end               # 0x8000_0040
    .section .data
_data: 
    .word 0x0
    .section .rodata
    .ascii "{
            1: 0x80000044,
            2: 0x000000de,
            3: 0xffffffde,
            4: 0xffffffc0,
            5: 0xffffffad,
            6: 0xffffffde,
            31: 0x1
        }"
