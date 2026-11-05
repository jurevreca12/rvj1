# Test that an exception is triggered on an unaligned memory load.
    .section .text
    .globl _start
_start:
    lui   x28, 0x80000
    addi  x28, x28, 0x40
    csrrw x0, mtvec, x28
    lui   x2, 0x80000
    addi  x2, x2, 0x402
    lui   x1, 0xDEADC
    addi  x1, x1, 0x0DE
    sb    x2, x1, 3
    srli  x1, x1, 8
    sb    x2, x1, 2
    srli  x1, x1, 8
    sb    x2, x1, 1
    srli  x1, x1, 8
    sb    x2, x1, 0
    lw    x3, x2, 0
    jal   x0, 0x48
    csrrs x4, mstatus, x0
    csrrs x5, mepc, x0
    addi  x5, x5, 4
    csrrw x0, mepc, x5
    csrrw x6, mtval, x0
    lbu   x7, x6, 0
    slli  x7, x7, 8
    lbu   x8, x6, 1
    xor   x7, x7, x8
    slli  x7, x7, 8
    lbu   x8, x6, 2
    xor   x7, x7, x8
    slli  x7, x7, 8
    lbu   x8, x6, 3
    xor   x7, x7, x8
    mret
    addi  x9, x0, 1
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
