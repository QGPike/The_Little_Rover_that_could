module pwm(
    input clk,
    input reset,
    input [17:0] duty,
    output drive
    );

reg [17:0] period = 0;

assign drive = (period >= duty) ? 0 : 1;		// PWM output
		// signal for end of cycle

always @(posedge clk)
	begin
		if(reset)
			period <= duty + 1;
		else
			period <= period + 1;
	end

endmodule