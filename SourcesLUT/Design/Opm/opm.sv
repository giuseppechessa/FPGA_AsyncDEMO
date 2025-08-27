`timescale 1ns/1ps

module opm 
#(
	parameter WIDTH = 32, // larghezza del bundled data.
	parameter INPORTS =4,
	parameter BUFNUM =4
	)
(
	input 							 reset,
	input 							 gen_enable,
	
	input		[INPORTS-1:0] req_up_i,
	input   [INPORTS-1:0] [WIDTH-1:0] Data_up_i,
	output logic	[INPORTS-1:0] ack_up_o,

	output      				 req_dw_o,
	output	 [WIDTH-1:0] Data_dw_o,
	input        				 ack_dw_i,
	
	input    [INPORTS-1:0] PacketEnable_dw_o,
	output logic 	 [INPORTS-1:0] Tailpassed_up_o
	
	);
	logic [INPORTS-1:0] LatchEnable, LatchOutput;
	logic [WIDTH-1:0] MuxOutput;
	logic [INPORTS-1:0] LatchControl;
	assign LatchControl = LatchEnable & ~Tailpassed_up_o;
	(* DONT_TOUCH = "yes"*) Mutex#(INPORTS) OPM_Mutex(PacketEnable_dw_o,reset,LatchEnable);
	//LatchBarrier
	genvar num;
	generate
	for(num=0; num<INPORTS; num = num+1) begin
     LDCE #(
      .INIT(1'b0),            // Initial value of latch, 1'b0, 1'b1
      .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
      .IS_G_INVERTED(1'b0)    // Optional inversion for G
    )
    LatchBarrier (
      .Q(LatchOutput[num]),     // 1-bit output: Data
      .CLR(reset), // 1-bit input: Asynchronous clear
      .D(req_up_i[num]),     // 1-bit input: Data
      .G(gen_enable),     // 1-bit input: Gate
      .GE(LatchControl[num])    // 1-bit input: Gate enable
    );
	end
	endgenerate
	//Mux
	 Mux#(WIDTH,INPORTS) MyMux(LatchEnable,Data_up_i,MuxOutput);
	
	//Mousetrap
	logic Combreq, CombreqDelayed;
	assign Combreq=^LatchOutput;
	genvar i;
	generate 
	if(BUFNUM==0)
		assign CombreqDelayed = Combreq;
	else if (BUFNUM==1)
		(* DONT_TOUCH*)  LUT1 #(.INIT(2'b10)) PRCBuf(.O(CombreqDelayed),.I0(Combreq));
	else begin
		logic[BUFNUM-1:0] InterCavi;
		(* DONT_TOUCH*)  LUT1 #(.INIT(2'b10)) PRCBufInit(.O(InterCavi[0]),.I0(Combreq));
		(* DONT_TOUCH*)  LUT1 #(.INIT(2'b10)) PRCBufFine(.O(CombreqDelayed), .I0(InterCavi[BUFNUM-1]) );
		for(i=1;i<BUFNUM;i=i+1) begin
			(* DONT_TOUCH*)  LUT1 #(.INIT(2'b10)) PRCBuf(.O(InterCavi[i]),.I0(InterCavi[i-1]));
		end
	end
	endgenerate

	logic nc,enable;
	(* DONT_TOUCH = "yes"*) mousetrap_ldce_woMacros#(WIDTH) output_pipe(reset,gen_enable,CombreqDelayed,MuxOutput,nc,req_dw_o,Data_dw_o,ack_dw_i,enable);	
	
	//AckOutput
	always_ff @(negedge enable, posedge reset)
		if(reset)
			ack_up_o<=1'b0;
		else
			ack_up_o <= LatchOutput;
			
	//TailDetection
	logic isTail;
	assign isTail = Data_dw_o[1] == 1'b1; // 01 -> head, 10 -> tail, 00 -> body

	generate
	for ( i=0; i<INPORTS; i=i+1) begin
    always_ff @(negedge enable, negedge LatchEnable[i])
      if(~LatchEnable[i])
        Tailpassed_up_o[i]<=1'b0;
      else
        Tailpassed_up_o[i] <= isTail;
	end
  endgenerate
  
endmodule
/*
module opm 
#(
	parameter WIDTH = 32, // larghezza del bundled data.
	parameter INPORTS =4
	)
(
	input 							 reset,
	input 							 gen_enable,
	
	input		[INPORTS-1:0] req_up_i,
	input   [INPORTS-1:0] [WIDTH-1:0] Data_up_i,
	output logic	[INPORTS-1:0] ack_up_o,

	output      				 req_dw_o,
	output	 [WIDTH-1:0] Data_dw_o,
	input        				 ack_dw_i,
	
	input    [INPORTS-1:0] PacketEnable_dw_o,
	output logic 	 [INPORTS-1:0] Tailpassed_up_o
	
	);
	//Mousetrap
	logic nc,enable;
	//TailDetection
	logic isTail;
	logic [INPORTS-1:0] LatchEnable, LatchOutput;
	logic [WIDTH-1:0] MuxOutput;
	(* DONT_TOUCH = "yes"*) Mutex#(INPORTS) OPM_Mutex(PacketEnable_dw_o,reset,LatchEnable);
	//LatchBarrier
	genvar num;
	generate
	for(num=0; num<INPORTS; num = num+1) begin
	   (* DONT_TOUCH = "yes"*)  RPMToBE TailAssembly(reset,gen_enable,enable,req_up_i[num],isTail,LatchEnable[num],LatchOutput[num],Tailpassed_up_o[num]);
	end
	endgenerate
	//Mux
	 Mux#(WIDTH,INPORTS) MyMux(LatchEnable,Data_up_i,MuxOutput);
	
	
	(* DONT_TOUCH = "yes"*) mousetrap_ldce_woMacros#(WIDTH) output_pipe(reset,gen_enable,^LatchOutput,MuxOutput,nc,req_dw_o,Data_dw_o,ack_dw_i,enable);	
	
	//AckOutput
	always_ff @(negedge enable, posedge reset)
		if(reset)
			ack_up_o<=1'b0;
		else
			ack_up_o <= LatchOutput;
			
	
	assign isTail = Data_dw_o[1] == 1'b1; // 01 -> head, 10 -> tail, 00 -> body
  
endmodule

module RPMToBE (
	input reset,
	input gen_enable,
	input enable,
	input req_up_i,
	input isTail,
	input LatchEnable,
	output logic LatchOutput,
	output logic Tailpassed_up_o
	);

	logic LatchControl;
  (* HU_SET = "TAILSET", RLOC = "X1Y0" *)  LDCE #(
    .INIT(1'b0),            // Initial value of latch, 1'b0, 1'b1
    .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
    .IS_G_INVERTED(1'b0)    // Optional inversion for G
  )
  LatchBarrier (
    .Q(LatchOutput),     // 1-bit output: Data
    .CLR(reset), // 1-bit input: Asynchronous clear
    .D(req_up_i),     // 1-bit input: Data
    .G(gen_enable),     // 1-bit input: Gate
    .GE(LatchControl)    // 1-bit input: Gate enable
  );


  (* HU_SET = "TAILSET", RLOC = "X0Y0" *) FDCE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b1)) 
    TailPassedFF
       (.C(enable),
        .CE(1'b1),
        .CLR(~LatchEnable),
        .D(isTail),
        .Q(Tailpassed_up_o));



  (* HU_SET = "TAILSET", RLOC = "X1Y0" *) LUT2 #(.INIT(4'h4)) LATCHAND(.O(LatchControl),.I0(LatchEnable),.I1(Tailpassed_up_o));

			



endmodule 
*/