module color_controller(
    input clk_100hz,      // 100Hz 時鐘用於按鍵檢測
    input rst,
    input button_pulse,   // 來自 BTN0 的單脈衝
    input reset_button,   // BTN1 重置按鈕
    input [2:0] sw,       // SW0=R, SW1=G, SW2=B
    output reg [3:0] red,
    output reg [3:0] green,
    output reg [3:0] blue
);
    // 顏色值暫存器
    reg [3:0] red_reg;
    reg [3:0] green_reg;
    reg [3:0] blue_reg;
    
    // 按鍵邊緣檢測暫存器
    reg button_prev;
    wire button_edge;
    
    // 檢測按鍵上升沿
    assign button_edge = button_pulse && !button_prev;
    
    always @(posedge clk_100hz) 
    begin
        if (!rst || reset_button) 
        begin
            // 重置所有顏色值
            red_reg <= 4'd0;
            green_reg <= 4'd0;
            blue_reg <= 4'd0;
            button_prev <= 1'b0;
        end
        else 
        begin
            button_prev <= button_pulse;
            
            // 檢測 BTN0 的上升沿
            if (button_edge) 
            begin
                // 根據開關狀態增加對應的顏色值
                if (sw[0]) red_reg <= red_reg + 4'd1;   // SW0 控制紅色
                if (sw[1]) green_reg <= green_reg + 4'd1; // SW1 控制綠色
                if (sw[2]) blue_reg <= blue_reg + 4'd1;  // SW2 控制藍色
            end
        end
    end
    
    // 輸出顏色值
    always @(*) 
    begin
        red = red_reg;
        green = green_reg;
        blue = blue_reg;
    end
endmodule