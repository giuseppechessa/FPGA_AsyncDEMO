`timescale 1ns / 1ps

module PackGen #(
    parameter Path ="/home/giuseppe/Documents/MouseTrap/",
    parameter Name="Sender_x.txt",
	parameter OverrunDelay=1,
	parameter WORD_WIDTH=32,
	parameter PORT=0,
	parameter RandomMode=0,
	parameter flit=3
)
(
    input Start,
    input reset,
	input ack,
	output logic req,
	output logic[WORD_WIDTH-1 : 0] Data,
	output int Packets
);
    typedef enum {HEAD,BODY,TAIL} Stato_type;
    Stato_type Stato;
    int fd,fd_t;
    logic [WORD_WIDTH-3:0] Packet;
    logic [WORD_WIDTH-13:0] PacketID;
    int CounterFlit,CounterHead=0;
     // X_lox | Y_loc | Loc | 2 bit di head
    logic [0:4][10:0] Direction = '{
    {4'd2,4'd3,3'b0}, //NORTH
    {4'd1,4'd2,3'b0}, //WEST
    {4'd2,4'd1,3'b0}, //SOUTH
    {4'd3,4'd2,3'b0}, //EAST
    {4'd2,4'd2,3'b0} //LOCAL
    };
    initial begin
        Stato= HEAD;
        Packets=0;
        fd   =$fopen ({Path,"symFiles/",Name} , "w+");
        fd_t =$fopen ({Path,"symFiles/",Name,"_times"} , "w+");
        wait(Start==1'b1);
        wait(Start==1'b0);
        $fclose(fd);
        $fclose(fd_t);
    end
    always_latch begin
        if(reset)
            req= 1'b0;
        else if(Start)
            req <= #OverrunDelay ~ack;
        else 
            req <=req;
    end
    
    int DIRVar;
    initial begin
        if(PORT==0)
            DIRVar=1;
        else
            DIRVar=0;
    end
    
    always @(req, posedge(reset)) begin
        if(reset)
            Data=0;
        else begin
            case(Stato)
                HEAD: begin
                     //MultiFLIT
                     //Stato<=BODY;
                     //SinfleFlit
                     Stato<=BODY;
                     if(RandomMode) begin
                         do
                            DIRVar=$urandom_range(4,0);
                         while(DIRVar==PORT);
                     end
                     else begin
                        if(CounterHead>=10) begin
                            DIRVar=DIRVar+1;
                            CounterHead=0;
                            if(DIRVar==5) DIRVar=0;
                            if(DIRVar==PORT) DIRVar=DIRVar+1;
                            if(DIRVar==5) DIRVar=0;
                        end
                     end
                     randomize(PacketID);
                     Data={PacketID, Direction[DIRVar],2'b01};
                     $fwrite(fd, "%0d\t",Data);
                     $fwrite(fd_t, "%0g\t",$realtime);
                     CounterFlit=0;
                end
                BODY: begin 
                    if(CounterFlit==flit-3)
                        Stato<=TAIL;
                    CounterFlit=CounterFlit+1;
                    randomize(Packet);
                    Data={Packet,2'b00};
                    $fwrite(fd, "%0d\t",Data);
                    $fwrite(fd_t, "%0g\t",$realtime);
                end
                TAIL: begin
                    Stato <= HEAD;
                    randomize(Packet);
                    Data={Packet,2'b10};
                    $fdisplay(fd, "%0d",Data);
                    $fdisplay(fd_t, "%0g",$realtime);
                    Packets=Packets+1;
                    CounterHead=CounterHead+1;
                end
            endcase
        end
    end


endmodule


