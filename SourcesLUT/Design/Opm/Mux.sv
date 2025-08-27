`timescale 1ns/1ps

module Mux #(
	parameter WIDTH=32,
	parameter DIMENSION=4
)(
	input    [DIMENSION-1:0] PacketEnable_dw_o,
	input   [DIMENSION-1:0] [WIDTH-1:0] Data_up_i,
	output [WIDTH-1:0] MuxOutput
);

logic [DIMENSION-1:0][WIDTH-1:0] MuxOutputs;
assign MuxOutputs[0] = PacketEnable_dw_o[0] ? Data_up_i[0] : {(WIDTH){1'd0}};
assign MuxOutput = MuxOutputs[DIMENSION-1];
genvar i;
generate
	for (i=1; i<DIMENSION; i=i+1) begin
	 assign MuxOutputs[i] = PacketEnable_dw_o[i] ? Data_up_i[i] : MuxOutputs[i-1];
	end 
endgenerate

endmodule
