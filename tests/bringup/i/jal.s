    .section .text
    .globl _start
_start:
    addi x5, x0, 0     # 0x8000_0000
    addi x1, x0, 1     # 0x8000_0004
    addi x2, x0, 2     # 0x8000_0008
    addi x3, x0, 3     # 0x8000_000c
    jal  x10, target   # 0x8000_0010
    addi x4, x0, 4     # 0x8000_0014
    addi x5, x0, 5     # 0x8000_0018
target:
    addi x6, x0, 6     # 0x8000_001c
    addi x7, x0, 7     # 0x8000_0020
    addi x8, x0, 8     # 0x8000_0024
    addi x9, x0, 9     # 0x8000_0028
    addi x31, x0, 1    # 0x8000_002c
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{1: 1, 2:2, 3: 3, 4:0, 5:0, 6:6, 7:7, 8:8, 9:9}"