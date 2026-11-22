# Test of JALR instruction bit clearing.
    .section .text
    .globl _start
_start:
    addi x5, x0, 0        # 0x8000_0000
    auipc x1, 0x0         # 0x8000_0004
    addi  x3, x0, 3       # 0x8000_0008
    jalr  x10, x1, 0x15   # 0x8000_000c
    addi x4, x0, 4        # 0x8000_0010
    addi x5, x0, 5        # 0x8000_0014
    addi x6, x0, 6        # 0x8000_0018
    addi x7, x0, 7        # 0x8000_001c
    addi x31, x0, 1       # 0x8000_0020
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{
            1: 0x80000004,
            3: 3,
            10: 0x80000010,
            4: 0,
            5: 0,
            6: 6,
            7: 7,
        }
