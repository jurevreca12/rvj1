# Test of JALR instruction bit clearing.
    .section .text
    .globl _start
_start:
    la    x1, jmp_addr
    addi  x3, x0, 3
    jalr  x10, x1, 1
    addi  x4, x0, 4
jmp_addr:
    addi  x6, x0, 6
    addi  x7, x0, 7
    addi  x31, x0, 1
_end:
    j _end
    .section .data
    .section .rodata
    .ascii "{
            3: 3,
            4: 0,
            6: 6,
            7: 7,
        }"
