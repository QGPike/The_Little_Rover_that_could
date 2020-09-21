`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TTU ECE 3331 Project Lab 1
// Engineer: Ahmed Bayoumi
// 
// Create Date: 09/16/2020 02:31:59 PM
// Module Name: pwm
// Description: 
//      PWM signal module that modulates an output signal (drive) using a duty
//  cycle defined by the upper module's (motor.v) input values. Also offs motor
//  using comparator input from motor.v
// Dependencies: input from motor.v
// 
// Revision:
// Revision 0.01 - File Created: copied old files with input, outputs, procedural
//  block (always @ (posedge clk))
// Revision 1.00 - 9/19/20: added comments
// Revision 1.01 - 9/19/20 (late at night): changed reset to off (as per changes 
//  in motor.v module
// Revision 1.02 - 9/20/20: commented out the off statements to test pwm_tb.
//  Uncommented again (did it work?!)
// Additional Comments:
//  9/19/200 (late at night): this off algorithm might fail...
//////////////////////////////////////////////////////////////////////////////////


module pwm( clk, off, duty, drive);
//-------------------------------Input Ports--------------------------------------
    input clk;
    input off; // coming from comparator in the top module
    input [17:0] duty; // coming from switches casex in top module 
//-------------------------------Output Ports-------------------------------------
    output drive; // PWM to drive enables
//-------------------------------Internal Variables-------------------------------   
    reg [17:0] period = 18'b0; // used as counter
//-------------------------------Code Starts Here---------------------------------
    assign drive = (period >= duty) ? 0 : 1; // HIGH as long as period < duty values
    
    always @(posedge clk) // incorporating off, i.e if (off) then period > duty
        begin
            if(off)
                period <= duty + 1;
            else
                period <= period + 1;
        end
    
endmodule