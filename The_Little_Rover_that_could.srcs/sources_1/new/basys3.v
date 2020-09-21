`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TTU ECE 3331 Project Lab 1
// Engineer: Ahmed Bayoumi, Quinn Pike
// 
// Create Date: 09/19/2020 02:31:59 PM
// Module Name: basys3
// Description:
//      Top module simulating entire basys3 board with all I/O pins used.
//  Instantiates all other modules
// 
// Dependencies: motor.v; pwm.v
// 
// Revision:
// Revision 0.01 - File Created: test code (turn on LEDs) implemented
// Revision 1.00 - 9/19/20: Instantiated modules (motor and pwm); added LEDs that
//  light up when switches or comparator is logic HIGH (as an indicator)
// Revision 1.01 - 9/20/20: incorporated 2nd comparator input as JA9 with its own
//  LED (LED14)
// Revision 1.02 - 9/20/20: Added support for SSeg
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module basys3( CLK100MHZ, sw, JA9, JA10, btnC, JA, LED, LED14, LED15, seg, an, dp);
//-------------------------------Input Ports--------------------------------------
    input CLK100MHZ;
    input [5:0] sw;
    input JA9, JA10;
    input btnC;
//-------------------------------Output Ports-------------------------------------
    //output JA,
    output [5:0] JA;
    output [5:0] LED;
    output LED14;
    output LED15;
    output [6:0] seg;
    output [3:0] an;
    output dp;
//-------------------------------Code Starts Here---------------------------------
    // LED indicating when switches or comparator is high
    assign LED = sw;
    assign LED14 = JA9;
    assign LED15 = JA10;
    
    motor motorAB( .clk(CLK100MHZ), .comparatorA(JA9), .comparatorB(JA10),
    .reset_button(btnC), .SW_direction(sw[2:0]), .SW_duty(sw[5:3]), .IN(JA[3:0]),
    .ENA(JA[4]), .ENB(JA[5]) );

    Seven_Seg_Mult SevSeg(.clk(CLK100MHZ), .reset(btnC), .JA9(JA9), .JA10(JA10),
    .a(seg[0]), .b(seg[1]), .c(seg[2]), .d(seg[3]), .e(seg[4]), .f(seg[5]), 
    .g(seg[6]), .an(an[3:0]), .dp(dp));

    // dp  .dp(dp),
    
endmodule
