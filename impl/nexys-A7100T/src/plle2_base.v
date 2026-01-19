(* blackbox *)                                
module PLLE2_BASE (                           
    output CLKFBOUT,                          
    output CLKOUT0,                           
    output CLKOUT1,                           
    output CLKOUT2,                           
    output CLKOUT3,                           
    output CLKOUT4,                           
    output CLKOUT5,                           
    output LOCKED,                            
    input CLKFBIN,                            
    input CLKIN1,                             
    input PWRDWN,                             
    input RST                                 
);                                            
    parameter BANDWIDTH = "OPTIMIZED";        
    parameter CLKFBOUT_MULT = 5;      
    parameter CLKFBOUT_PHASE = 0.000;    
    parameter CLKIN1_PERIOD = 0.000;     
    parameter CLKOUT0_DIVIDE = 1;     
    parameter CLKOUT0_DUTY_CYCLE = 0.500;
    parameter CLKOUT0_PHASE = 0.000;     
    parameter CLKOUT1_DIVIDE = 1;     
    parameter CLKOUT1_DUTY_CYCLE = 0.500;
    parameter CLKOUT1_PHASE = 0.000;     
    parameter CLKOUT2_DIVIDE = 1;     
    parameter CLKOUT2_DUTY_CYCLE = 0.500;
    parameter CLKOUT2_PHASE = 0.000;     
    parameter CLKOUT3_DIVIDE = 1;     
    parameter CLKOUT3_DUTY_CYCLE = 0.500;
    parameter CLKOUT3_PHASE = 0.000;     
    parameter CLKOUT4_DIVIDE = 1;     
    parameter CLKOUT4_DUTY_CYCLE = 0.500;
    parameter CLKOUT4_PHASE = 0.000;     
    parameter CLKOUT5_DIVIDE = 1;     
    parameter CLKOUT5_DUTY_CYCLE = 0.500;
    parameter CLKOUT5_PHASE = 0.000;     
    parameter DIVCLK_DIVIDE = 1;      
    parameter REF_JITTER1 = 0.010;       
    parameter STARTUP_WAIT = "FALSE";         
endmodule                                     

