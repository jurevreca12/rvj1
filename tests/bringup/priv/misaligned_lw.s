# Test that an exception is triggered on an unaligned memory load.
    .section .text
    .globl _start
_start:
    la    x28, trap_vec
    csrw  mtvec, x28
    la    x2, _data
    addi  x2, x2, 2
    li    x1, 0xDEADC0DE
    sb    x1, 3(x2)
    srli  x1, x1, 8
    sb    x1, 2(x2)
    srli  x1, x1, 8
    sb    x1, 1(x2)
    srli  x1, x1, 8
    sb    x1, (x2)
    lw    x3, (x2)
    j     cleanup
.align 4
trap_vec:
    csrr  x4, mstatus
    csrr  x5, mepc
    lhu   x16, (x5)
    addi  x5, x5, 2
    andi  x16, x16, 3  # check instruction starts with 0b11
    li    x17, 3
    bne   x16, x17, skip_add
    addi  x5, x5, 2
skip_add:
    csrw  mepc, x5
    csrr  x6, mtval
    lbu   x7, (x6)
    slli  x7, x7, 8
    lbu   x8, 1(x6)
    xor   x7, x7, x8
    slli  x7, x7, 8
    lbu   x8, 2(x6)
    xor   x7, x7, x8
    slli  x7, x7, 8
    lbu   x8, 3(x6)
    xor   x7, x7, x8
    mret
    addi  x9, x0, 1
cleanup:
    nop
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
_data:
    .section .data
    .word 0x0
    .word 0x0
    .section .rodata
    .ascii "{7: 0xDEADC0DE, 9: 0}"
