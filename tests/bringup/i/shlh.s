    .section .text
    .globl _start
_start:
    lui  x2, 0xDEADC    # 0x8000_0000
    addi x2, x2, 0x0DE  # 0x8000_0004
    la   x1, _data      # 0x8000_0008
    sh   x2, (x1)       # 0x8000_0010
    srli x2, x2, 16     # 0x8000_0014
    sh   x2, 2(x1)      # 0x8000_0018
    lh   x3, (x1)       # 0x8000_001c
    lh   x4, 2(x1)      # 0x8000_0020
    addi x31, x0, 1     # 0x8000_0024
_end:
    j _end              # 0x8000_0028
    .section .data
_data: 
    .section .rodata
    .ascii "{
            1: 0x8000002c,
            2: 0x0000dead,
            3: 0xffffc0de,
            4: 0xffffdead,
        }

