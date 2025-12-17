module traffic_counter(
    input clk,
    input rst,
    input en,           // 1Hz 時鐘
    input [1:0] state,  // 當前狀態
    output reg [3:0] count, // 當前計數值
    output reg count_done   // 計數完成訊號
);
    
    // 載入初始值
    reg load;
    reg [3:0] next_count;
    
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            count <= 4'd10; // 重置時為綠燈計數 10
            load <= 1'b1;
            count_done <= 1'b0;
        end
        else if (load) begin
            // 載入對應狀態的初始值
            case (state)
                2'b00: count <= 4'd10; // 綠燈: 10
                2'b01: count <= 4'd3;  // 黃燈: 3
                2'b10: count <= 4'd15; // 紅燈: 15
                default: count <= 4'd10;
            endcase
            load <= 1'b0;
            count_done <= 1'b0;
        end
        else if (en) begin
            if (count == 4'd0) begin
                count_done <= 1'b1;
                load <= 1'b1; // 準備載入新值
            end
            else begin
                count <= count - 4'd1;
                count_done <= 1'b0;
            end
        end
        else begin
            count_done <= 1'b0;
        end
    end
    
endmodule