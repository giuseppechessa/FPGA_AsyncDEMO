`timescale 1ns / 1ps

module OPM_tb();
	     
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
     logic [OUTPORTS-1:0] req_in_top;
     logic[OUTPORTS-1:0][WORD_WIDTH-1:0] Data_in_top;
     logic [OUTPORTS-1:0] ack_in_top;
        
     logic  req_out_top;
     logic [WORD_WIDTH-1:0] Data_out_top;
     logic  ack_out_top;
     logic [OUTPORTS-1:0] Tailpassed_up_o;
     logic [OUTPORTS-1:0] PacketEnable_dw_i;
	   
     
     TopModule_Switch opm_tb(
     .reset(reset),
     .gen_enable(gen_enable),
     .req_up_i(req_in_top),
     .Data_up_i_0(Data_in_top[0]),
     .Data_up_i_1(Data_in_top[1]),
     .Data_up_i_2(Data_in_top[2]),
     .Data_up_i_3(Data_in_top[3]),
     .ack_up_o(ack_in_top),
     .req_dw_o(req_out_top),
     .Data_dw0_o(Data_out_top),
     .ack_dw_i(ack_out_top),
     .PacketEnable_up_i(PacketEnable_dw_i),
     .Tailpassed_dw_i(Tailpassed_up_o)
     );
      
      task InputSend0(input[WORD_WIDTH-1:0] Value);  
        begin
            wait(ack_in_top[0]==req_in_top[0]);
            Data_in_top[0]<=Value;
            req_in_top[0] <=~req_in_top[0];
         end
     endtask
     task InputSend1(input[WORD_WIDTH-1:0] Value);  
        begin
            wait(ack_in_top[1]==req_in_top[1]);
            Data_in_top[1]<=Value;
            req_in_top[1] <=~req_in_top[1];
         end
     endtask
     task InputSend2(input[WORD_WIDTH-1:0] Value);  
        begin
            wait(ack_in_top[2]==req_in_top[2]);
            Data_in_top[2]<=Value;
            req_in_top[2] <=~req_in_top[2];
         end
     endtask
     task InputSend3(input[WORD_WIDTH-1:0] Value);  
        begin
            wait(ack_in_top[3]==req_in_top[3]);
            Data_in_top[3]<=Value;
            req_in_top[3] <=~req_in_top[3];
         end
     endtask
     
      // X_lox | Y_loc | Loc | 2 bit di head
     logic [0:7][WORD_WIDTH-1:0] dati = '{ 
        {{(WORD_WIDTH-13){1'd0}}, 4'd2,4'd0,3'b0,2'b01} , 
        {{(WORD_WIDTH-2){1'd0}}, 2'b00},
        {{(WORD_WIDTH-2){1'd0}}, 2'b10},
        {{(WORD_WIDTH-13){1'd0}}, 4'd2,4'd0,3'b0,2'b01},
        {{(WORD_WIDTH-2){1'd0}}, 2'b00},
        {{(WORD_WIDTH-2){1'd1}}, 2'b00},
        {{(WORD_WIDTH-2){1'd1}}, 2'b00},
        {{(WORD_WIDTH-2){1'd0}}, 2'b10}};
     
     initial begin
      PacketEnable_dw_i[0]=1'd0;
      PacketEnable_dw_i[3]=1'd0;
      req_in_top=0;
      reset=1;
      Data_in_top=0;
      #200
      reset<=0;
     end
     integer num0,num1,num2,num3;
     
     //Bit0 initial
     initial begin
      PacketEnable_dw_i[0]=1'd0;
      #307
      for(num0=3;num0<8;num0=num0+1) begin
        InputSend0(dati[num0]);
        #1;
        PacketEnable_dw_i[0]<=1'b1;
      end
      wait(PacketEnable_dw_i[0]==Tailpassed_up_o[0]);
      PacketEnable_dw_i[0]<=1'b0;
     end
     
     //Bit1 initial
     initial begin
      PacketEnable_dw_i[1]=1'd0;
      #301
      for(num1=3;num1<8;num1=num1+1) begin
        InputSend1(dati[num1]);
        #1;
        PacketEnable_dw_i[1]<=1'b1;
      end
      wait(PacketEnable_dw_i[1]==Tailpassed_up_o[1]);
      PacketEnable_dw_i[1]<=1'b0;
     end
     
     //Bit2
     initial begin
      PacketEnable_dw_i[2]=1'd0;
      #302;
      for(num2=0;num2<3;num2=num2+1) begin
        InputSend2(dati[num2]);
        #1;
        PacketEnable_dw_i[2]<=1'b1;
      end
      wait(PacketEnable_dw_i[2]==Tailpassed_up_o[2]);
      PacketEnable_dw_i[2]<=1'b0;
     end
     
     //Bit3
     initial begin
      PacketEnable_dw_i[3]=1'd0;
      #309;
      for(num3=0;num3<3;num3=num3+1) begin
        InputSend3(dati[num3]);
        #1;
        PacketEnable_dw_i[3]<=1'b1;
      end
      wait(PacketEnable_dw_i[3]==Tailpassed_up_o[3]);
      PacketEnable_dw_i[3]<=1'b0;
     end
     
     
    initial begin
      ack_out_top=0;
     end
     always @(*) begin
      if (ack_out_top!=req_out_top)
        ack_out_top<= req_out_top;
     end
    
endmodule
