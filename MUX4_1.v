module MUX4_1 (in0,in1,in2,sel,out);
parameter N=48;
input [N-1:0] in0,in1,in2;
input [1:0] sel;
output reg [N-1:0] out;
always@(*) begin
    case(sel)
    2'b00 :out=0;
    2'b01 :out=in0;
    2'b10 :out=in1;
    2'b11 :out=in2;
    endcase
end
endmodule



