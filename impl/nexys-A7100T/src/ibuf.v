(* blackbox *)                         
module IBUF(                           
    output O,                          
    input I);                          
  parameter CCIO_EN = "TRUE";          
  parameter CAPACITANCE = "DONT_CARE"; 
  parameter IBUF_DELAY_VALUE = "0";    
  parameter IBUF_LOW_PWR = "TRUE";     
  parameter IFD_DELAY_VALUE = "AUTO";  
  parameter IOSTANDARD = "DEFAULT";    
endmodule                              

