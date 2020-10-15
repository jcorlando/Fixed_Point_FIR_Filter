`timescale 1ns / 1ps

module tb_top;
    
    reg CLK = 0;
    // Initialize clock
    always #50 CLK <= ~CLK;
    
    top DUT( .CLK(CLK) );
    
    
    
endmodule
