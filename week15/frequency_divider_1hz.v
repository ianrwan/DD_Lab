`define TimeExpire 32'd25000000  // 50MHz -> 1Hz

module frequency_divider_1hz(
    input clk,
    input rst,
    output reg div_clk
);
    reg [31:0] count;

    always @(posedge clk) begin
        if (!rst) begin // 低電位同步重置
            count <= 32'd0;
            div_clk <= 1'b0;
        end
        else begin
            if (count == `TimeExpire) begin
                count <= 32'd0;
                div_clk <= ~div_clk;
            end
            else begin
                count <= count + 32'd1;
            end
        end
    end
endmodule