`timescale 1ns / 1ps                                                                            
                                                                                                
module PackRec #(          
    parameter Path ="/home/giuseppe/Documents/MouseTrap/",                                                                     
    parameter Name="Receiver_x.txt",                                                              
	parameter OverrunDelay=1,                                                                      
	parameter WORD_WIDTH=32                                                                        
)                                                                                               
(     
    input reset,                                                                                                                                                                          
	output logic ack,                                                                                     
	input req,                                                                            
	input [WORD_WIDTH-1 : 0] Data,          
	output int PacketRX,
	input Finished                                            
);                                                                                              
    typedef enum {HEAD,BODY,TAIL} Stato_type;                                                   
    Stato_type Stato;                                                                           
    int fd,fd_t;   
    real Time_V;                                                                                  
    logic [WORD_WIDTH-1:0] SavedData;                                                              
    initial begin                                                                               
        Stato= BODY;   
        PacketRX=0;                                                                         
        fd =$fopen ( {Path,"symFiles/",Name} , "w+");   
        fd_t =$fopen ({Path,"symFiles/",Name,"_times"} , "w+");                                                            
        wait(Finished==1'b1);
        #50                                                                                
        $fclose(fd);     
        $fclose(fd_t);                                                                         
    end         
    always_comb begin
        if(reset)
            ack<=1'b0;
        else
            ack <= #OverrunDelay req;     
    end  
                                                                                                                                                                                                                                                                
    always @(ack,posedge(reset)) begin 
        if(!reset) begin                                                                                                                                                                                                        
            Time_V=$realtime-OverrunDelay;
            if (Data[1]==1'b1)  begin                                                                                                                                                                      
                 $fdisplay(fd, "%0d",Data);   
                 $fdisplay(fd_t, "%0g",Time_V);
                 PacketRX=PacketRX+1;   
                end  
            else begin
                $fwrite(fd, "%0d\t",Data);     
                $fwrite(fd_t, "%0g\t",Time_V);  
            end                          
        end                                                                                                                                                                
    end                                                                                         
                                                                                                
endmodule                                                                                       