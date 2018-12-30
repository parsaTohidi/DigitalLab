module pc(clk, rst, w, oldpc, newpc);
input clk;
parameter delay = 100;
input rst;
input w;
input [63:0] newpc;
output reg [63:0] oldpc;

always@(posedge clk)
begin
	if(rst)
	begin
		oldpc = 0;
	end
	else if(w==1&& rst==0)
	begin
		oldpc = newpc;
	end 
		
end
endmodule