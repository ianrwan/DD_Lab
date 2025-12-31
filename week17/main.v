module main(
    // 時鐘與重置
    input CLK_50MHZ,      // DE10-Lite 50MHz 時鐘
    input BTN1,           // 重置按鈕 (BTN1)
    
    // 開關與按鈕
    input [2:0] SW,       // SW0, SW1, SW2
    input BTN0,           // 增加顏色按鈕
    
    // VGA 輸出
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,
    output VGA_HS,
    output VGA_VS
);
    // 內部連線宣告
    wire clk_25mhz;       // 25MHz VGA 時鐘
    wire clk_100hz;       // 100Hz 按鍵時鐘
    wire rst;             // 系統重置
    wire button_pulse;    // 去抖動後的按鍵脈衝
    wire video_on;        // 影片有效信號
    wire [9:0] pixel_x;   // 像素 X 座標
    wire [9:0] pixel_y;   // 像素 Y 座標
    
    // 顏色值
    wire [3:0] red_value;
    wire [3:0] green_value;
    wire [3:0] blue_value;
    
    // 系統重置信號 (低電位有效)
    assign rst = !BTN1;  // BTN1 按下時為低電位
    
    // ========== 時鐘分頻模組 ==========
    // 產生 25MHz VGA 時鐘
    frequency_driver_25mhz clk_div_25mhz(
        .clk(CLK_50MHZ),
        .rst(rst),
        .div_clk(clk_25mhz)
    );
    
    // 產生 100Hz 按鍵時鐘 (使用原始的 100Hz 分頻器)
    frequency_driver_100hz clk_div_100hz(
        .clk(CLK_50MHZ),
        .rst(rst),
        .div_clk(clk_100hz)
    );
    
    // ========== 按鍵去抖動模組 ==========
    button_debounce btn0_debounce(
        .clk(clk_100hz),
        .rst(rst),
        .button_in(BTN0),
        .button_out(button_pulse)
    );
    
    // ========== VGA 時序控制模組 ==========
    vga_controller vga_ctrl(
        .clk_25mhz(clk_25mhz),
        .rst(rst),
        .hsync(VGA_HS),
        .vsync(VGA_VS),
        .pixel_x(pixel_x),
        .pixel_y(pixel_y),
        .video_on(video_on)
    );
    
    // ========== 顏色控制模組 ==========
    color_controller color_ctrl(
        .clk_100hz(clk_100hz),
        .rst(rst),
        .button_pulse(button_pulse),
        .reset_button(!BTN1),  // BTN1 為重置按鈕
        .sw(SW[2:0]),          // SW0-2 控制 RGB
        .red(red_value),
        .green(green_value),
        .blue(blue_value)
    );
    
    // ========== VGA 顏色輸出 ==========
    // 只在有效顯示區域輸出顏色，否則輸出黑色
    assign VGA_R = (video_on) ? red_value : 4'd0;
    assign VGA_G = (video_on) ? green_value : 4'd0;
    assign VGA_B = (video_on) ? blue_value : 4'd0;
    
endmodule