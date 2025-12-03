module counter(clock_div, rst, enable, up_down, count);
input clock_div, rst, enable, up_down;
output reg [3:0] count;

always@(posedge clock_div or negedge rst)
begin
	if(!rst)
	begin
		count <= 4'b0000;
	end
	else if(enable)
	begin
		if(up_down == 0)
		begin
			count <= count-1;
		end
		else
		begin
			count <= count+1;
		end
	end
end
endmodule