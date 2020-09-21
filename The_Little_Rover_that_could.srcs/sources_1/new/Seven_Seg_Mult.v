`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: TTU ECE 3331 Project Lab 1
// Engineer: Quinn Pike
// 
// Create Date: 09/17/2020 01:26:20 PM
// Module Name: Seven_Seg_Mult
// Project Name: The little Rover that could
// Target Devices: Basys 3
// Description: Runs the 7 segment, defaults to all dashes, shows 0L when overload is sent from comparator
// 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Seven_Seg_Mult(
input clk, sw0, sw1, sw2, JA9, JA10, // comparator sends active high when OL, connected to ports 9&10 on JA
// input [3:0] in0, in1, in2, in3,  //the 4 inputs for each display
output a, b, c, d, e, f, g, dp, //the individual LED output for the seven segment along with the digital point
output [3:0] an   // the 4 bit enable signal
 );

localparam N = 18;

reg [N-1:0]count; //the 18 bit counter which allows us to multiplex at 1000Hz

always @ (posedge clk or posedge sw0)
 begin
  if (!sw0)
   count <= 0;
  else
   count <= count + 1;
 end

reg [6:0]sseg; //the 7 bit register to hold the data to output
reg [3:0]an_temp; //register for the 4 bit enable
reg reset_reg;
// assign off = reset_reg;


always @ (posedge clk)
 begin
  case(count[N-1:N-2]) //using only the 2 MSB's of the counter 
   
   //Fourth Digit//
   2'b00 :  //When the 2 MSB's are 00 enable the fourth display
    begin
    if (sw1 && sw0) begin
      sseg = 4'd12;
    end
    else if (!sw1 && sw0) begin
      sseg = 4'd11;
    end
    else begin
      sseg = 4'd13;
    end
     an_temp = 4'b1110;
    end
   
   //Third Digit//
   2'b01:  //When the 2 MSB's are 01 enable the third display
   begin
      if (reset_reg == 1) begin 
       sseg = 4'd10;
       reset_reg = (sw0) ? 1 : 0;
      end
      else if (reset_reg == 0) begin
          if (JA9 || JA10) begin
          sseg = 4'd10;
          reset_reg = 1;
          end
          else begin
          sseg = 4'd13;
          reset_reg = 0;
          end
      end
     an_temp = 4'b1101;
    end

   //Second Digit//
   2'b10:  //When the 2 MSB's are 10 enable the second display
    begin
      if (reset_reg == 1) begin 
       sseg = 4'd0;
       reset_reg = (sw0) ? 1 : 0;
      end
      else if (reset_reg == 0) begin
          if (JA9 || JA10) begin
          sseg = 4'd0;
          reset_reg = 1;
          end
          else begin
          sseg = 4'd13;
          reset_reg = 0;
          end
      end
     an_temp = 4'b1011;
    end
    
    //First Digit//
   2'b11:  //When the 2 MSB's are 11 enable the first display
   begin
    if (sw2 && sw0) begin
      sseg = 4'd12;
    end
    else if (!sw2 && sw0) begin
      sseg = 4'd11;
    end
    else begin
      sseg = 4'd13;
    end
     an_temp = 4'b0111;
   end
  endcase
 end
assign an = an_temp;


reg [6:0] sseg_temp; // 7 bit register to hold the binary value of each input given

always @ (*)
 begin
  case(sseg)
   4'd0 : sseg_temp = 7'b1000000; //to display 0
   4'd1 : sseg_temp = 7'b1111001; //to display 1
   4'd2 : sseg_temp = 7'b0100100; //to display 2
   4'd3 : sseg_temp = 7'b0110000; //to display 3
   4'd4 : sseg_temp = 7'b0011001; //to display 4
   4'd5 : sseg_temp = 7'b0010010; //to display 5
   4'd6 : sseg_temp = 7'b0000010; //to display 6
   4'd7 : sseg_temp = 7'b1111000; //to display 7
   4'd8 : sseg_temp = 7'b0000000; //to display 8
   4'd9 : sseg_temp = 7'b0010000; //to display 9
   4'd10 : sseg_temp = 7'b1000111; //to display L
   4'd11 : sseg_temp = 7'b0000011; //to display b
   4'd12 : sseg_temp = 7'b0001110; //to display F
   default : sseg_temp = 7'b0111111; //dash
  endcase
 end

//  casex(SW_direction)
//         //Corresponding IN: 4321    //motor direction permutations ([motorB],[motorA]:
//             3'bxx0: IN = 4'b0000;   // off (no movement)
//             3'b001: IN = 4'b0110;   // back,back
//             3'b011: IN = 4'b0101;   // back,front
//             3'b101: IN = 4'b1010;   // front,back
//             3'b111: IN = 4'b1001;   // front,front
//             default: IN = 4'b0000;
//         endcase

assign {g, f, e, d, c, b, a} = sseg_temp; //concatenate the outputs to the register, this is just a more neat way of doing this.
// I could have done in the case statement: 4'd0 : {g, f, e, d, c, b, a} = 7'b1000000; 
// its the same thing.. write however you like it

assign dp = 1'b1; //since the decimal point is not needed, all 4 of them are turned off

endmodule