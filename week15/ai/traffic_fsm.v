module traffic_fsm(
    input clk,
    input rst,
    input count_done, // 計數完成的訊號
    output reg [1:0] state
);
    
    // 狀態定義
    parameter GREEN = 2'b00;
    parameter YELLOW = 2'b01;
    parameter RED = 2'b10;
    
    // 狀態暫存器
    reg [1:0] current_state, next_state;
    
    // 狀態暫存器更新
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            current_state <= GREEN;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    // 次態邏輯
    always @(*) begin
        case (current_state)
            GREEN: 
                next_state = (count_done) ? YELLOW : GREEN;
            YELLOW: 
                next_state = (count_done) ? RED : YELLOW;
            RED: 
                next_state = (count_done) ? GREEN : RED;
            default: 
                next_state = GREEN;
        endcase
    end
    
    // 輸出邏輯
    always @(*) begin
        state = current_state;
    end
    
endmodule