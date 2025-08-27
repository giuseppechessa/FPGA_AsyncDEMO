`timescale 1ns/1ps

module PacketRouteSelector
#(
	parameter WIDTH = 16, // larghezza del bundled data.
	parameter PORTS_G =4,
	parameter PORTS_L =1,
	parameter LocationX=0,
	parameter LocationY=0,
	parameter BUFNUM=0
)
(
	input PRC_req,
	input [WIDTH-1:0] Data_i,
	input PRC_ack,
	output[PORTS_G+PORTS_L-1:0] Rsel
);
	logic req;
	logic PRC_enable;
	logic [PORTS_G+PORTS_L-1:0] Rout;
	(*  DONT_TOUCH = "yes" *) LUT2 #(.INIT(4'h6)) XOR(.O(PRC_enable),.I0(req), .I1(PRC_ack));
	
	genvar i;
	generate 
	if(BUFNUM==0)
		assign req = PRC_req;
	else if (BUFNUM==1)
		(* DONT_TOUCH*)  LUT1 #(.INIT(2'b10)) PRCBuf(.O(req),.I0(PRC_req));
	else begin
		logic[BUFNUM-1:0] InterCavi;
		(* DONT_TOUCH*)  LUT1 #(.INIT(2'b10)) PRCBufInit(.O(InterCavi[0]),.I0(PRC_req));
		(* DONT_TOUCH*)  LUT1 #(.INIT(2'b10)) PRCBufFine(.O(req), .I0(InterCavi[BUFNUM-1]) );
		for(i=1;i<BUFNUM;i=i+1) begin
			(* DONT_TOUCH*)  LUT1 #(.INIT(2'b10)) PRCBuf(.O(InterCavi[i]),.I0(InterCavi[i-1]));
		end
	end
	endgenerate


	
	generate 
		for(i=0;i<PORTS_G+PORTS_L;i=i+1) begin
			(*  DONT_TOUCH = "yes" *) LUT2 #(.INIT(4'h8)) RouteAnd(.O(Rsel[i]),.I0(PRC_enable), .I1(Rout[i]));
		end
	endgenerate
	
	logic isHead, E,W,N,S,Loc;
	logic [3:0] x_dest,y_dest; logic [2:0] l_dest;
	logic [10:0] PacketAddress;
	assign isHead = Data_i[0] == 1'b1; // 01 -> head, 10 -> tail, 00 -> body
	assign PacketAddress = Data_i[12:2]; // {0, Address:11 bit, FlitType:2 bit}
	assign {x_dest,y_dest,l_dest} = PacketAddress;
	
	assign E = x_dest>LocationX;
  assign W = x_dest<LocationX;
  assign N = (y_dest>LocationY)  && (LocationX == x_dest);
  assign S = (y_dest<LocationY)  && (LocationX == x_dest);
  assign Loc = (LocationY == y_dest) && (LocationX == x_dest);

  assign Rout = isHead ? {Loc,E,S,W,N}  : 4'd0;
endmodule
