module counter(
    input clk,          // clock
    input rst,          // reset
    input enable,       // if  enable == 0, count will stop
    input [1:0] state,  // state 會判斷目前的輸入值為何
    output reg [3:0] count,  // counter 輸出的值
    output zero         // 新增：計數歸零信號
);

reg set; // 確定初始值是否已經設定
assign zero = (count == 4'd0); // 當計數為0時，zero為1

// synchronous counter
always @(posedge clk or negedge rst) 
begin
    if (!rst) 
    begin
        // 如果 reset == 1 則將 count 設定為 0
        count <= 4'b0000;
        set <= 1'b0;  // 修正：重置 set 為 0
    end
    else if(!set)
    begin
        case(state)
            2'b00:
                count <= 4'd10;
            2'b01:
                count <= 4'd3;
            2'b10:
                count <= 4'd15;
            default:
                count <= 4'd0;    
        endcase
        set <= 1;
    end
    else if(enable)  // 修正：加入 enable 控制
    begin
        count <= count - 1;
        if(count == 4'd0)
            set <= 0;
    end
end

endmodule