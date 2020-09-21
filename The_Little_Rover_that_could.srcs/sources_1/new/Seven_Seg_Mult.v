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
input clk, reset, JA9, JA10, // comparator sends active high when OL, connected to ports 9&10 on JA
// input [3:0] in0, in1, in2, in3,  //the 4 inputs for each display
output a, b, c, d, e, f, g, dp, //the individual LED output for the seven segment along with the digital point
output [3:0] an   // the 4 bit enable signal
 );

localparam N = 18;

reg [N-1:0]count; //the 18 bit counter which allows us to multiplex at 1000Hz

always @ (posedge clk or posedge reset)
 begin
  if (reset)
   count <= 0;
  else
   count <= count + 1;
 end

reg [6:0]sseg; //the 7 bit register to hold the data to output
reg [3:0]an_temp; //register for the 4 bit enable
reg reset_reg = 0;
// assign off = reset_reg;


always @ (posedge clk)
 begin
  case(count[N-1:N-2]) //using only the 2 MSB's of the counter 
   
   //Fourth Digit//
   2'b00 :  //When the 2 MSB's are 00 enable the fourth display
    begin
     sseg = 4'd11; // -
     an_temp = 4'b1110;
    end
   
   //Third Digit//
   2'b01:  //When the 2 MSB's are 01 enable the third display
    begin
    if  ((JA9 || JA10) && reset) begin
     reset_reg = 0;
     sseg = 4'd11;
    end

    else if (JA9 || JA10) begin //Switches the displayed character when OL is sent from Comparator
       sseg = 4'd10; //L
       reset_reg = 1;
     end
     else begin
          if (reset_reg == 1) begin
            if (reset) begin
              reset_reg = 0;
              sseg = 4'd11; // -
            end
            // else begin
            // sseg = 4'd10; //L
            // reset_reg = !(reset);
            // end
          end
          // else begin
          //   // sseg = 4'd11; // -
          //   //reset_reg = reset_reg;
          // end
      end
      // if (reset_reg == 0) begin //New lines to test
      //   sseg = 4'd11; // -
      // end 
     an_temp = 4'b1101;
    end
   
   //Second Digit//
   2'b10:  //When the 2 MSB's are 10 enable the second display
    begin
      if  ((JA9 || JA10) && reset) begin
       reset_reg = 0;
       sseg = 4'd11;
      end
      else if (JA9 || JA10) begin //Switches the displayed character when OL is sent from Comparator
       sseg = 4'd0; //0
       reset_reg = 1;
      end
      else begin
          if (reset_reg == 1) begin
            if (reset == 1) begin
              reset_reg = 0;
              sseg = 4'd11; // -
            end
            // else begin
            // sseg = 4'd10; //L
            // reset_reg = !(reset);
            // end
          end
          // else begin
          //   // sseg = 4'd11; // -
          //   //reset_reg = reset_reg;
          // end
      end
      // if (reset_reg == 0) begin //New lines to test
      //   sseg = 4'd11; // -
      // end 
     an_temp = 4'b1011;
    end
    
    //First Digit//
   2'b11:  //When the 2 MSB's are 11 enable the first display
    begin
     sseg = 4'd11; // -
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
   default : sseg_temp = 7'b0111111; //dash
  endcase
 end
assign {g, f, e, d, c, b, a} = sseg_temp; //concatenate the outputs to the register, this is just a more neat way of doing this.
// I could have done in the case statement: 4'd0 : {g, f, e, d, c, b, a} = 7'b1000000; 
// its the same thing.. write however you like it

assign dp = 1'b1; //since the decimal point is not needed, all 4 of them are turned off

endmodule