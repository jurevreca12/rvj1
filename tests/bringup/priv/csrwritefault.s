# Test behavior on write to a non-existant CSR register.
    .section .text
    .globl _start
_start:
    la    x28, _trap_vec  # 0x8000_0000
    csrw  mtvec, x28      # 0x8000_0008
    csrrw x1, 0x0, x0     # 0x8000_000c <- illegal write
    addi  x2, x0, 2       # 0x8000_0010
    jal   x10, cleanup 
    addi  x3, x0, 3
    addi  x4, x0, 4
    addi  x5, x0, 5
    addi  x6, x0, 6
_trap_vec:
    addi  x1, x0, 1
    csrr  x30, mepc
    addi  x30, x30, 4
    csrw  mepc, x30
    csrrs x29, mcause, x0
    mret
cleanup:
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{1: 1, 2: 2, 3: 0, 29:2, 30:0x8000_0010}"