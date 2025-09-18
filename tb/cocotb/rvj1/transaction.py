from dataclasses import dataclass

from forastero import BaseTransaction


@dataclass(kw_only=True)
class InstrAddrResponse(BaseTransaction):
    instr: int = 0
    addr: int = 0

    def __str__(self):
        return f"InstAddrResponse(instr={self.instr}, addr={self.addr:08x})"


