module main(a, b, select, out, overflow);
input [3:0] a, b;
input select;
output reg [3:0] out;
output reg overflow;

always@(*)
begin
	{overflow, out} = (select) ? a+b : a-b;
end
endmodule