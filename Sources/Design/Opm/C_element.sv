`timescale 1ns/1ps

module C_element(
		input A1,A2,A3,B1,B2,B3,extReset,
		output C1,C2,C3
	);
	//1Poss
	C1_elem myC1_elem(A1,B1,C1);
	
	//2Poss
    C2_elem myC2_elem(A2,B2,C2);	
	
	//3Poss
	C3_elem myC3_elem(A3,B3,extReset,C3);
	
endmodule
module C1_elem(input A,B, output C);
    (* DONT_TOUCH = "yes" *) wire Stadio_1,Stadio_2,Stadio_3,C_old;
	assign C =Stadio_1|Stadio_2|Stadio_3;
	assign Stadio_1 = A&B;
	assign Stadio_2 = A&C_old;
	assign Stadio_3 = C_old&B;
	assign C_old =C;
endmodule

module C2_elem(
input A,
input B, 
input reset, 
output C);

    (* DONT_TOUCH = "yes" *) wire C_old;
    //(*BEL="A6LUT", LOCK_PINS = "I2:A6" *)  LUT3#(.INIT(8'b11101000)) C_elLUT(.O(C),.I0(A),.I1(B),.I2(C_old));
	assign C= reset ? 1'b1 : (A&B)|(A&C_old)|(C_old&B);
	assign C_old=C;
	
endmodule

module C3_elem(input A,B,extReset, output C);
    wire Clear,Enable;
	assign Enable=A&B;
	assign Clear= ~(extReset & (A|B));
	LDCE #(
        .INIT(1'b0),            // Initial value of latch, 1'b0, 1'b1
        // Programmable Inversion Attributes: Specifies the use of the built-in programmable inversion
        .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
        .IS_G_INVERTED(1'b0)    // Optional inversion for G
    )
    LDCE_inst (
        .Q(C),     // 1-bit output: Data
        .CLR(Clear), // 1-bit input: Asynchronous clear
        .D(1'b1),     // 1-bit input: Data
        .G(Enable),     // 1-bit input: Gate
        .GE(1'b1)    // 1-bit input: Gate enable
    );
endmodule