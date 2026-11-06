# After encountering an ebreak instruction the CPU should jump to the debug ROM.
# The Debug ROM is located at 0x8000_0050
    .section .text
    .globl _start
_start:
    lui   x28, 0x80000    # 0x8000_0000
    addi  x28, x28, 0x20  # 0x8000_0004
    csrrw x0, mtvec, x28  # 0x8000_0008
    addi x1, x0, 1        # 0x8000_000c
    addi x2, x0, 2        # 0x8000_0010
    addi x3, x0, 3        # 0x8000_0014
    ebreak                # 0x8000_0018 ---
    addi x4, x0, 4        # 0x8000_001c   |
    addi x5, x0, 5        # 0x8000_0020   |
    addi x31, x0, 1       # 0x8000_0024   |
    nop                   # 0x8000_0028   |
    nop                   # 0x8000_002c   |
    nop                   # 0x8000_0030   |
    nop                   # 0x8000_0034   |
    nop                   # 0x8000_0038   |
    nop                   # 0x8000_003c   |
    nop                   # 0x8000_0040   |
    nop                   # 0x8000_0044   |
    nop                   # 0x8000_0048   |
    nop                   # 0x8000_004c   |
    addi  x6, x0, 6       # 0x8000_0050 <--
    beq   x21, x6, 24     # 0x8000_0054 ---
    addi  x20, x0, 1      # 0x8000_0058   |
    slli  x20, x20, 15    # 0x8000_005c   |
    csrrs x0, dcsr, x20   # 0x8000_0060   |
    addi  x21, x0, 6      # 0x8000_0064   |
    dret                  # 0x8000_0068   |
    addi  x31, x0, 6      # 0x8000_006c <--
    addi  x31, x0, 1
    nop
    nop
    nop
_end:
    j _end
