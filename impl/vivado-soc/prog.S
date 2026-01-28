# to communicate with the host
# check riscv-software-src/riscv-tests
.section .tohost, "aw", @progbits

.align 6
.globl tohost
tohost: .dword 0

.align 6
.globl fromhost
fromhost: .dword 0





.section .text

.globl _start

# x1 - LED value register
# x2 - GPIO address register
# x4 - counter count register  
# x5 - Counter limit register

_start:
    lui x2, 0x80020
    addi x1, x0, 0xaa
    lui  x5, 0xf5e1
before_loop:
    addi x4, x0, 0
loop:
    addi x4, x4, 1
    blt x4, x5, loop
    xori x1, x1, 0xFF
    sw x1, 0(x2)
    j before_loop

# a0 exit code
tohost_exit:
    slli a0, a0, 1
    ori a0, a0, 1
    
    la t0, tohost
    sd a0, 0(t0)
    
    1: j 1b # wait for termination
