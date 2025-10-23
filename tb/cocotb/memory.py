from mapped.request import MappedRequestMonitor, MappedRequestResponder
from mapped.response import MappedResponseInitiator
from mapped.transaction import (
    MappedRequest,
    MappedResponse,
    MappedAccess,
    MappedBackpressure,
)
from forastero import MonitorEvent, DriverEvent
from collections.abc import Callable
from rvj1.transaction import InstrAddrResponse


class RandomAccessMemory:
    def __init__(
        self,
        tb,
        request: MappedRequestMonitor,
        req_respond: MappedRequestResponder,
        response: MappedResponseInitiator,
        memory: dict[int, int] = {},
        delay: Callable[[], int] = lambda _: 0,
    ) -> None:
        self._request = request
        self._response = response
        self._memory = memory
        self._delay = delay
        self._request.subscribe(MonitorEvent.CAPTURE, self._service)
        self._response.subscribe(DriverEvent.PRE_DRIVE, self.req_respond_ready)
        self._req_respond = req_respond
        self._req_respond.enqueue(MappedBackpressure(ready=True))

    async def req_respond_ready(self, *_):
        self._req_respond.enqueue(
            MappedBackpressure(ready=False, cycles=self._delay(self))
        )
        self._req_respond.enqueue(MappedBackpressure(ready=True))

    def reset(self) -> None:
        self._memory.clear()

    def set_delay(self, delay: Callable[[], int]) -> None:
        self._delay = delay

    def write(self, addr: int, data: int) -> None:
        self._memory[addr] = data

    def flash(self, memory: dict[int, int]) -> None:
        self._memory = memory

    def read(self, addr: int) -> int:
        if addr not in self._memory:
            return 0
        return self._memory[addr]

    def _service(
        self,
        component: MappedRequestMonitor,
        event: MonitorEvent,
        transaction: MappedRequest,
    ) -> None:
        assert component is self._request
        assert event is MonitorEvent.CAPTURE
        if transaction.mode == MappedAccess.WRITE:
            self.write(transaction.address, transaction.data)
            self._response.enqueue(
                MappedResponse(valid=True, valid_delay=self._delay(self))
            )
        else:
            self._response.enqueue(
                MappedResponse(
                    data=self.read(transaction.address),
                    valid=transaction.address in self._memory,
                    valid_delay=self._delay(self),
                )
            )

    def __str__(self) -> str:
        ret = "RandomAccessMemory(\n"
        for addr, val in self._memory.items():
            ret += f"\t0x{addr:08x} : {val}\n"
        ret += ")\n"
        return ret


def gen_memory_data(base_addr: int, data: list[int]) -> dict[int, int]:
    mem = {}
    assert len(data) > 0
    assert base_addr % 4 == 0
    for ind, da in enumerate(data):
        addr = base_addr + 4 * ind
        mem[addr] = da
    return mem


def mem_to_instr_addr_rsp(
    memory: dict[int, int], item_range="all"
) -> list[InstrAddrResponse]:
    responses = []
    if item_range == "all":
        item_range = range(0, len(memory))
    for index, (addr, data) in enumerate(memory.items()):
        if index in item_range:
            responses.append(InstrAddrResponse(instr=data))
    return responses
