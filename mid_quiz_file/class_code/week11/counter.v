module counter(
    input clk,          // clock
    input rst,          // reset
    input up_down,      // up == 1, down == 0
    input enable,       // if  enable == 0, count will stop 
    output reg [3:0] count  // counter 輸出的值
);

// synchronous counter
always @(posedge clk or negedge rst) 
begin
    if (!rst) 
    begin
        // 如果 reset == 1 則將 count 設定為 0
        count <= 4'b0000;
    end
    else if (enable) 
    begin
        // 如果 enable == 1 則可以進行倒數
        if (up_down) 
        begin
            // count up
            count <= count + 4'b0001;
        end
        else 
        begin
            // count down
            count <= count - 4'b0001;
        end
    end
    // else
    // begin
    //     // 如果 enable == 0，當前計數值不變
    //     count <= count;
    // end
end

endmodule