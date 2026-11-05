# Tests the behavior of MSTATUS register. Specifically the MIE and MIEP
# bits usage in ecall and mret.
    .section .text
    .globl _start
_start:
    csrrs x1, mstatus, x0
    lui   x28, 0x80000
    addi  x28, x28, 0x20
    csrrw x0, mtvec, x28
    crrsi x0, mstatus, 0x8
    csrrs x2, x0, mstatus
    ecall
    jal   x10, 0x18
    csrrs x3, mstatus, x0
    csrrs x30, mepc, x0
    addi  x30, x30, 4
    csrrw x0, mepc, x30
    mret
    csrrs x4, x0, mstatus
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
