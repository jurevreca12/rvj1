from cocotb.triggers import ClockCycles, RisingEdge
from forastero.driver import BaseDriver
from forastero.monitor import BaseMonitor

from rvj1.transaction import InstrAddrResponse, DecoderBackpressure


class IfuToDecMonitor(BaseMonitor):
    async def monitor(self, capture):
        while True:
            await RisingEdge(self.clk)
            if self.rst.value == 0:
                await RisingEdge(self.clk)
                continue
            if self.io.get("valid") and self.io.get("ready"):
                tran = InstrAddrResponse(
                    instr=self.io.get("instr", 0),
                    addr=self.io.get("pc", 0),
                )
                capture(tran)


class DecoderResponder(BaseDriver):
    async def drive(self, obj: DecoderBackpressure) -> None:
        self.io.set("ready", obj.ready)
        await ClockCycles(self.clk, obj.cycles)
