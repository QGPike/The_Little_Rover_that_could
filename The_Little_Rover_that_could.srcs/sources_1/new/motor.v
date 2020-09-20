`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2020 05:16:03 PM
// Design Name: 
// Module Name: motor
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


module motor(
    input clk,
    input comparator,
    input [2:0] SW_direction,
    input [2:0] SW_duty,
    output reg [3:0] IN,
    output ENA, ENB
    );
    
    reg [17:0] duty = 0; //this is the speed
    wire reset;
    assign reset = comparator;
    
    always @ (posedge clk) begin
    
        // Case statement for direction
        casex(SW_direction)
                      //IN: 4321    //motor direction permutations ([motorB],[motorA]:
            3'bxx0: IN = 4'b0000;   // off (no movement)
            3'b001: IN = 4'b0110;   // back,back
            3'b011: IN = 4'b0101;   // back,front
            3'b101: IN = 4'b1010;   // front,back
            3'b111: IN = 4'b1001;   // front,front
            default: IN = 4'b0000;
        endcase
        
        // Case statements for duty cycle
        casex(SW_duty)
            3'bxx0: duty = 18'd0;      // 0% duty cycle
            3'bxx1: duty = 18'd130000; // ~50% duty cycle
            3'bx1x: duty = 18'd200000; // ~76% duty cycle
            3'b1xx: duty = 18'd262100; // ~100% duty cycle
            default: duty = 18'd262100; // ~100% duty cycle
        endcase
    end
    
    pwm ena(clk, reset, duty, ENA);
    pwm enb(clk, reset, duty, ENB);
    
endmodule
