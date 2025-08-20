from dataclasses import dataclass

from forastero import BaseTransaction


@dataclass(kw_only=True)
class InstrAddrResponse(BaseTransaction):
    instr: int = 0
    addr: int = 0


