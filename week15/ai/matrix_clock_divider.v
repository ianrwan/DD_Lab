module matrix_clock_divider(
    input clk,      // 50MHz
    input rst,
    output reg clk_10k
);
    reg [11:0] count;
    
    always @(posedge clk) begin
        if (!rst) begin
            count <= 12'd0;
            clk_10k <= 1'b0;
        end
        else begin
            if (count == 12'd2499) begin // 50MHz / (2*2500) = 10kHz
                count <= 12'd0;
                clk_10k <= ~clk_10k;
            end
            else begin
                count <= count + 12'd1;
            end
        end
    end
endmodule