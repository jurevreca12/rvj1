from forastero.monitor import BaseMonitor
from cocotb.triggers import RisingEdge
from rvfi.transaction import RvfiTransaction

class RvfiMonitor(BaseMonitor):
    async def monitor(self, capture):
        while True:
            await RisingEdge(self.clk)
            if self.rst.value == 0:
                await RisingEdge(self.clk)
                continue
            if self.io.get("valid"):
                trans = RvfiTransaction(
                    order              = self.io.get("order"),
                    insn               = self.io.get("insn"),
                    trap               = self.io.get("trap"),
                    halt               = self.io.get("halt"),
                    intr               = self.io.get("intr"),
                    mode               = self.io.get("mode"),
                    ixl                = self.io.get("ixl"),
                    rs1_addr           = self.io.get("rs1_addr"),
                    rs2_addr           = self.io.get("rs2_addr"),
                    rs1_rdata          = self.io.get("rs1_rdata"),
                    rs2_rdata          = self.io.get("rs2_rdata"),
                    rd_addr            = self.io.get("rd_addr"),
                    rd_wdata           = self.io.get("rd_wdata"),
                    pc_rdata           = self.io.get("pc_rdata"),
                    pc_wdata           = self.io.get("pc_wdata"),
                    mem_addr           = self.io.get("mem_addr"),
                    mem_rmask          = self.io.get("mem_rmask"),
                    mem_wmask          = self.io.get("mem_wmask"),
                    mem_rdata          = self.io.get("mem_rdata"),
                    mem_wdata          = self.io.get("mem_wdata"),
                    csr_mstatus_rmask  = self.io.get("csr_mstatus_rmask"),
                    csr_mstatus_wmask  = self.io.get("csr_mstatus_wmask"),
                    csr_mstatus_rdata  = self.io.get("csr_mstatus_rdata"),
                    csr_mstatus_wdata  = self.io.get("csr_mstatus_wdata"),
                    csr_misa_rmask     = self.io.get("csr_misa_rmask"),
                    csr_misa_wmask     = self.io.get("csr_misa_wmask"),
                    csr_misa_rdata     = self.io.get("csr_misa_rdata"),
                    csr_misa_wdata     = self.io.get("csr_misa_wdata"),
                    csr_mie_rmask      = self.io.get("csr_mie_rmask"),
                    csr_mie_wmask      = self.io.get("csr_mie_wmask"),
                    csr_mie_rdata      = self.io.get("csr_mie_rdata"),
                    csr_mie_wdata      = self.io.get("csr_mie_wdata"),
                    csr_mtvec_rmask    = self.io.get("csr_mtvec_rmask"),
                    csr_mtvec_wmask    = self.io.get("csr_mtvec_wmask"),
                    csr_mtvec_rdata    = self.io.get("csr_mtvec_rdata"),
                    csr_mtvec_wdata    = self.io.get("csr_mtvec_wdata"),
                    csr_mscratch_rmask = self.io.get("csr_mscratch_rmask"),
                    csr_mscratch_wmask = self.io.get("csr_mscratch_wmask"),
                    csr_mscratch_rdata = self.io.get("csr_mscratch_rdata"),
                    csr_mscratch_wdata = self.io.get("csr_mscratch_wdata"),
                    csr_mcause_rmask   = self.io.get("csr_mcause_rmask"),
                    csr_mcause_wmask   = self.io.get("csr_mcause_wmask"),
                    csr_mcause_rdata   = self.io.get("csr_mcause_rdata"),
                    csr_mcause_wdata   = self.io.get("csr_mcause_wdata"),
                    csr_mtval_rmask    = self.io.get("csr_mtval_rmask"),
                    csr_mtval_wmask    = self.io.get("csr_mtval_wmask"),
                    csr_mtval_rdata    = self.io.get("csr_mtval_rdata"),
                    csr_mtval_wdata    = self.io.get("csr_mtval_wdata"),
                    csr_mip_rmask      = self.io.get("csr_mip_rmask"),
                    csr_mip_wmask      = self.io.get("csr_mip_wmask"),
                    csr_mip_rdata      = self.io.get("csr_mip_rdata"),
                    csr_mip_wdata      = self.io.get("csr_mip_wdata"),
                )
                capture(trans)