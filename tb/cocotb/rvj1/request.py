from cocotb.triggers import RisingEdge
from forastero.driver import BaseDriver
from .transaction import LsuRequest


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
