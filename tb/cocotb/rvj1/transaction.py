from dataclasses import dataclass
from enum import IntEnum
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
    NO_CMD = int("00000", 2)
    LOAD_BYTE = int("00001", 2)
    LOAD_HALF_WORD = int("00011", 2)
    LOAD_WORD = int("00111", 2)
    LOAD_BYTE_U = int("01001", 2)
    LOAD_HALF_WORD_U = int("01011", 2)
    STORE_BYTE = int("10001", 2)
    STORE_HALF_WORD = int("10011", 2)
    STORE_WORD = int("10111", 2)


@dataclass(kw_only=True)
class LsuRequest(BaseTransaction):
    cmd: LsuCmd = LsuCmd.LOAD_BYTE
    addr: int = 0
    data: int = 0
    regdest: int = 0


@dataclass(kw_only=True)
class LsuRfRequest(BaseTransaction):
    data: int = 0
    regdest: int = 0
