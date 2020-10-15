`timescale 1ns / 1ps

module top # ( WI1 = 2, WF1 = 6,
               WI2 = 2, WF2 = 6,
               WIO = 2, WFO = 6 )
(
    input CLK
);
    reg [7 : 0] h_n[0 : 2];
    reg [7 : 0] x_n[0 : 3];
    initial begin $readmemb("h_n.mem", h_n); $readmemb("x_n.mem", x_n); end
    
    
    
    
    
    
endmodule
