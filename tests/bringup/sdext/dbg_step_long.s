# Test if the step functionality of the debug module works. Each time the CPU enters debug mode,
# a counter is incremented. This signals if the CPU is correctly stepping through instructions. 
# This test specifically tests longer lasting instructions like store/load.                     
    .section .text
    .globl _start
_start.
    lui  x28, 0x80000       # 0x8000_0000            
    addi x28, x28, 0x400    # 0x8000_0004            
    addi x1, x0, 1          # 0x8000_0008            
    sw   x28, x1, 0         # 0x8000_000c            
    addi x2, x0, 2          # 0x8000_0010            
    addi x3, x0, 3          # 0x8000_0014            
    addi x4, x0, 2          # 0x8000_0018            
    addi x4, x0, 4          # 0x8000_001c            
    lw   x5, x28, 0         # 0x8000_0020            
    addi x31, x0, 1         # 0x8000_0024            
    nop                     # 0x8000_0028            
    nop                     # 0x8000_002c            
    nop                     # 0x8000_0030            
    nop                     # 0x8000_0034            
    nop                     # 0x8000_0038            
    nop                     # 0x8000_003c            
    nop                     # 0x8000_0040            
    nop                     # 0x8000_0044            
    nop                     # 0x8000_0048            
    nop                     # 0x8000_004c            
    addi   x6, x6, 1        # 0x8000_0050            
    csrrsi x0, dcsr, 0x4    # 0x8000_0054  | step = 1
    dret                    # 0x8000_0058            
    nop                                   
    nop                                   
                                                   
_end:
    j _end
