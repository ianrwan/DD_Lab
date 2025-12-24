module dot_matrix(
    input clk_10000hz,
    input reset,
    input key_pressed,
    input [3:0] key_value,
    output reg [7:0] dot_row,
    output reg [7:0] dot_col
);

    reg [2:0] row_cnt; // 行計數器，0~7
    reg [7:0] pattern [0:7]; // 每個按鍵對應的8行點亮模式
    integer i;

    always @(posedge clk_10000hz) 
    begin
        if (!reset) 
        begin
            row_cnt <= 3'd0;
            dot_row <= 8'b11111111;
            dot_col <= 8'b00000000;
            
            // 清除所有模式
            for (i = 0; i < 8; i = i+1) 
            begin
                pattern[i] <= 8'b00000000;
            end
        end
        else 
        begin
            // 行計數器遞增
            row_cnt <= row_cnt + 3'd1;
            
            // 設置 dot_row：只有當前行為 0，其餘為 1
            dot_row <= ~(8'b1 << row_cnt);
            
            // 根據按鍵值設置對應的點亮模式
            if (key_pressed) 
            begin
                case(key_value)
                    // 按鍵 a (0) -> 位置 0, 1, 8, 9
                    4'd0: 
                    begin
                        pattern[0] <= 8'b11000000; // 第0行：列6,7點亮
                        pattern[1] <= 8'b11000000; // 第1行：列6,7點亮
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 b (1) -> 位置 2, 3, 10, 11
                    4'd1: 
                    begin
                        pattern[0] <= 8'b00110000; // 第0行：列4,5點亮
                        pattern[1] <= 8'b00110000; // 第1行：列4,5點亮
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 c (2) -> 位置 4, 5, 12, 13
                    4'd2: 
                    begin
                        pattern[0] <= 8'b00001100; // 第0行：列2,3點亮
                        pattern[1] <= 8'b00001100; // 第1行：列2,3點亮
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 d (3) -> 位置 6, 7, 14, 15
                    4'd3: 
                    begin
                        pattern[0] <= 8'b00000011; // 第0行：列0,1點亮
                        pattern[1] <= 8'b00000011; // 第1行：列0,1點亮
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 e (4) -> 位置 16, 17, 24, 25
                    4'd4: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b11000000; // 第2行：列6,7點亮
                        pattern[3] <= 8'b11000000; // 第3行：列6,7點亮
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 f (5) -> 位置 18, 19, 26, 27
                    4'd5: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00110000; // 第2行：列4,5點亮
                        pattern[3] <= 8'b00110000; // 第3行：列4,5點亮
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 g (6) -> 位置 20, 21, 28, 29
                    4'd6: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00001100; // 第2行：列2,3點亮
                        pattern[3] <= 8'b00001100; // 第3行：列2,3點亮
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 h (7) -> 位置 22, 23, 30, 31
                    4'd7: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00000011; // 第2行：列0,1點亮
                        pattern[3] <= 8'b00000011; // 第3行：列0,1點亮
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 i (8) -> 位置 32, 33, 40, 41
                    4'd8: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b11000000; // 第4行：列6,7點亮
                        pattern[5] <= 8'b11000000; // 第5行：列6,7點亮
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 j (9) -> 位置 34, 35, 42, 43
                    4'd9: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00110000; // 第4行：列4,5點亮
                        pattern[5] <= 8'b00110000; // 第5行：列4,5點亮
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 k (10) -> 位置 36, 37, 44, 45
                    4'd10: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00001100; // 第4行：列2,3點亮
                        pattern[5] <= 8'b00001100; // 第5行：列2,3點亮
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 l (11) -> 位置 38, 39, 46, 47
                    4'd11: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00000011; // 第4行：列0,1點亮
                        pattern[5] <= 8'b00000011; // 第5行：列0,1點亮
                        pattern[6] <= 8'b00000000;
                        pattern[7] <= 8'b00000000;
                    end
                    
                    // 按鍵 m (12) -> 位置 48, 49, 56, 57
                    4'd12: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b11000000; // 第6行：列6,7點亮
                        pattern[7] <= 8'b11000000; // 第7行：列6,7點亮
                    end
                    
                    // 按鍵 n (13) -> 位置 50, 51, 58, 59
                    4'd13: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00110000; // 第6行：列4,5點亮
                        pattern[7] <= 8'b00110000; // 第7行：列4,5點亮
                    end
                    
                    // 按鍵 o (14) -> 位置 52, 53, 60, 61
                    4'd14: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00001100; // 第6行：列2,3點亮
                        pattern[7] <= 8'b00001100; // 第7行：列2,3點亮
                    end
                    
                    // 按鍵 p (15) -> 位置 54, 55, 62, 63
                    4'd15: 
                    begin
                        pattern[0] <= 8'b00000000;
                        pattern[1] <= 8'b00000000;
                        pattern[2] <= 8'b00000000;
                        pattern[3] <= 8'b00000000;
                        pattern[4] <= 8'b00000000;
                        pattern[5] <= 8'b00000000;
                        pattern[6] <= 8'b00000011; // 第6行：列0,1點亮
                        pattern[7] <= 8'b00000011; // 第7行：列0,1點亮
                    end
                    
                    default: 
                    begin
                        for (i = 0; i < 8; i = i+1) 
                        begin
                            pattern[i] <= 8'b00000000;
                        end
                    end
                endcase
                
                // 輸出當前行對應的列模式
                dot_col <= pattern[row_cnt];
            end
            else 
            begin
                // 沒有按鍵按下，清除所有模式
                dot_col <= 8'b00000000;
                for (i = 0; i < 8; i = i+1) 
                begin
                    pattern[i] <= 8'b00000000;
                end
            end
        end
    end
endmodule