module main(c_in, a, b, sum, c_out);
input c_in, a, b;
output reg sum, c_out;

always@(*)
begin
	{c_out, sum}=c_in + a + b;
end
endmodule