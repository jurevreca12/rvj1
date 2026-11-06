# Spin in an infinite loop and break the loop with a debug request. This debug request is not
# present at startup instead it only gets triggered after some time.

    .section .text
    .globl _start
_start:
    addi x1, x1, 1    # 0x8000_0000
    bne  x0, x1, -4   # 0x8000_0004
    nop               # 0x8000_0008
    nop               # 0x8000_000c
    nop               # 0x8000_0010
    addi x2, x0, 1    # 0x8000_0014
    nop               # 0x8000_0018
    nop               # 0x8000_001c
    nop               # 0x8000_0020
    nop               # 0x8000_0024
    nop               # 0x8000_0028
    nop               # 0x8000_002c
    nop               # 0x8000_0030
    nop               # 0x8000_0034
    nop               # 0x8000_0038
    nop               # 0x8000_003c
    nop               # 0x8000_0040
    nop               # 0x8000_0044
    nop               # 0x8000_0048
    nop               # 0x8000_004c
    addi x3, x0, 1    # 0x8000_0050
    addi x31, x0, 1   # 0x8000_0054
    nop                       
    nop                       

_end:
    j _end
