`timescale 1ns / 1ps
module Mutex
	#( parameter WIDTH=4)
	(
		input [WIDTH-1:0] in,
		input reset,
		output [WIDTH-1:0] out
	);

	generate
		if(WIDTH==4) begin
			logic [WIDTH-1:0] in_and, out_norm,outCelem;
			logic [1:0] in_or, out_middle;
			
			assign in_and[0] = in[0] & outCelem[1];
			assign in_and[1] = in[1] & outCelem[0];
			assign in_and[2] = in[2] & outCelem[3];
			assign in_and[3] = in[3] & outCelem[2];
			
			assign in_or[0] = in_and[0]  | in_and[1]; 
			assign in_or[1] = in_and[2]  | in_and[3]; 
			
			(* DONT_TOUCH = "yes" *) Mutex_2In Mutex_0(in_and[0],in_and[1],reset,out_norm[0],out_norm[1]);
			(* DONT_TOUCH = "yes" *) Mutex_2In Mutex_1(in_or[0],in_or[1],reset,out_middle[0],out_middle[1]);
			(* DONT_TOUCH = "yes" *) Mutex_2In Mutex_2(in_and[2],in_and[3],reset,out_norm[2],out_norm[3]);
			
			(* DONT_TOUCH = "yes" *) C2_elem Celem0(out_norm[0],out_middle[0],reset,outCelem[0]);
			(* DONT_TOUCH = "yes" *) C2_elem Celem1(out_norm[1],out_middle[0],reset,outCelem[1]);
			(* DONT_TOUCH = "yes" *) C2_elem Celem2(out_norm[2],out_middle[1],reset,outCelem[2]);
			(* DONT_TOUCH = "yes" *) C2_elem Celem3(out_norm[3],out_middle[1],reset,outCelem[3]);
			
			//assign out = ~outCelem;
			genvar i;
			for (i=0;i<WIDTH; i=i+1)
			 (* DONT_TOUCH = "yes"*) LUT1#(.INIT(2'b01)) Mutex_not(.O(out[i]),.I0(outCelem[i]));
		end
	endgenerate


endmodule



module Mutex_2In
    (
        input inA,
        input inB,
        input Reset,
        output enA,
        output enB
    );
    (* DONT_TOUCH ="yes" *) wire nandoutA, nandoutB;
    wire nandoutA_old,  nandoutB_old;
      
    (* HU_SET = "MutexSet", RLOC = "X0Y0" *) LUT2 #(.INIT(4'h7)) NANDA(nandoutA,inA,nandoutB_old);
    (* HU_SET = "MutexSet", RLOC = "X0Y0" *) LUT2 #(.INIT(4'h7)) NANDB(nandoutB,inB,nandoutA_old);
    assign nandoutA_old = nandoutA;
    assign nandoutB_old = nandoutB;
    
    
    (* HU_SET = "MutexSet", RLOC = "X2Y1" *) LUT2 #(.INIT(4'd11)) ANDA(enA,nandoutA,nandoutB);
    (* HU_SET = "MutexSet", RLOC = "X2Y1" *) LUT2 #(.INIT(4'd11)) ANDB(enB,nandoutB,nandoutA);
    
endmodule
