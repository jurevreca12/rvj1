    .section .text
    .globl _start
_start:
    lui   x28, 0x80000
    addi  x28, x28, 0x18
    csrrw x0, mtvec, x28
    jal   x3, 0xa
    addi  x1, x0, 0x1
    jal   x0, 0x20
    csrrs x4, mstatus, x0
    csrrs x5, mepc, x0
    addi  x5, x5, 4
    csrrw x0, mepc, x5
    csrrw x6, mtval, x0
    mret
    addi x2, x0, 1
    addi x7, x0, 1
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
