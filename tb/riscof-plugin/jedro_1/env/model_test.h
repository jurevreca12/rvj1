#ifndef _COMPLIANCE_MODEL_H
#define _COMPLIANCE_MODEL_H

#define RVMODEL_MEM_SIZE_WORDS ( 1 << 19 )
#define RVMODEL_LAST_ADDR      ( (RVMODEL_MEM_SIZE_WORDS << 2) - 4 )
#define RVOMDEL_BEGIN_SIG_ADDR ( RVMODEL_LAST_ADDR )
#define RVMODEL_END_SIG_ADDR   ( RVMODEL_LAST_ADDR - 4 )
#define RVMODEL_HALT_COND_ADDR ( RVMODEL_LAST_ADDR - 8 )

#define RVMODEL_DATA_SECTION \
        .pushsection .tohost,"aw",@progbits;                            \
        .align 8; .global tohost; tohost: .dword 0;                     \
        .align 8; .global fromhost; fromhost: .dword 0;                 \
        .popsection;                                                    \
        .align 8; .global begin_regstate; begin_regstate:               \
        .word 128;                                                      \
        .align 8; .global end_regstate; end_regstate:                   \
        .word 4;

//RV_COMPLIANCE_HALT
#define RVMODEL_HALT                            \
  la x1, begin_signature;                       \
  la x2, end_signature;                         \
  li x3, RVMODEL_HALT_COND_ADDR;                \
  sw x2, 4(x3);                                 \
  sw x1, 8(x3);                                 \
  li x1, 1;                                     \
  sw x1, 0(x3);                                 \
  write_tohost:                                 \
    sw x1, tohost, t5;                          \
    j write_tohost;

//RV_COMPLIANCE_DATA_BEGIN
#define RVMODEL_DATA_BEGIN                                              \
  RVMODEL_DATA_SECTION                                                        \
  .align 4;\
  .global begin_signature; begin_signature:

//RV_COMPLIANCE_DATA_END
#define RVMODEL_DATA_END                                                      \
  .align 4;\
  .global end_signature; end_signature:  


// Set the HALT_COND memory value to zero,
// and set the BEGIN_SIG and END_SIG fields,
// so that the simulator will be able to extract
// the signature.
#define RVMODEL_BOOT                       

//RVTEST_IO_INIT
#define RVMODEL_IO_INIT
//RVTEST_IO_WRITE_STR
#define RVMODEL_IO_WRITE_STR(_R, _STR)
//RVTEST_IO_CHECK
#define RVMODEL_IO_CHECK()
//RVTEST_IO_ASSERT_GPR_EQ
#define RVMODEL_IO_ASSERT_GPR_EQ(_S, _R, _I)
//RVTEST_IO_ASSERT_SFPR_EQ
#define RVMODEL_IO_ASSERT_SFPR_EQ(_F, _R, _I)
//RVTEST_IO_ASSERT_DFPR_EQ
#define RVMODEL_IO_ASSERT_DFPR_EQ(_D, _R, _I)

#define RVMODEL_SET_MSW_INT       \
 li t1, 1;                         \
 li t2, 0x2000000;                 \
 sw t1, 0(t2);

#define RVMODEL_CLEAR_MSW_INT     \
 li t2, 0x2000000;                 \
 sw x0, 0(t2);

#define RVMODEL_CLEAR_MTIMER_INT

#define RVMODEL_CLEAR_MEXT_INT


#endif // _COMPLIANCE_MODEL_H
