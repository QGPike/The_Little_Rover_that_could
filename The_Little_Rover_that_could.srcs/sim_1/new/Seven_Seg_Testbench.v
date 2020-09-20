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

    reg clock, reset;
    reg [3:0] in0, in1, in2, in3;  //the 4 inputs for each display
    wire a, b, c, d, e, f, g, dp; //the individual LED output for the seven segment along with the digital point
    wire [3:0] an;   // the 4 bit enable signal

    Seven_Seg_Mult UUT (clock, reset, in0, in1, in2, in3, a, b, c, d, e, f, g, dp, an);

    initial begin
        clock = 0;
        reset = 0;
        in0 = 0;
        in1 = 0;
        in2 = 0;
        in3 = 0;

        #100;

        in0 = 2;
        in1 = 0;
        in2 = 0;
        in3 = 0;

        #100;

        in0 = 0;
        in1 = 9;
        in2 = 0;
        in3 = 0;

        #100;

        in0 = 0;
        in1 = 0;
        in2 = 0;
        in3 = 7;

        #100;

        in0 = 1;
        in1 = 2;
        in2 = 3;
        in3 = 4;

    end

    always begin
    #5 clock =~ clock;
    end

endmodule
