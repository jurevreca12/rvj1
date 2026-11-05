from cocotb.triggers import RisingEdge
from forastero.driver import BaseDriver
from .transaction import LsuRequest
from .transaction import IfuJmpRequest
from .transaction import IrqRequest

class LsuInitiator(BaseDriver):
    async def drive(self, transaction: LsuRequest):
        self.io.set("cmd", transaction.cmd)
        self.io.set("addr", transaction.addr)
        self.io.set("data", transaction.data)
        self.io.set("regdest", transaction.regdest)
        self.io.set("valid", True)
        # Wait for ready
        while True:
            await RisingEdge(self.clk)
            if self.io.get("ready"):
                break
        self.io.set("valid", False)


class IfuJmpInitiator(BaseDriver):
    async def drive(self, transaction: IfuJmpRequest):
        self.io.set("addr", transaction.addr)
        self.io.set("addr_valid", True)
        await RisingEdge(self.clk)
        self.io.set("addr_valid", False)

class IrqDriver(BaseDriver):
    async def drive(self, transaction: IrqRequest):
        self.io.set("external", transaction.external)
        self.io.set("timer", transaction.timer)
        self.io.set("sw", transaction.sw)
        self.io.set("lcofi", transaction.lcofi)
        self.io.set("platform", transaction.platform)
        self.io.set("nmi", transaction.nmi)
        await RisingEdge(self.clk)
        self.io.set("external", False)
        self.io.set("timer", False)
        self.io.set("sw", False)
        self.io.set("lcofi", False)
        self.io.set("platform", 0x0)
        self.io.set("nmi", False)