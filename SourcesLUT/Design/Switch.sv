`timescale 1ns / 1ps

module Switch
#(
	parameter WIDTH = 32, // larghezza del bundled data.=256
	parameter LocationX=2,
	parameter LocationY=2,
	parameter PORTS_G =4,
	parameter PORTS_L =1,
	parameter integer BUFNumber [PORTS_G+PORTS_L-1:0] = {0,0,0,0,0},
	parameter integer BUFNUMIO [PORTS_G+PORTS_L-1:0] = {0,0,0,0,0}
)
(
	input 							 reset,
	input 							 gen_enable,
	
	input    [PORTS_G+PORTS_L-1:0]             req_up_i,
	input    [PORTS_G+PORTS_L-1:0][WIDTH-1:0]  Data_up_i,
	output 	 [PORTS_G+PORTS_L-1:0]					   ack_up_o,

	output   [PORTS_G+PORTS_L-1:0]	           req_dw_o,
	output   [PORTS_G+PORTS_L-1:0][WIDTH-1:0]  Data_dw_o,
	input    [PORTS_G+PORTS_L-1:0]             ack_dw_i
);
    logic [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-1:0] req_outports, ack_outports, PacketEnable_outports,Tailpassed_outports;
    logic [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-1:0][WIDTH-1:0] Data_outports, DataAusiliary;
    logic [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0] req_ipm_o, ack_ipm_i, req_opm_i, ack_opm_o, PacketEn_ipm_o, TailPass_ipm_i, PacketEn_opm_i, TailPass_opm_o;
    logic [PORTS_G+PORTS_L-1:0][PORTS_G+PORTS_L-2:0][WIDTH-1:0] Data_ipm_o, Data_opm_i;
    genvar i;
    generate
    for (i=0;i<PORTS_G;i++)
      (* DONT_TOUCH = "yes"*) ipm#(WIDTH,PORTS_G,PORTS_L,0,i,LocationX,LocationY,BUFNumber[i]) IPMS(reset,gen_enable, req_up_i[i],Data_up_i[i],ack_up_o[i],req_ipm_o[i],Data_ipm_o[i],ack_ipm_i[i],TailPass_ipm_i[i],PacketEn_ipm_o[i]);
    for (i=0;i<PORTS_L;i++)
      (* DONT_TOUCH = "yes"*) ipm#(WIDTH,PORTS_G,PORTS_L,1,i,LocationX,LocationY,BUFNumber[PORTS_G+i]) IPMS(reset,gen_enable, req_up_i[PORTS_G+i],Data_up_i[PORTS_G+i],ack_up_o[PORTS_G+i],req_ipm_o[PORTS_G+i],Data_ipm_o[PORTS_G+i],ack_ipm_i[PORTS_G+i],TailPass_ipm_i[PORTS_G+i],PacketEn_ipm_o[PORTS_G+i]);
    endgenerate
    
    net#(WIDTH,PORTS_G,PORTS_L) Interconnet(req_ipm_o,Data_ipm_o,ack_ipm_i,TailPass_ipm_i,PacketEn_ipm_o,req_opm_i,Data_opm_i,ack_opm_o,TailPass_opm_o,PacketEn_opm_i);
    
    generate
    for (i=0;i<PORTS_G;i++)
      (* DONT_TOUCH = "yes"*) opm#(WIDTH,PORTS_G+PORTS_L-1,BUFNUMIO[i]) OPMS(reset,gen_enable,req_opm_i[i],Data_opm_i[i],ack_opm_o[i],req_dw_o[i],Data_dw_o[i],ack_dw_i[i],PacketEn_opm_i[i],TailPass_opm_o[i]);
    for (i=0;i<PORTS_L;i++)
      (* DONT_TOUCH = "yes"*) opm#(WIDTH,PORTS_G+PORTS_L-1,BUFNUMIO[PORTS_G+i]) OPMS(reset,gen_enable,req_opm_i[PORTS_G+i],Data_opm_i[PORTS_G+i],ack_opm_o[PORTS_G+i],req_dw_o[PORTS_G+i],Data_dw_o[PORTS_G+i],ack_dw_i[PORTS_G+i],PacketEn_opm_i[PORTS_G+i],TailPass_opm_o[PORTS_G+i]);
    endgenerate
endmodule


