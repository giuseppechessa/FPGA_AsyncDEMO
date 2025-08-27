`timescale 0.1ns / 1ps


module Testbench_Moustrap(

    );
     
     //DUT parameters
     parameter WORD_WIDTH=256;
     logic reset;
     logic clk;
     initial begin
        reset=0;
        clk=0;
     end
     assign #50 clk= ~clk;
     
     //pipeline
     logic req_in_top;
     logic[WORD_WIDTH-1:0] Data_in__top;
     wire ack_in_top;
        
     wire req_out_top;
     wire[WORD_WIDTH-1:0] Data_out__top;
     logic ack_out_top;
     
     //TopModule#(WORD_WIDTH) myModule(reset,req_in_top,Data_in__top,ack_in_top,req_out_top,Data_out__top,ack_out_top);
     task OutputCheck();  
        begin
            wait(ack_out_top!=req_out_top);
            ack_out_top<=req_out_top;
            #1;
        end
     endtask
     
     task InputSend(input[WORD_WIDTH-1:0] Value);  
        begin
            wait(ack_in_top==req_in_top);
            Data_in__top<=Value;
            req_in_top <=~req_in_top;
            #1;
         end
     endtask
     
     initial begin
        reset=1;
        Data_in__top=0;
        #200
        reset<=0;
        req_in_top<=0;
        #1000
        InputSend({WORD_WIDTH{1'd1}});
        InputSend({WORD_WIDTH{1'd0}});
        InputSend({WORD_WIDTH{1'd1}});
        InputSend({WORD_WIDTH{1'd0}});
     end
     
     integer i;
     initial begin
        ack_out_top<=0;
        for (i=0;i<8;i=i+1)
            OutputCheck();
     end 
     
     /*
     //Celement
     logic A,B;
     wire C;
     TopModule#(WORD_WIDTH) myModule(reset,A,B,C);
     
     initial begin
        A=0;B=0;
        #1000
        A<=1;
        B<=1;
        #8
        A<=0;
     end
     */
     /*
     logic inA,inB;
     wire enA,enB;
     TopModule#(WORD_WIDTH) myModule(reset,inA,inB,enA,enB);
     initial begin
        inA=0;inB=0;
        #1000
        inA<=1;
        #200
        inB<=1;
        #200
        inA<=0;
     end
     */
endmodule
