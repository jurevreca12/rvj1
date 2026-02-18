from dataclasses import dataclass
from enum import IntEnum
from forastero import BaseTransaction


@dataclass(kw_only=True)
class InstrAddrResponse(BaseTransaction):
    instr: int = 0


@dataclass(kw_only=True)
class DecoderBackpressure(BaseTransaction):
    ready: bool = True
    cycles: int = 0


class LsuCmd(IntEnum):
    NO_CMD = int("1111", 2)
    LOAD_BYTE = int("0000", 2)
    LOAD_HALF_WORD = int("0001", 2)
    LOAD_WORD = int("0010", 2)
    LOAD_BYTE_U = int("0100", 2)
    LOAD_HALF_WORD_U = int("0101", 2)
    STORE_BYTE = int("1000", 2)
    STORE_HALF_WORD = int("1001", 2)
    STORE_WORD = int("1010", 2)


@dataclass(kw_only=True)
class LsuRequest(BaseTransaction):
    cmd: LsuCmd = LsuCmd.LOAD_BYTE
    addr: int = 0
    data: int = 0
    regdest: int = 0


@dataclass(kw_only=True)
class LsuRfResponse(BaseTransaction):
    data: int = 0
    regdest: int = 0

@dataclass(kw_only=True)
class LsuExcResponse(BaseTransaction):
    load_addr_misaligned: bool = False
    load_access_fault: bool = False
    store_addr_misaligned: bool = False
    store_access_fault: bool = False
    exc_addr: int


@dataclass(kw_only=True)
class IfuJmpRequest(BaseTransaction):
    addr: int = 0

@dataclass(kw_only=True)
class IfuErrorResponse(BaseTransaction):
    addr: int = 0
