`timescale 1ns/1ps

module mousetrap_ldce_woMacros
#(
  parameter WIDTH = 16 // larghezza del bundled data.
)
(
  input rst,
  input gen_enable,
  
  input   Req_up_i,
  input   [WIDTH-1:0] Data_up_i,
  output  Ack_up_o,
  
  output  Req_dw_o,
  output  logic[WIDTH-1:0] Data_dw_o,
  input   Ack_dw_i,
  output en_o
) ;
  logic re,en;
    // importante usare hu_set e non u_set altrimenti la cosa non è gerarchica
    LDCE #(
        .INIT(1'b0),            // Initial value of latch, 1'b0, 1'b1
        .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
        .IS_G_INVERTED(1'b0)    // Optional inversion for G
    )
    req_latch (
        .Q(re),     // 1-bit output: Data
        .CLR(rst), // 1-bit input: Asynchronous clear
        .D(Req_up_i),     // 1-bit input: Data
        .G(gen_enable),     // 1-bit input: Gate
        .GE(en)    // 1-bit input: Gate enable
    );
    genvar i;
    generate
        for (i=0; i<WIDTH; i=i+1) begin
           LDCE #(
            .INIT(1'b0),            // Initial value of latch, 1'b0, 1'b1
            .IS_CLR_INVERTED(1'b0), // Optional inversion for CLR
            .IS_G_INVERTED(1'b0)    // Optional inversion for G
          )
          Data_latch (
            .Q(Data_dw_o[i]),     // 1-bit output: Data
            .CLR(rst), // 1-bit input: Asynchronous clear
            .D(Data_up_i[i]),     // 1-bit input: Data
            .G(gen_enable),     // 1-bit input: Gate
            .GE(en)    // 1-bit input: Gate enable
          );
        end
     endgenerate;
     
     //xor(en =~ (ReqOut ^ AckOut);
       LUT6_2 #(.INIT(64'h9)) ReqXor(.O5(en),.O6(en_o),.I0(Req_dw_o), .I1(Ack_dw_i));
       //LUT1 #(.INIT(2'b10)) ReqXorBuf(.O(en_o),.I0(en));
  	assign Req_dw_o = re;
	assign Ack_up_o = re;
endmodule





















