`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2020 06:37:52 PM
// Design Name: 
// Module Name: Switches4
// Project Name: Test
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Switches4(
    input SW0,
    input SW1,
    input SW2,
    input SW3,
    output LED0,
    output LED1,
    output LED2,
    output LED3
    );
    
    assign LED0 = SW0;
    assign LED1 = SW1;
    assign LED2 = SW2;
    assign LED3 = SW3;
    
endmodule
