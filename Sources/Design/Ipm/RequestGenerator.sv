`timescale 1ns/1ps

module RequestGenerator
#(
	parameter location= 0,
	parameter OUTPORTPORTS =4
)
(
  input reset,
	input req_up_i,
	input [OUTPORTPORTS-1:0] ack_dw_i,
	input PacketEnable_up_i,
	input Tailpassed_dw_i,
	output req_dw_o,
	output logic PacketEnable_dw_o
	);
	
	
	LDCE #(
            .INIT(1'b0),            // Initial value of latch, 1'b0, 1'b1
            .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
            .IS_G_INVERTED(1'b0)    // Optional inversion for G
          )
            PacketEnLatch (
            .Q(PacketEnable_dw_o),     // 1-bit output: Data
            .CLR(reset | Tailpassed_dw_i), // 1-bit input: Asynchronous clear
            .D(1'b1),     // 1-bit input: Data
            .G(PacketEnable_up_i),     // 1-bit input: Gate
            .GE(1'b1)    // 1-bit input: Gate enable
          );
		
	assign req_dw_o = req_up_i ^ (^ack_dw_i ^ ack_dw_i[location]);
		
endmodule
	
