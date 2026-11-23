    .section .text
    .globl _start
_start:
    la    x28, trap_vec
    csrw  mtvec, x28
    ecall
    addi  x2, x0, 2
    jal   x10, cleanup
    addi  x3, x0, 3
    addi  x4, x0, 4
    addi  x5, x0, 5
    addi  x6, x0, 6
.align 4
trap_vec:
    addi  x1, x0, 1
    csrr  x30, mepc
    addi  x30, x30, 4
    csrw  mepc, x30
    csrr  x29, mcause
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
    .ascii "{1:1, 2: 2, 3: 0, 4: 0, 6: 0, 29: 11}"