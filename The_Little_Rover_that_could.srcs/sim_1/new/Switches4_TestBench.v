`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2020 03:11:56 PM
// Design Name: 
// Module Name: Switches4_TestBench
// Project Name: 
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


module Switches4_TestBench(
    );

    reg SW0;
    reg SW1;
    reg SW2;
    reg SW3;
    wire LED0;
    wire LED1;
    wire LED2;
    wire LED3;

    // Instantiation
    Switches4 UUT (SW0,SW1,SW2,SW3,LED0,LED1,LED2,LED3);

    initial begin
    SW0=0;
    SW1=0;
    SW2=0;
    SW3=0;
    #100;

    SW0=1;
    SW1=0;
    SW2=0;
    SW3=0;
    #100;

    SW0=0;
    SW1=1;
    SW2=0;
    SW3=0;
    #100;

    SW0=0;
    SW1=0;
    SW2=1;
    SW3=0;
    #100;

    SW0=0;
    SW1=0;
    SW2=0;
    SW3=1;
    #100;
    end

endmodule
