from dataclasses import dataclass
from enum import IntEnum, auto
from forastero import BaseTransaction


@dataclass(kw_only=True)
class InstrAddrResponse(BaseTransaction):
    instr: int = 0
    addr: int = 0

    def __str__(self):
        return f"InstAddrResponse(instr={self.instr}, addr={self.addr:08x})"


@dataclass(kw_only=True)
class DecoderBackpressure(BaseTransaction):
    ready: bool = True
    cycles: int = 0


class LsuCmd(IntEnum):
    LOAD_BYTE = auto()
    LOAD_HALF_WORD = auto()
    LOAD_WORD = auto()
    LOAD_BYTE_U = auto()
    LOAD_HALF_WORD_U = auto()
    STORE_BYTE = auto()
    STORE_HALF_WORD = auto()
    STORE_WORD = auto()


@dataclass(kw_only=True)
class LsuRequest(BaseTransaction):
    cmd: LsuCmd = LsuCmd.LOAD_BYTE
    addr: int = 0
    data: int = 0
    regdest: int = 0
