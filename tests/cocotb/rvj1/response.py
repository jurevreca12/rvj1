from cocotb.triggers import ClockCycles, RisingEdge
from forastero.driver import BaseDriver
from forastero.monitor import BaseMonitor

from rvj1.transaction import InstrAddrResponse, DecoderBackpressure, LsuRfResponse, LsuExcResponse, IfuErrorResponse


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
                    error=self.io.get("error", 0)
                )
                capture(tran)

class DecoderResponder(BaseDriver):
    async def drive(self, obj: DecoderBackpressure) -> None:
        self.io.set("ready", obj.ready)
        await ClockCycles(self.clk, obj.cycles)


class LsuRfMonitor(BaseMonitor):
    async def monitor(self, capture):
        while True:
            await RisingEdge(self.clk)
            if self.rst.value == 0:
                await RisingEdge(self.clk)
                continue
            if self.io.get("wb"):
                tran = LsuRfResponse(
                    data=self.io.get("data"), regdest=self.io.get("dest")
                )
                capture(tran)

class LsuExcMonitor(BaseMonitor):
    async def monitor(self, capture):
        while True:
            await RisingEdge(self.clk)
            if self.rst.value == 0:
                await RisingEdge(self.clk)
                continue
            if (self.io.get("load_addr_misaligned") or
                self.io.get("load_access_fault") or
                self.io.get("store_addr_misaligned") or
                self.io.get("store_access_fault")):
                trans = LsuExcResponse(
                    load_addr_misaligned=self.io.get("load_addr_misaligned"),
                    load_access_fault=self.io.get("load_access_fault"),
                    store_addr_misaligned=self.io.get("store_addr_misaligned"),
                    store_access_fault=self.io.get("store_access_fault"),
                    exc_addr=self.io.get("addr")
                )
                capture(trans)
