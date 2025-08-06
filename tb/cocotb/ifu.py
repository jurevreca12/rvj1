from forastero import BaseIO 
from forastero.io import IORole 
from cocotb.handle import HierarchyObject

def my_io_style():
    ...

class InstrMemIf(BaseIO): # W: Missing class docstring # W: Too few public methods (0/2)    
    def __init__(                                                                         
        self,                                                                             
        dut: HierarchyObject,                                                             
        name: str | None,           
        role: IORole,
        io_style = None,
    ) -> None:                                                                            
        super().__init__(                                                                 
            dut=dut,                                                                      
            name=name,                                                                    
            role=role,                                                                    
            init_sigs=["gnt", "rvalid", "rdata", "err"],                                                  
            resp_sigs=["req", "addr"],                                                          
            io_style=io_style,                                                            
        )                                                                                 

class IfuDecIf(BaseIO): # W: Missing class docstring # W: Too few public methods (0/2)    
    def __init__(                                                                         
        self,                                                                             
        dut: HierarchyObject,                                                             
        name: str | None,           
        role: IORole,
        io_style = None,
    ) -> None:                                                                            
        super().__init__(                                                                 
            dut=dut,                                                                      
            name=name,                                                                    
            role=role,                                                                    
            init_sigs=["instr", "pc", "valid"],                                                  
            resp_sigs=["ready"],                                                          
            io_style=io_style,                                                            
        )

class IfuJmpIf(BaseIO):
    def __init__(                                                                         
        self,                                                                             
        dut: HierarchyObject,                                                             
        name: str | None,           
        role: IORole,
        io_style = None,
    ) -> None:                                                                            
        super().__init__(                                                                 
            dut=dut,                                                                      
            name=name,                                                                    
            role=role,                                                                    
            init_sigs=[],                                                  
            resp_sigs=["addr_valid", "addr"],                                                          
            io_style=io_style,                                                            
        )

class IfuFaultIf(BaseIO):
    def __init__(                                                                         
        self,                                                                             
        dut: HierarchyObject,                                                             
        name: str | None,           
        role: IORole,
        io_style = None,
    ) -> None:                                                                            
        super().__init__(                                                                 
            dut=dut,                                                                      
            name=name,                                                                    
            role=role,                                                                    
            init_sigs=["exception", "fault_addr"],                                                  
            resp_sigs=[],                                                          
            io_style=io_style,                                                            
        )