# SPDX-License-Identifier: MIT
# Copyright (c) 2023-2024 Vypercore. All Rights Reserved


from cocotb.triggers import ClockCycles, RisingEdge
from forastero.driver import BaseDriver, DriverStatistics
from forastero.monitor import BaseMonitor
from forastero.io import BaseIO
from typing import Any
from cocotb.handle import SimHandleBase
from random import Random
from forastero.queue import Queue
from forastero.transaction import BaseTransaction
import cocotb
from mapped.request import MappedControlMonitor

from .transaction import MappedBackpressure, MappedResponse
from forastero import MonitorEvent

class MappedResponseInitiator(BaseDriver):
    def __init__(
        self,
        tb: Any,
        io: BaseIO,
        clk: SimHandleBase,
        rst: SimHandleBase,
        random: Random | None = None,
        name: str | None = None,
        blocking: bool = True,
        control: MappedControlMonitor = None
    ) -> None:
        super().__init__(tb, io, clk, rst, random, name, blocking)
        self.stats = DriverStatistics()
        self._queue: Queue[BaseTransaction] = Queue()
        self._control = control
        if self._control is not None:
            self._control.subscribe(MonitorEvent.CAPTURE, self._cancel_requests)
        self._cancel_event = False
        cocotb.start_soon(self._driver_loop())

    def _cancel_requests(self):
        self._cancel_event = True

    async def drive(self, transaction: MappedResponse):
        print(f"drive: {transaction.data}.")
        # Setup the transaction
        self.io.set("data", transaction.data)
        self.io.set("error", transaction.error)
        # Drive valid (after delay if set)
        if transaction.valid_delay:
            await ClockCycles(self.clk, transaction.valid_delay)
        self.io.set("valid", transaction.valid)
        # Wait for value to be accepted
        while True:
            await RisingEdge(self.clk)
            if self.io.get("ready") or self.cancel_event:
                break
        self._cancel_event = False
        self.io.set("valid", 0)


class MappedResponseResponder(BaseDriver):
    async def drive(self, transaction: MappedBackpressure):
        # Setup the transaction
        self.io.set("ready", transaction.ready)
        # Wait for the required number of cycles
        await ClockCycles(self.clk, transaction.cycles)


class MappedResponseMonitor(BaseMonitor):
    async def monitor(self, capture):
        while True:
            await RisingEdge(self.clk)
            if self.rst.value == 1:
                await RisingEdge(self.clk)
                continue
            if self.io.get("valid") and self.io.get("ready"):
                tran = MappedResponse(
                    data=self.io.get("data", 0),
                    error=self.io.get("error", 0),
                )
                capture(tran)
