module clock_divider(
    input clk,      // 50MHz
    input rst,
    output reg clk_1hz
);
    reg [25:0] count;
    
    always @(posedge clk) begin
        if (!rst) begin
            count <= 26'd0;
            clk_1hz <= 1'b0;
        end
        else begin
            if (count == 26'd24_999_999) begin // 0.5秒計數
                count <= 26'd0;
                clk_1hz <= ~clk_1hz; // 產生 1Hz 方波
            end
            else begin
                count <= count + 26'd1;
            end
        end
    end
endmodule