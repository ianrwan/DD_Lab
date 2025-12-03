module main(clock, reset, in, out);
// module main(clock, reset, in, out, see); 看 Unsigned 用
input clock, reset, in;
output [6:0] out;
// output [3:0] see; 看 Unsigned 用

wire clock_div;
wire [3:0] tmp;

frequency_driver f1(
	.clk(clock),
	.rst(reset),
	.div_clk(clock_div));

moore_machine moore1(
	.clock_div(clock), // 非用 fpga 請直接填入 clock， 用 fpga 填 clock_div
	.reset(reset),
	.in(in),
	.tmp(tmp));
	
seven_display display1(
	.in(tmp),
	.out(out));
	
// assign see = tmp; // 看 Unsigned 用
endmodule