import forastero
from forastero import DriverEvent, SeqContext
from cocotb.triggers import ClockCycles
from .transaction import DecoderBackpressure, LsuRequest, IfuJmpRequest, IrqRequest
from .response import DecoderResponder
from .request import LsuInitiator, IfuJmpInitiator, IrqDriver


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
@forastero.requires("ifu_jmp_drv", IfuJmpInitiator)
async def ifu_jmp_to_addr(
    ctx: SeqContext,
    ifu_jmp_drv: IfuJmpInitiator,
    addr: int
):
    "Forces the IFU to jump to a desired address."
    async with ctx.lock(ifu_jmp_drv):
        await ifu_jmp_drv.enqueue(IfuJmpRequest(addr=addr), DriverEvent.PRE_DRIVE).wait()

    
@forastero.sequence()
@forastero.requires("lsu_drv", LsuInitiator)
async def lsu_drive_seq(
    ctx: SeqContext, lsu_drv: LsuInitiator, requests: list[LsuRequest]
):
    async with ctx.lock(lsu_drv):
        for request in requests:
            await lsu_drv.enqueue(request, DriverEvent.PRE_DRIVE).wait()


@forastero.sequence()
@forastero.requires("irq_drv", IrqDriver)
async def irq_rand_seq(
    ctx: SeqContext, 
    irq_drv: IrqDriver,
    min_latency = 100,
    max_latency = 1000,
):
    async with ctx.lock(irq_drv):
        while True:
            await ClockCycles(ctx.clk, ctx.random.randint(min_latency, max_latency))
            irq_drv.enqueue(
                IrqRequest(
                    external = ctx.random.random() > 0.9,
                    timer    = ctx.random.random() > 0.9,
                    sw       = ctx.random.random() > 0.9,
                    lcofi    = ctx.random.random() > 0.9,
                    platform = ctx.random.getrandbits(16) * (ctx.random.random() > 0.9),
                    nmi      = ctx.random.random() > 0.9
                )
            )
            await irq_drv.wait_for(DriverEvent.PRE_DRIVE)