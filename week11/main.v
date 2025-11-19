module main(
    input clk,           // clock
    input rst,           // reset
    input up_down,       // up == 1, down == 0
    input enable,        // if enable == 0, count will stop
    output [6:0] out     // 七段顯示的輸出
);

wire clk_div;           // clock transfer from frequency_driver
wire [3:0] count;       // count

// frequency driver（50MHz → 1Hz）
frequency_driver u_FreqDiv (
    .clk(clk), 
    .rst(rst), 
    .div_clk(clk_div)
);

// counter
counter u_counter(
    .clk(clk), // 若使用 fpga 請轉換為 clk_div
    .rst(rst), 
    .up_down(up_down), 
    .enable(enable),
    .count(count)
);

// 七段顯示器
seven_display u_display(
    .in(count), 
    .out(out)
);

endmodule