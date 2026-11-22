# Tests the behavior of MSTATUS register. Specifically the MIE and MIEP
# bits usage in ecall and mret.
    .section .text
    .globl _start
_start:
    csrr  x1, mstatus
    lui   x28, 0x80000
    addi  x28, x28, 0x20
    csrw  mtvec, x28
    csrsi mstatus, 0x8
    csrr  x2, mstatus
    ecall
    jal   x10, cleanup
    csrr  x3, mstatus
    csrr  x30, mepc
    addi  x30, x30, 4
    csrw  mepc, x30
    mret
cleanup:
    csrr  x4, mstatus
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{
        1: (0 + (1 << 11) + (1 << 12)), 
        2: (8 + (1 << 11) + (1 << 12)), 
        3: ((1 << 7) + (1 << 11) + (1 << 12)), 
        4: (8 + (1 << 7) + (1 << 11) + (1 << 12))
    }"