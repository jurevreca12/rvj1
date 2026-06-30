from dataclasses import dataclass
from enum import IntEnum
from forastero import BaseTransaction
    

@dataclass(kw_only=True)
class RvfiTransaction(BaseTransaction):
    order: int
    insn: int
    trap: bool     = False
    halt: bool     = False
    intr: bool     = False
    mode: int      = 0x3    # M mode
    ixl: int       = 0x1
    rs1_addr: int  = -1
    rs2_addr: int  = -1
    rs1_rdata: int = -1
    rs2_rdata: int = -1
    rd_addr: int   = -1
    rd_wdata: int  = -1
    pc_rdata: int
    pc_wdata: int
    mem_addr: int  = -1
    mem_rmask: int = -1
    mem_wmask: int = -1
    mem_rdata: int = -1
    mem_wdata: int = -1
    csr_mstatus_rmask: int = -1
    csr_mstatus_wmask: int = -1
    csr_mstatus_rdata: int = -1
    csr_mstatus_wdata: int = -1
    csr_mie_rmask: int = -1
    csr_mie_wmask: int = -1
    csr_mie_rdata: int = -1
    csr_mie_wdata: int = -1
    csr_mtvec_rmask: int = -1
    csr_mtvec_wmask: int = -1
    csr_mtvec_rdata: int = -1
    csr_mtvec_wdata: int = -1
    csr_mepc_rmask: int = -1
    csr_mepc_wmask: int = -1
    csr_mepc_rdata: int = -1
    csr_mepc_wdata: int = -1
    csr_mcause_rmask: int = -1
    csr_mcause_wmask: int = -1
    csr_mcause_rdata: int = -1
    csr_mcause_wdata: int = -1
    csr_mtval_rmask: int = -1
    csr_mtval_wmask: int = -1
    csr_mtval_rdata: int = -1
    csr_mtval_wdata: int = -1
    csr_mip_rmask: int = -1
    csr_mip_wmask: int = -1
    csr_mip_rdata: int = -1
    csr_mip_wdata: int = -1

