`timescale 1ns/1ps

module ipm 
#(
	parameter WIDTH = 32, // larghezza del bundled data.
	parameter PORTS_G =4,
	parameter PORTS_L =1,
	parameter LOCALPORT=1,
	parameter POS = 0,
	parameter LocationX=2,
	parameter LocationY=2
)
(
	input 							 reset,
	input 							 gen_enable,
	
	input								 req_up_i,
	input    [WIDTH-1:0] Data_up_i,
	output 							 ack_up_o,

	output   [PORTS_G+PORTS_L-2:0]	           req_dw_o,
	output   [PORTS_G+PORTS_L-2:0][WIDTH-1:0] Data_dw_o,
	input    [PORTS_G+PORTS_L-2:0]            ack_dw_i,
	input 	 [PORTS_G+PORTS_L-2:0]            Tailpassed_dw_i,
	output   [PORTS_G+PORTS_L-2:0]            PacketEnable_dw_o
	);
	genvar i;
	logic req,ack;
	logic[WIDTH-1:0] Data;
	logic[PORTS_G+PORTS_L-1:0] Rsel;
  assign ack = ack_dw_i[0]^ack_dw_i[1]^ack_dw_i[2]^ack_dw_i[3];
	logic nc;
	(* DONT_TOUCH = "yes"*) mousetrap_ldce_woMacros#(WIDTH) input_pipe(reset,gen_enable,req_up_i,Data_up_i,ack_up_o,req,Data,ack,nc);	
	generate
	 for(i=0;i<PORTS_G+PORTS_L-1;i=i+1)
	   assign Data_dw_o[i] = Data;
	endgenerate
	 (* DONT_TOUCH = "yes"*) PacketRouteSelector#(WIDTH,PORTS_G,PORTS_L,LocationX,LocationY) PRC(req,Data,ack,Rsel);
	 
	
	
  generate
   if (LOCALPORT == 1) begin
      for(i=0;i<PORTS_G;i=i+1)
         (* DONT_TOUCH = "yes"*) RequestGenerator#(i, PORTS_G+PORTS_L-1) ReqGen(reset,req,ack_dw_i,Rsel[i], Tailpassed_dw_i[i],req_dw_o[i], PacketEnable_dw_o[i]);
      for(i=0;i<POS;i=i+1)
        (* DONT_TOUCH = "yes"*) RequestGenerator#(PORTS_G+i, PORTS_G+PORTS_L-1) ReqGen(reset,req,ack_dw_i,Rsel[PORTS_G+i], Tailpassed_dw_i[PORTS_G+i],req_dw_o[PORTS_G+i], PacketEnable_dw_o[PORTS_G+i]);
      for(i=POS+1;i<PORTS_L;i=i+1)
         (* DONT_TOUCH = "yes"*) RequestGenerator#(PORTS_G-1+i, PORTS_G+PORTS_L-1) ReqGen(reset,req,ack_dw_i,Rsel[PORTS_G+i], Tailpassed_dw_i[PORTS_G+i-1],req_dw_o[PORTS_G+i-1], PacketEnable_dw_o[PORTS_G+i-1]);
    end
    else if (LOCALPORT == 0) begin
      for(i=0;i<POS;i=i+1)
         (* DONT_TOUCH = "yes"*) RequestGenerator#(i, PORTS_G+PORTS_L-1) ReqGen(reset,req,ack_dw_i,Rsel[i], Tailpassed_dw_i[i],req_dw_o[i], PacketEnable_dw_o[i]);
      for(i=POS+1;i<PORTS_G;i=i+1)
        (* DONT_TOUCH = "yes"*) RequestGenerator#(i-1, PORTS_G+PORTS_L-1) ReqGen(reset,req,ack_dw_i,Rsel[i], Tailpassed_dw_i[i-1],req_dw_o[i-1], PacketEnable_dw_o[i-1]);
      for(i=0;i<PORTS_L;i=i+1)
         (* DONT_TOUCH = "yes"*) RequestGenerator#(PORTS_G-1+i, PORTS_G+PORTS_L-1) ReqGen(reset,req,ack_dw_i,Rsel[PORTS_G+i], Tailpassed_dw_i[PORTS_G-1+i],req_dw_o[PORTS_G-1+i], PacketEnable_dw_o[PORTS_G-1+i]);
    end
  endgenerate
	
endmodule



