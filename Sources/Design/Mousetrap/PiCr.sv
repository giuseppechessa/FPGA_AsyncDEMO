`timescale 1ns / 1ps

module PiCr
    #(
parameter WORD_WIDTH=256
    )
    (
        input reset,
        input gen_enable,
        
        
        //Pipeline
        input  req_up_top_i,
        input [WORD_WIDTH-1:0] Data_up_top_i,
        (* DATAOVERRUN = "yes"*) output  ack_up_top_o,
        
        output  req_dw_top_o,
        output [WORD_WIDTH-1:0] Data_dw_top_o,
        input  ack_dw_top_i
        
    );
    localparam N = 2;
    
    //Pipeline
    (* DONT_TOUCH = "yes"*)  logic ack_1;
    (* DONT_TOUCH = "yes"*) logic ack_delay_1,ack_delay_2,ack_delay_3;
    (* DONT_TOUCH = "yes", U_SET = "Prova", RLOC ="X0Y0"*) LUT1#(.INIT(2'b10)) req_delay_1(.O(ack_delay_2),.I0(ack_delay_3));
    (* DONT_TOUCH = "yes", U_SET = "Prova", RLOC ="X0Y1"*) LUT1#(.INIT(2'b10)) req_delay_2(.O(ack_delay_1),.I0(ack_delay_2));   //FUNZIA!
    (* DONT_TOUCH = "yes", U_SET = "Prova", RLOC ="X0Y2"*) LUT1#(.INIT(2'b10)) req_delay_3(.O(ack_up_top_o),.I0(ack_delay_1));   //FUNZIA!
     
    logic[N-1:0] req,ack;
    logic[WORD_WIDTH-1:0] Data[N-1:0];
    (* DONT_TOUCH = "yes"*) mousetrap_ldce #(WORD_WIDTH)  Stadio_1(reset,gen_enable,req_up_top_i,Data_up_top_i,ack_delay_3,req[0],Data[0],ack[0]);
    genvar i;
    generate
      for(i=0;i<N-1;i++) begin
      (* DONT_TOUCH = "yes"*) mousetrap_ldce #(WORD_WIDTH)  Stadio_2(reset,gen_enable,req[i],Data[i],ack[i],req[i+1],Data[i+1],ack[i+1]);
      end
    endgenerate
    (* DONT_TOUCH = "yes"*) mousetrap_ldce #(WORD_WIDTH)  Stadio_3(reset,gen_enable,req[N-1],Data[N-1],ack[N-1],req_dw_top_o,Data_dw_top_o,ack_dw_top_i);
endmodule







































