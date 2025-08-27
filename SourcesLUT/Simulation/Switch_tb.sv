`timescale 1ns / 1ps

module Switch_tb();
	     
     //DUT parameters
     parameter WORD_WIDTH=32;
     parameter OUTPORTS = 5;
     logic reset,clk,gen_enable;
     initial begin
     		gen_enable=1;
        clk=0;
     end
     assign #5 clk= ~clk;
     
     //pipeline
     logic [OUTPORTS-1:0] req_in_top,req_out_top;
     logic[OUTPORTS-1:0][WORD_WIDTH-1:0] Data_in_top,Data_out_top;
     logic [OUTPORTS-1:0] ack_in_top,ack_out_top;
        
     
     TopModule_Switch opm_tb(
     .reset(reset),
     .gen_enable(gen_enable),
     .req_up_i(req_in_top),
     .Data_up_i_0(Data_in_top[0]),
     .Data_up_i_1(Data_in_top[1]),
     .Data_up_i_2(Data_in_top[2]),
     .Data_up_i_3(Data_in_top[3]),
     .Data_up_i_4(Data_in_top[4]),
     .ack_up_o(ack_in_top),
     .req_dw_o(req_out_top),
     .Data_dw0_o(Data_out_top[0]),
     .Data_dw1_o(Data_out_top[1]),
     .Data_dw2_o(Data_out_top[2]),
     .Data_dw3_o(Data_out_top[3]),
     .Data_dw4_o(Data_out_top[4]),
     .ack_dw_i(ack_out_top)
     );
     
     int  Packets[4:0];
     int PacketRx[4:0];
     logic [4:0] Start;
     parameter RandomMode=0;
     parameter DelayG=3;
     parameter flit=20;
     parameter Folder="/home/giuseppe/Documents/Prova/MouseTrap_64/";
     PackGen #(Folder,"Sender_N",DelayG,WORD_WIDTH,0,RandomMode,flit) Sender_N(Start[0],reset, ack_in_top[0],req_in_top[0],Data_in_top[0],Packets[0]);
     PackGen #(Folder,"Sender_W",DelayG,WORD_WIDTH,1,RandomMode,flit) Sender_W(Start[1],reset, ack_in_top[1],req_in_top[1],Data_in_top[1],Packets[1]);
     PackGen #(Folder,"Sender_S",DelayG,WORD_WIDTH,2,RandomMode,flit) Sender_S(Start[2],reset, ack_in_top[2],req_in_top[2],Data_in_top[2],Packets[2]);
     PackGen #(Folder,"Sender_E",DelayG,WORD_WIDTH,3,RandomMode,flit) Sender_E(Start[3],reset, ack_in_top[3],req_in_top[3],Data_in_top[3],Packets[3]);
     PackGen #(Folder,"Sender_L",DelayG,WORD_WIDTH,4,RandomMode,flit) Sender_L(Start[4],reset, ack_in_top[4],req_in_top[4],Data_in_top[4],Packets[4]);
     
     int Delay[4:0] = '{150,150,150,150,150};
     localparam PACCHETTI = 40;
     logic Finished;
     initial begin
         Start[0]=1'b0;
         #(Delay[0]);
         Start[0]=1'b1;
         wait(Packets[0]==PACCHETTI)
         Start[0]=1'b0;
     end
     genvar i;
     for(i=1;i<5;i=i+1) begin
         initial begin
            if(i==4)
                Finished<=1'b0;
            Start[i]=1'b0;
            if(RandomMode) 
                #(Delay[i]);
            else begin
                wait(Start[i-1]==1'b1);
                wait(Start[i-1]==1'b0);
            end
            Start[i]<=1'b1;
            wait(Packets[i]==PACCHETTI)
            Start[i]<=1'b0;
            if(i==4) begin
                Finished<= #1000 1'b1;
                $display ("Finished");
                #1000
                $finish;
            end
         end
     end
     

     
      // X_lox | Y_loc | Loc | 2 bit di head
        
     initial begin
      reset=1;
      #100
      reset<=0;
     end

     PackRec #(Folder,"Receiver_N",1,WORD_WIDTH) RX_N(reset,ack_out_top[0],req_out_top[0],Data_out_top[0],PacketRx[0],Finished);
     PackRec #(Folder,"Receiver_W",1,WORD_WIDTH) RX_W(reset,ack_out_top[1],req_out_top[1],Data_out_top[1],PacketRx[1],Finished);
     PackRec #(Folder,"Receiver_S",1,WORD_WIDTH) RX_S(reset,ack_out_top[2],req_out_top[2],Data_out_top[2],PacketRx[2],Finished);
     PackRec #(Folder,"Receiver_E",1,WORD_WIDTH) RX_E(reset,ack_out_top[3],req_out_top[3],Data_out_top[3],PacketRx[3],Finished);
     PackRec #(Folder,"Receiver_L",1,WORD_WIDTH) RX_L(reset,ack_out_top[4],req_out_top[4],Data_out_top[4],PacketRx[4],Finished);
endmodule
