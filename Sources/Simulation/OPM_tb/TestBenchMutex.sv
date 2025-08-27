`timescale 1ns / 1ps

module TestbenchMutex();
	localparam WIDTH = 4;
	logic clk,reset;
	logic [WIDTH-1:0] in,out;
	Mutex MyMutex(in,reset,out);
	assign clk = ~clk;
	
	initial begin
	  clk = 1'b0;
		reset = 1'b1;
		in = 4'd0;
		#100
		reset = 1'b0;
		#10
		in=4'b0001;
		#10
		in=4'b1001;
		#10;
		in = 4'b1100;
	end
	
endmodule
