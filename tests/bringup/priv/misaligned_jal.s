    .section .text
    .globl _start
_start:
    lui   x29, 0x80000
    addi  x28, x29, 0x18
    csrrw x0, mtvec, x28
    jalr   x3, x29, 0xa
    addi  x1, x0, 0x1
    jal   x0, cleanup
    csrrs x4, mstatus, x0
    csrrs x5, mepc, x0
    addi  x5, x5, 4
    csrrw x0, mepc, x5
    csrrw x6, mtval, x0
    mret
    addi x2, x0, 1
cleanup:
    addi x7, x0, 1
    nop
    nop
    addi x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{0:0, 1: 1, 2:0, 3: 0, 5:0x80000010, 6:0x80000016, 7:1}"