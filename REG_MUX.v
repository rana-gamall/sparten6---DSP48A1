module reg_MUX(in,sel,out,CLK,rst,ENABLE);
parameter N=18;
parameter RSTTYPE="SYNC";
input [N-1:0] in;
input sel,rst,CLK,ENABLE;
output [N-1:0] out;
 generate 
    if (RSTTYPE=="SYNC") sync_mode #(.N(N))  sync(in,sel,out,CLK,rst,ENABLE);
    else async_mode #(.N(N)) async (in,sel,out,CLK,rst,ENABLE);
 endgenerate
endmodule 
module sync_mode(in,sel,out,CLK,rst,ENABLE);
parameter N=18;
input [N-1:0] in;
input sel,CLK,rst,ENABLE;
output [N-1:0] out;
reg [N-1:0] out_reg;
assign out =(sel) ? out_reg:in;
always@(posedge CLK) begin
    if(rst) out_reg<=0;
    else if (ENABLE) begin
        out_reg<=in;
    end
end
endmodule
module async_mode(in,sel,out,CLK,rst,ENABLE);
parameter N=18;
input [N-1:0] in;
input sel,CLK,rst,ENABLE;
output [N-1:0] out;
reg [N-1:0] out_reg;
assign out =(sel) ? out_reg:in;
always@(posedge CLK or posedge rst) begin
    if(rst) out_reg<=0;
    else if (ENABLE) begin
        out_reg<=in;
    end
end
endmodule





    
