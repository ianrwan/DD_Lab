module main(
    input MAX10_CLK1_50,    // 50MHz 系統時鐘
    input KEY0,             // 重置按鈕（低電位有效）
    output [7:0] dot_row,   // 點矩陣列控制信號
    output [7:0] dot_col,   // 點矩陣行控制信號
    output [6:0] out        // 七段顯示器輸出
);

// 內部連線
wire clk_10k;           // 10kHz 掃描時鐘
wire clk_1;
wire [1:0] state;       // 當前狀態
wire [3:0] count;       // 計數值
wire zero;              // 計數歸零信號
wire reset;             // 重置信號

// 重置信號轉換（KEY0 低電位有效 -> 系統高電位有效）
assign reset = ~KEY0;

// 模組實例化
frequency_divider freq_div(
    .clk(MAX10_CLK1_50),
    .rst(reset),
    .div_clk(clk_10k)
);

frequency_divider_1hz freq_div_2(
    .clk(MAX10_CLK1_50),
    .rst(reset),
    .div_clk(clk_1)
);

moore_machine fsm(
    .clk(MAX10_CLK1_50),
    .rst(reset),
    .in(zero),          // 連接計數器歸零信號
    .state_out(state)
);

counter countdown(
    .clk(MAX10_CLK1_50),
    .rst(reset),
    .enable(clk_1),      // 以 1 Hz 做計數
    .state(state),
    .count(count),
    .zero(zero)
);

dot_matrix dot(
    .clock(clk_10k),    // 以 10000 Hz 做計數
    .reset(reset),
    .state(state),
    .dot_row(dot_row),
    .dot_col(dot_col)
);

seven_display seg(
    .in(count),
    .out(out)
);

endmodule