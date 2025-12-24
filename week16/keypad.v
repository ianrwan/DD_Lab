module keypad(
    input clk_100hz,        // 100Hz 時鐘
    input reset,            // 重置信號，低電位有效
    input [3:0] keypadCol,  // 從鍵盤輸入的 column 信號
    output reg [3:0] keypadRow,  // 輸出到鍵盤的 row 信號
    output reg key_pressed,      // 按鍵按下標誌
    output reg [3:0] key_value   // 按鍵編碼，0~15
);

    reg [1:0] row_index;   // 當前掃描的行索引，0~3

    // 鍵盤掃描
    always @(posedge clk_100hz) 
    begin
        if (!reset) 
        begin
            row_index <= 2'd0;
            keypadRow <= 4'b1111;
            key_pressed <= 1'b0;
            key_value <= 4'b1111; // 無效值
        end
        else 
        begin
            // 根據 row_index 輸出 row 信號
            case (row_index)
                2'd0: keypadRow <= 4'b0111;
                2'd1: keypadRow <= 4'b1011;
                2'd2: keypadRow <= 4'b1101;
                2'd3: keypadRow <= 4'b1110;
                default: keypadRow <= 4'b1111;
            endcase

            // 檢查 column 信號
            if (keypadCol != 4'b1111) 
            begin // 有按鍵按下
                key_pressed <= 1'b1;
                // 解碼 column 索引
                case (keypadCol)
                    4'b0111: key_value <= {row_index, 2'b00}; // 第一個按鍵（最左邊）
                    4'b1011: key_value <= {row_index, 2'b01};
                    4'b1101: key_value <= {row_index, 2'b10};
                    4'b1110: key_value <= {row_index, 2'b11};
                    default: 
                    begin
                        key_pressed <= 1'b0;
                        key_value <= 4'b1111;
                    end
                endcase
            end
            else 
            begin
                key_pressed <= 1'b0;
                key_value <= 4'b1111;
            end

            // 移動到下一行
            row_index <= row_index + 2'd1; // 自動循環 0~3
        end
    end
endmodule