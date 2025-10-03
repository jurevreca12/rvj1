import forastero
from forastero import DriverEvent, SeqContext
from .transaction import DecoderBackpressure, LsuRequest
from .response import DecoderResponder
from .request import LsuInitiator


@forastero.sequence()
@forastero.requires("dec", DecoderResponder)
async def dec_backpressure_seq(
    ctx: SeqContext,
    dec: DecoderResponder,
    min_interval: int = 1,
    max_interval: int = 10,
    backpressure: float = 0.5,
):
    """
    Generate random backpressure using the ready signal from the decoder
    interface.

    :param min_interval: Shortest time to hold ready constant.
    :param max_interval: Longest time to hold ready constant.
    :param backpressure: Proportionally how long should ready be held low.
                         Where 1 means complete backpressure, and 0 means
                         always available.
    """
    async with ctx.lock(dec):
        while True:
            await dec.enqueue(
                DecoderBackpressure(
                    ready=ctx.random.choices(
                        (True, False), weights=(1.0 - backpressure, backpressure), k=1
                    )[0],
                    cycles=ctx.random.randint(min_interval, max_interval),
                ),
                DriverEvent.PRE_DRIVE,
            ).wait()


@forastero.sequence()
@forastero.requires("lsu_drv", LsuInitiator)
async def lsu_drive_seq(
    ctx: SeqContext, lsu_drv: LsuInitiator, requests: list[LsuRequest]
):
    async with ctx.lock(lsu_drv):
        for request in requests:
            await lsu_drv.enqueue(request, DriverEvent.PRE_DRIVE).wait()
