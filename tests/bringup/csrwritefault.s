# Test behavior on write to a non-existant CSR register.
    .section .text
    .globl _start
_start:
    lui   x28, 0x80000
    addi  x28, x28, 0x28
    csrrw x0, mtvec, x28
    csrrw x1, 0x0, x0
    addi  x2, x0, 2
    jal   x10, 0x2c
    addi  x3, x0, 3
    addi  x4, x0, 4
    addi  x5, x0, 5
    addi  x6, x0, 6
    addi  x1, x0, 1
    csrrs x30, mepc, x0
    addi  x30, x30, 4
    csrrw x0, mepc, x30
    csrrs x29, mcause, x0
    mret
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
