module main(
    input MAX10_CLK1_50,    // 50MHz 時鐘
    input KEY0,             // 重置按鈕 (低電位有效)
    output [7:0] dot_row,   // 點矩陣行信號
    output [7:0] dot_col,   // 點矩陣列信號
    output [6:0] out        // 七段顯示器輸出
);
    
    // 內部信號
    wire clk_1hz;           // 1Hz 時鐘
    wire clk_10k;           // 10kHz 時鐘
    wire [1:0] state;       // 當前狀態
    wire [3:0] count_value; // 計數值
    wire count_done;        // 計數完成信號
    wire reset;             // 內部重置信號
    
    // 重置信號處理 (KEY0 低電位有效 -> 內部高電位有效)
    assign reset = ~KEY0;
    
    // 時鐘分頻模組
    clock_divider u_clock_divider(
        .clk(MAX10_CLK1_50),
        .rst(reset),
        .clk_1hz(clk_1hz)
    );
    
    matrix_clock_divider u_matrix_clock_divider(
        .clk(MAX10_CLK1_50),
        .rst(reset),
        .clk_10k(clk_10k)
    );
    
    // 狀態機模組
    traffic_fsm u_traffic_fsm(
        .clk(MAX10_CLK1_50),
        .rst(reset),
        .count_done(count_done),
        .state(state)
    );
    
    // 計數器模組
    traffic_counter u_traffic_counter(
        .clk(MAX10_CLK1_50),
        .rst(reset),
        .en(clk_1hz),
        .state(state),
        .count(count_value),
        .count_done(count_done)
    );
    
    // 點矩陣顯示模組
    dot_matrix_display u_dot_matrix_display(
        .clk(clk_10k),
        .rst(reset),
        .state(state),
        .dot_row(dot_row),
        .dot_col(dot_col)
    );
    
    // 七段顯示器解碼模組
    seven_seg_decoder u_seven_seg_decoder(
        .hex_value(count_value),
        .seg_out(out)
    );
    
endmodule