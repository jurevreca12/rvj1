from collections.abc import Callable
from cocotb.handle import HierarchyObject
from forastero.io import BaseIO, IORole

rvfi_sigs = [
    "valid",
    "order",
    "insn",
    "trap",
    "halt",
    "intr",
    "mode",
    "ixl",
    "rs1_addr",
    "rs2_addr",
    "rs1_rdata",
    "rs2_rdata",
    "rd_addr",
    "rd_wdata",
    "pc_rdata",
    "pc_wdata",
    "mem_addr",
    "mem_rmask",
    "mem_wmask",
    "mem_rdata",
    "mem_wdata",
]
csrs = (
    "mstatus",
    "mie",
    "mtvec",
    "mepc",
    "mcause",
    "mtval",
    "mip" 
)
csr_sigs = []
for csr in csrs:
    csr_sigs += (f"csr_{csr}_rmask",)
    csr_sigs += (f"csr_{csr}_wmask",)
    csr_sigs += (f"csr_{csr}_rdata",)
    csr_sigs += (f"csr_{csr}_wdata",)

class RvfiIO(BaseIO):
    def __init__(
        self,
        dut: HierarchyObject,
        name: str | None,
        role: IORole,
        io_style: Callable[[str | None, str, IORole, IORole], str] | None = None
    ) -> None:
        super().__init__(
            dut=dut,
            name=name,
            role=role,
            init_sigs=rvfi_sigs + csr_sigs,
            resp_sigs=[],
            io_style=io_style,
        )