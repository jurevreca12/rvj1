from mapped.request import MappedRequestMonitor, MappedRequestResponder
from mapped.response import MappedResponseInitiator, MappedResponseMonitor
from mapped.transaction import MappedRequest, MappedResponse, MappedAccess, MappedBackpressure
import forastero
from forastero import MonitorEvent, DriverEvent
from forastero.sequence import SeqProxy, SeqContext
from collections.abc import Callable


class RandomAccessMemory:
    def __init__(self,
                 tb,
                 request: MappedRequestMonitor,
                 req_respond: MappedRequestResponder,
                 response: MappedResponseInitiator,
                 memory: dict[int, int] = {},
                 delay: Callable[[], int] = lambda _: 0) -> None:
        self._request = request
        self._response = response
        self._memory = memory
        self._delay = delay
        self._request.subscribe(MonitorEvent.CAPTURE, self._service)
        self._response.subscribe(DriverEvent.PRE_DRIVE, self._asd)
        self._req_respond = req_respond
        self._req_respond.enqueue(MappedBackpressure(ready=True))
    
    async def _asd(self, *_):
        self._req_respond.enqueue(MappedBackpressure(ready=False, cycles=self._delay(self) + 1))
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
    
    def _service(self,
                 component: MappedRequestMonitor,
                 event: MonitorEvent,
                 transaction: MappedRequest) -> None:
        assert component is self._request
        assert event is MonitorEvent.CAPTURE
        if transaction.mode == MappedAccess.WRITE:
            self.write(transaction.address, transaction.data)
            self._response.enqueue(
                MappedResponse(
                    valid = True,
                    valid_delay = self._delay(self)
                )
            )
        else:
            self._response.enqueue(
                MappedResponse(
                    data = self.read(transaction.address),
                    valid = transaction.address in self._memory,
                    valid_delay = self._delay(self)
                )
            )

    def __str__(self) -> str:
        ret="RandomAccessMemory(\n"
        for addr, val in self._memory.items():
            ret+=f"\t0x{addr:08x} : {val}\n"
        ret+=")\n"
        return ret