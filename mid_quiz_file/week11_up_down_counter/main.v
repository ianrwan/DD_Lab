module main(clk, rst, enable, up_down, out);
input clk, rst, enable, up_down;
output [6:0] out; // 不需要使用 reg 因為沒有要在 always 中使用

wire clock_div;
wire [3:0] count;

frequency_driver f1(
	.clk(clk),
	.rst(rst),
	.div_clk(clock_div));
	
counter counter1(
	.clock_div(clock_div), // 非用 fpga 請將 clock_div 換成 clk
	.rst(rst),
	.enable(enable),
	.up_down(up_down),
	.count(count)); // 記得要多輸出端也要連接

seven_display display1(
	.in(count),
	.out(out));
	
endmodule