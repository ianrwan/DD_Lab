module dot_matrix_display(
    input clk,      // 10kHz 掃描時鐘
    input rst,
    input [1:0] state,
    output reg [7:0] dot_row,
    output reg [7:0] dot_col
);
    
    reg [2:0] row_counter;
    
    // 掃描邏輯
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            row_counter <= 3'b000;
            dot_row <= 8'b11111111;
            dot_col <= 8'b00000000;
        end
        else begin
            // 更新行計數器
            row_counter <= row_counter + 3'b001;
            
            // 設定當前掃描的行
            case (row_counter)
                3'b000: dot_row <= 8'b01111111;
                3'b001: dot_row <= 8'b10111111;
                3'b010: dot_row <= 8'b11011111;
                3'b011: dot_row <= 8'b11101111;
                3'b100: dot_row <= 8'b11110111;
                3'b101: dot_row <= 8'b11111011;
                3'b110: dot_row <= 8'b11111101;
                3'b111: dot_row <= 8'b11111110;
                default: dot_row <= 8'b11111111;
            endcase
            
            // 根據狀態和行設定列數據
            case (state)
                2'b00: begin // 綠燈圖案
                    case (row_counter)
                        3'b000: dot_col <= 8'b00001100;
                        3'b001: dot_col <= 8'b00001100;
                        3'b010: dot_col <= 8'b00011001;
                        3'b011: dot_col <= 8'b01111110;
                        3'b100: dot_col <= 8'b10011000;
                        3'b101: dot_col <= 8'b00011000;
                        3'b110: dot_col <= 8'b00101000;
                        3'b111: dot_col <= 8'b01001000;
                        default: dot_col <= 8'b00000000;
                    endcase
                end
                
                2'b01: begin // 黃燈圖案
                    case (row_counter)
                        3'b000: dot_col <= 8'b00000000;
                        3'b001: dot_col <= 8'b00100100;
                        3'b010: dot_col <= 8'b00111100;
                        3'b011: dot_col <= 8'b10111101;
                        3'b100: dot_col <= 8'b11111111;
                        3'b101: dot_col <= 8'b00111100;
                        3'b110: dot_col <= 8'b00111100;
                        3'b111: dot_col <= 8'b00000000;
                        default: dot_col <= 8'b00000000;
                    endcase
                end
                
                2'b10: begin // 紅燈圖案
                    case (row_counter)
                        3'b000: dot_col <= 8'b00011000;
                        3'b001: dot_col <= 8'b00011000;
                        3'b010: dot_col <= 8'b00111100;
                        3'b011: dot_col <= 8'b00111100;
                        3'b100: dot_col <= 8'b01011010;
                        3'b101: dot_col <= 8'b00011000;
                        3'b110: dot_col <= 8'b00011000;
                        3'b111: dot_col <= 8'b00100100;
                        default: dot_col <= 8'b00000000;
                    endcase
                end
                
                default: dot_col <= 8'b00000000;
            endcase
        end
    end
    
endmodule