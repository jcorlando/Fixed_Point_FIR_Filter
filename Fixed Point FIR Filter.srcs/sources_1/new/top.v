`timescale 1ns / 1ps

module top # ( WIX = 2, WFX = 6,
               WIH = 2, WFH = 6,
               WLX = WIX + WFX  )
(
    input CLK
);
    reg [7 : 0] x_n[0 : 3];
    reg [7 : 0] h_n[0 : 2];
    reg [1 : 0] counter = 0;
    initial begin $readmemb("h_n.mem", h_n); $readmemb("x_n.mem", x_n); end
    
    always @ (posedge CLK) if(counter < 3) counter <= counter + 1;
    
    delay_register # ( .WL(WLX) ) delay_1( .CLK(CLK), .in(x_n[counter]) );
    delay_register # ( .WL(WLX) ) delay_2( .CLK(CLK), .in(delay_1.out) );
    
    mult_Fixed # ( .WI1(WIX), .WF1(WFX), .WI2(WIH), .WF2(WFH) )
    h1( .in1(x_n[counter]), .in2(h_n[0]) );
    
    mult_Fixed # ( .WI1(WIX), .WF1(WFX), .WI2(WIH), .WF2(WFH) )
    h2( .in1(delay_1.out), .in2(h_n[1]) );
    
    mult_Fixed # ( .WI1(WIX), .WF1(WFX), .WI2(WIH), .WF2(WFH) )
    h3( .in1(delay_2.out), .in2(h_n[2]) );
    
    add_Fixed # ( .WI1(WIX + WIH), .WF1(WFX + WFH), .WI2(WIX + WIH), .WF2(WFX + WFH) )
    h0_h1_adder( .in1(h1.out), .in2(h2.out) );
    
    add_Fixed # ( .WI1(WIX + WIH + 1), .WF1(WFX + WFH), .WI2(WIX + WIH), .WF2(WFX + WFH) )
    h1_h2_adder( .in1(h0_h1_adder.out), .in2(h2.out) );
    
    
endmodule
