`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2020 01:29:57 PM
// Design Name: 
// Module Name: Seven_Seg_Testbench
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


module Seven_Seg_Testbench(
    );

    reg clock, reset, b1;
    reg [3:0] in0, in1, in2, in3;  //the 4 inputs for each display
    wire a, b, c, d, e, f, g, dp; //the individual LED output for the seven segment along with the digital point
    wire [3:0] an;   // the 4 bit enable signal

    Seven_Seg_Mult UUT (clock, reset, in0, in1, in2, in3, b1, a, b, c, d, e, f, g, dp, an);

    initial begin
        clock = 0;
        reset = 0;
        in0 = 0;
        in1 = 0;
        in2 = 0;
        in3 = 0;

        #100;

        b1 = 1;


    end

    always begin
    #5 clock =~ clock;
    end

endmodule
