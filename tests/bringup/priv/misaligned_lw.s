# Test that an exception is triggered on an unaligned memory load.
    .section .text
    .globl _start
_start:
    la    x28, trap_vec   # 0x8000_0000
    csrw  mtvec, x28      # 0x8000_0008
    la    x2, _data       # 0x8000_000c
    addi  x2, x2, 2       # 0x8000_0014
    li    x1, 0xDEADC0DE  # 0x8000_0018
    sb    x1, 3(x2)       # 0x8000_0020
    srli  x1, x1, 8       # 0x8000_0024
    sb    x1, 2(x2)       # 0x8000_0028
    srli  x1, x1, 8       # 0x8000_002c
    sb    x1, 1(x2)       # 0x8000_0030
    srli  x1, x1, 8       # 0x8000_0034
    sb    x1, (x2)        # 0x8000_0038
    lw    x3, (x2)        # 0x8000_003c
    jal   x0, cleanup     # 0x8000_0040
trap_vec:
    csrr  x4, mstatus     # 0x8000_0044
    csrr  x5, mepc        # 0x8000_0048
    addi  x5, x5, 4       # 0x8000_004c
    csrw  mepc, x5        # 0x8000_0050
    csrr  x6, mtval       # 0x8000_0054
    lbu   x7, (x6)        # 0x8000_0058
    slli  x7, x7, 8       # 0x8000_005c
    lbu   x8, 1(x6)       # 0x8000_0060
    xor   x7, x7, x8      # 0x8000_0064
    slli  x7, x7, 8       # 0x8000_0068
    lbu   x8, 2(x6)       # 0x8000_006c
    xor   x7, x7, x8      # 0x8000_0070
    slli  x7, x7, 8       # 0x8000_0074
    lbu   x8, 3(x6)       # 0x8000_0078
    xor   x7, x7, x8      # 0x8000_007c
    mret                  # 0x8000_0080
    addi  x9, x0, 1       # 0x8000_0084
cleanup:
    nop                   # 0x8000_0088
    nop                   # 0x8000_008c
    nop                   # 0x8000_0090
    addi x31, x0, 1       # 0x8000_0094
_end:
    j _end                # 0x8000_0098
_data:
    .section .data
    .word 0x0             # 0x8000_009c
    .word 0x0             # 0x8000_00a0
    .section .rodata
    .ascii "{0:0, 5: 0x80000040, 6: 0x8000009e, 7: 0xDEADC0DE, 9: 0}"
