`timescale 1ns/1ps

module net 
#(
	parameter WIDTH = 32, // larghezza del bundled data.
	parameter PORTS_G =4,
	parameter PORTS_L =1
)
(
	input   [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0]	          req_up_i,
	input   [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0][WIDTH-1:0] Data_up_i,
	output  [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0]            ack_up_o,
	output 	[PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0]            Tailpassed_up_o,
	input   [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0]            PacketEnable_up_i,

	output   [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0]	          req_dw_o,
	output   [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0][WIDTH-1:0] Data_dw_o,
	input    [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0]            ack_dw_i,
	input 	 [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0]            Tailpassed_dw_i,
	output   [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0]            PacketEnable_dw_o
);

	genvar i,j;
	
	//request generate
	generate
		for(i=0; i< PORTS_G+PORTS_L;i=i+1)
			for(j=0; j< PORTS_G+PORTS_L-1;j=j+1)
			   if(j<i)
					assign req_dw_o[i][j] =  req_up_i[j][i-1];
				else if ( j>= i)
					assign req_dw_o[i][j] =  req_up_i[j+1][i];
	endgenerate
	
	//Data generate
	generate
		for(i=0; i< PORTS_G+PORTS_L;i=i+1)
			for(j=0; j< PORTS_G+PORTS_L-1;j=j+1)
			   if(j<i)
					assign Data_dw_o[i][j] =  Data_up_i[j][i-1];
				else if ( j>= i)
					assign Data_dw_o[i][j] =  Data_up_i[j+1][i];
	endgenerate

  //PacketEnable generate
	generate
		for(i=0; i< PORTS_G+PORTS_L;i=i+1)
			for(j=0; j< PORTS_G+PORTS_L-1;j=j+1)
			   if(j<i)
					assign PacketEnable_dw_o[i][j] =  PacketEnable_up_i[j][i-1];
				else if ( j>= i)
					assign PacketEnable_dw_o[i][j] =  PacketEnable_up_i[j+1][i];
	endgenerate
	
	//ack generate
	generate
		for(i=0; i< PORTS_G+PORTS_L;i=i+1)
			for(j=0; j< PORTS_G+PORTS_L-1;j=j+1)
			   if(j<i)
					assign ack_up_o[i][j] =  ack_dw_i[j][i-1];
				else if ( j>= i)
					assign ack_up_o[i][j] =  ack_dw_i[j+1][i];
	endgenerate
	
	//TailPassed generate
	generate
		for(i=0; i< PORTS_G+PORTS_L;i=i+1)
			for(j=0; j< PORTS_G+PORTS_L-1;j=j+1)
			   if(j<i)
					assign Tailpassed_up_o[i][j] =  Tailpassed_dw_i[j][i-1];
				else if ( j>= i)
					assign Tailpassed_up_o[i][j] =  Tailpassed_dw_i[j+1][i];
	endgenerate
endmodule
