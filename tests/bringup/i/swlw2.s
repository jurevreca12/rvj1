# A tougher test of SW and LW instructions. This test has many consecutive 
# store and load instructions. The goal of this test is to try to congest the 
# load/store buffers and see if the control logic correctly stalls the pipeline.
    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC    # 0x8000_0000
    addi x2, x2, 0x0DE  # 0x8000_0004
    la   x1, _data      # 0x8000_0008
    sw   x2, 0(x1)      # 0x8000_0010
    sw   x2, 4(x1)      # 0x8000_0014
    sw   x2, 8(x1)      # 0x8000_0018
    sw   x2, 12(x1)     # 0x8000_001c
    sw   x2, 16(x1)     # 0x8000_0020
    sw   x2, 20(x1)     # 0x8000_0024
    nop                 # 0x8000_0028
    lw   x3, 0(x1)      # 0x8000_002c
    lw   x4, 4(x1)      # 0x8000_0030
    lw   x5, 8(x1)      # 0x8000_0034
    lw   x6, 12(x1)     # 0x8000_0038
    lw   x7, 16(x1)     # 0x8000_003c
    lw   x8, 20(x1)     # 0x8000_0040
    addi x31, x0, 1     # 0x8000_0044
_end:
    j _end              # 0x8000_0048
    .section .data
_data: 
    .section .rodata
    .ascii "{
            1: 0x8000004c,
            2: 0xdeadc0de,
            3: 0xdeadc0de,
            4: 0xdeadc0de,
            5: 0xdeadc0de,
            6: 0xdeadc0de,
            7: 0xdeadc0de,
            8: 0xdeadc0de,
        }"