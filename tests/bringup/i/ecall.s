    .section .text
    .globl _start
_start:
    lui   x28, 0x80000     # 0x8000_0000
    addi  x28, x28, 0x28   # 0x8000_0004
    csrw  mtvec, x28       # 0x8000_0008
    ecall                  # 0x8000_000c ---
    addi  x2, x0, 2        # 0x8000_0010   |
    jal   x10, 0x2c        # 0x8000_0014   |
    addi  x3, x0, 3        # 0x8000_0018   |
    addi  x4, x0, 4        # 0x8000_001c   |
    addi  x5, x0, 5        # 0x8000_0020   |
    addi  x6, x0, 6        # 0x8000_0024   |
    addi  x1, x0, 1        # 0x8000_0028 <-- mtvec
    csrrs x30, mepc, x0    # 0x8000_002c
    addi  x30, x30, 4      # 0x8000_0028
    csrrw x0, mepc, x30    # 0x8000_002c
    csrrs x29, mcause, x0  # 0x8000_0030
    mret                   # 0x8000_0034 
    nop                    # 0x8000_0038
    nop                    # 0x8000_003c
    nop                    # 0x8000_0040
    addi x31, x0, 1        # 0x8000_0044
_end:
    j _end
