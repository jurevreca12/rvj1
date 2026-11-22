    .section .text
    .globl _start
_start:
    lui   x29, 0x80000      # 0x8000_0000
    addi  x28, x29, 0x18    # 0x8000_0004
    csrw  mtvec, x28        # 0x8000_0008
    jalr  x3, x29, 0xa      # 0x8000_000c - unaligned jump
    addi  x1, x0, 0x1       # 0x8000_0010
    jal   x0, cleanup       # 0x8000_0014
    csrr  x4, mstatus       # 0x8000_0018 <- mtvec
    csrr  x5, mepc          # 0x8000_001c
    addi  x5, x5, 4         # 0x8000_0020
    csrw  mepc, x5          # 0x8000_0024
    csrr  x6, mtval         # 0x8000_0028
    mret                    # 0x8000_002c
    addi x2, x0, 1          # 0x8000_0030
cleanup:
    addi x7, x0, 1          # 0x8000_0034
    nop                     # 0x8000_0038
    nop                     # 0x8000_003c
    addi x31, x0, 1         # 0x8000_0040
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{1: 1, 2:0, 5:0x80000010, 6:0x8000000a, 7:1}"