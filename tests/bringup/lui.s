    .section .text
    .globl _start
_start:
    lui  x1, 0          # expected: 0x00000000
    lui  x2, 1          # expected: 0x00001000
    lui  x3, 0x80000    # expected: 0x80000000
    lui  x4, 0xFFFFF    # expected: 0xFFFFF000
    lui  x0, 0xFFFFF    # x0 remains 0
    addi x31, x0, 1
_end:
    j _end
