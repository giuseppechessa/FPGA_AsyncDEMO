`timescale 1ns / 1ps

module IPM_tb();
	     
     //DUT parameters
     parameter WORD_WIDTH=32;
     parameter OUTPORTS = 4;
     logic reset,clk,gen_enable;
     initial begin
     		gen_enable=1;
        clk=0;
     end
     assign #5 clk= ~clk;
     
     //pipeline
     logic req_in_top;
     logic[WORD_WIDTH-1:0] Data_in_top;
     logic ack_in_top;
        
     logic [OUTPORTS-1:0] req_out_top;
     logic [OUTPORTS-1:0][WORD_WIDTH-1:0] Data_out_top;
     logic [OUTPORTS-1:0] ack_out_top;
     logic [OUTPORTS-1:0] Tailpassed_dw_i;
	   
     
     TopModule_Switch Switch_tb(
     .reset(reset),
     .gen_enable(gen_enable),
     .req_up_i(req_in_top),
     .Data_up_i(Data_in_top),
     .ack_up_o(ack_in_top),
     .req_dw_o(req_out_top),
     .Data_dw0_o(Data_out_top[0]),
     .Data_dw1_o(Data_out_top[1]),
     .Data_dw2_o(Data_out_top[2]),
     .Data_dw3_o(Data_out_top[3]),
     .ack_dw_i(ack_out_top),
     .Tailpassed_dw_i(Tailpassed_dw_i)
     );
     
     
     task InputSend(input[WORD_WIDTH-1:0] Value);  
        begin
            wait(ack_in_top==req_in_top);
            Data_in_top<=Value;
            req_in_top <=~req_in_top;
         end
     endtask
     
      // X_lox | Y_loc | Loc | 2 bit di head
     logic [0:7][WORD_WIDTH-1:0] dati = '{ 
        {{(WORD_WIDTH-13){1'd0}}, 4'd2,4'd0,3'b0,2'b01} , 
        {{(WORD_WIDTH-2){1'd0}}, 2'b00},
        {{(WORD_WIDTH-2){1'd1}}, 2'b00},
        {{(WORD_WIDTH-2){1'd0}}, 2'b10},
        {{(WORD_WIDTH-13){1'd0}}, 4'd2,4'd0,3'b0,2'b01},
        {{(WORD_WIDTH-2){1'd0}}, 2'b00},
        {{(WORD_WIDTH-2){1'd1}}, 2'b00},
        {{(WORD_WIDTH-2){1'd0}}, 2'b10}};
     integer num;
     initial begin
        req_in_top<=0;
        reset=1;
        Data_in_top=0;
        #200
        reset<=0;
        #100
        for(num=0;num<8;num=num+1) begin
          InputSend(dati[num]);
          #1;
        end
     end
     
     
     genvar j;
     generate
     	for(j=0;j<OUTPORTS;j=j+1) begin
     	  initial begin
     	    ack_out_top[j]=0;
     	    Tailpassed_dw_i[j]=0;
     	   end
     	   always @(*) begin
     	   	if (ack_out_top[j]!=req_out_top[j])
     	   	  ack_out_top[j]<=req_out_top[j];
     	   end
     	   
     	   always_comb  begin
            if( Data_out_top[j][1]==1)
     	      Tailpassed_dw_i[j] = 1;
     	    else
     	      Tailpassed_dw_i[j] = 0;
     	   end
			end
		endgenerate
    
endmodule
