`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TTU ECE 3331 Project Lab 1
// Engineer: Ahmed Bayoumi
// 
// Create Date: 09/16/2020 05:16:03 PM
// Module Name: motor
// Description: 
// 
// Dependencies: inputs from external circuitry (comparator), outputs from pwm.v
// 
// Revision:
// Revision 0.01 - File Created: copied old code with input, outputs, procedural
//  block (always @ (posedge clk)), case statements for switches, instantiated
//  pwm.v
// Revision 1.00 - 9/18/20: reviewed with Akhil and implemented MUX idea (scan is
//  in G-Drive). Errors popped. NEED FURTHER REVISION
// Revision 1.01 - 9/19/20: revamped the following; inputs to be an array reg,
//  switch cases to have don't cares, case to casex statements for don't cares,
//  duty cycle to 0, 50, 76, and 100% only
//  Changed some syntax and added comments
// Revision 1.02 - 9/19/20 (late at night): included if statement for reset logic.
// Revision 1.03 - 9/20/20: changed syntax for enb instantiation to call ports by
//  name. Changed order of casex(SW_duty) statement. Incorporated 2nd comparator
//  input
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module motor( clk, comparatorA, comparatorB, reset_button, SW_direction, SW_duty,
IN, ENA, ENB );
//-------------------------------Input Ports--------------------------------------
    input clk;
    input comparatorA, comparatorB;
    input reset_button;
    input [2:0] SW_direction;
    input [2:0] SW_duty;
//-------------------------------Output Ports-------------------------------------
    output reg [3:0] IN;
    output ENA, ENB;
//-------------------------------Internal Variables-------------------------------   
    reg [17:0] duty = 0; //this is the speed
    reg reset_reg;
//-------------------------------Code Starts Here---------------------------------
    assign off = reset_reg; // wire connection to reset logic (explained below)
    // reset_reg is set to 1 once comparator is 1. At every other following
    // iteration it is reset to 1 if comparator is still 1 or it awaits button
    // press for reset_reg to be 0 
    always @ (posedge clk) begin
        if (comparatorA || comparatorB) begin
            reset_reg = 1;
        end
        else begin
            if (reset_reg == 1) begin
                reset_reg = !(reset_button);
            end
            else begin
                reset_reg = reset_reg;
            end
        end
    end
    
    always @ (posedge clk) begin
    
        // Case statement for direction
        casex(SW_direction)
        //Corresponding IN: 4321    //motor direction permutations ([motorB],[motorA]:
            3'bxx0: IN = 4'b0000;   // off (no movement)
            3'b001: IN = 4'b0110;   // back,back
            3'b011: IN = 4'b0101;   // back,front
            3'b101: IN = 4'b1010;   // front,back
            3'b111: IN = 4'b1001;   // front,front
            default: IN = 4'b0000;
        endcase
        
        // Case statements for duty cycle
        casex(SW_duty)
            3'b1xx: duty = 18'd262100; // ~100% duty cycle
            3'bx1x: duty = 18'd200000; // ~76% duty cycle
            3'bxx1: duty = 18'd130000; // ~50% duty cycle
            3'bxx0: duty = 18'd0;      // 0% duty cycle
            default: duty = 18'd262100; // ~100% duty cycle
        endcase
    end
    
    pwm ena( .clk(clk), .off(off), .duty(duty), .drive(ENA));
    pwm enb( .clk(clk), .off(off), .duty(duty), .drive(ENB));
    
endmodule
