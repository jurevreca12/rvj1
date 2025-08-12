from forastero import BaseIO, BaseMonitor, BaseTransaction
from forastero.driver import BaseDriver
from forastero.io import IORole, io_suffix_style 
from cocotb.handle import HierarchyObject
from cocotb.triggers import RisingEdge
from dataclasses import dataclass

class InstrMemIO(BaseIO): # W: Missing class docstring # W: Too few public methods (0/2)    
    def __init__(
        self,
        dut: HierarchyObject,
        name: str | None,
        role: IORole,
        io_style = io_suffix_style,
    ) -> None:
        super().__init__(                                                                 
            dut=dut,
            name=name,
            role=role,
            init_sigs=["req", "addr"],
            resp_sigs=["rvalid", "rdata", "err"],
            io_style=io_suffix_style,
        )


@dataclass(kw_only=True)
class InstrMemTransaction(BaseTransaction):
    rdata: int

class InstrMemResponder(BaseDriver):
    async def drive(self, obj: InstrMemTransaction):
        while True:
            if self.io.get("req", 1):
                self.io.set("rdata", obj.rdata)
                self.io.set("rvalid", 1)
                break
            else:
                await RisingEdge(self.clk)
        await RisingEdge(self.clk)
        self.io.set("rvalid", 0)

class InstrMemMonitor(BaseMonitor):
    async def monitor(self, capture) -> None:
        while True:
            await RisingEdge(self.clk)
            if self.rst.value == 0:
                continue
            if self.io.get("rvalid", 1):
                capture(InstrMemTransaction(rdata=self.io.get("rdata")))

class IfuDecIO(BaseIO): # W: Missing class docstring # W: Too few public methods (0/2)    
    def __init__(                                                                         
        self,                                                                             
        dut: HierarchyObject,                                                             
        name: str | None,           
        role: IORole,
        io_style = io_suffix_style,
    ) -> None:                                                                            
        super().__init__(                                                                 
            dut=dut,                                                                      
            name=name,                                                                    
            role=role,                                                                    
            init_sigs=["ready"],                                                  
            resp_sigs=["instr", "pc", "valid"],                                                          
            io_style=io_suffix_style,                                                            
        )

@dataclass(kw_only=True)
class IfuDecTransaction(BaseTransaction):
    ready: int

class IfuDecResponder(BaseDriver):
    async def drive(self, obj: IfuDecTransaction):
        self.io.set("ready", obj.ready)

class IfuJmpIO(BaseIO):
    def __init__(                                                                         
        self,                                                                             
        dut: HierarchyObject,                                                             
        name: str | None,           
        role: IORole,
        io_style = io_suffix_style,
    ) -> None:                                                                            
        super().__init__(                                                                 
            dut=dut,                                                                      
            name=name,                                                                    
            role=role,                                                                    
            init_sigs=["addr_valid", "addr"],                                                  
            resp_sigs=[],                                                          
            io_style=io_suffix_style,                                                            
        )

class IfuFaultIO(BaseIO):
    def __init__(                                                                         
        self,                                                                             
        dut: HierarchyObject,                                                             
        name: str | None,           
        role: IORole,
        io_style = io_suffix_style,
    ) -> None:                                                                            
        super().__init__(                                                                 
            dut=dut,                                                                      
            name=name,                                                                    
            role=role,                                                                    
            init_sigs=[],                                                  
            resp_sigs=["exception", "fault_addr"],                                                          
            io_style=io_suffix_style,                                                            
        )

