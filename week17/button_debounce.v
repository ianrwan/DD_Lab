module button_debounce(
    input clk,      // 100Hz 低頻時鐘
    input rst,
    input button_in,
    output reg button_out
);
    reg [1:0] button_reg;
    
    always @(posedge clk) 
    begin
        if (!rst) 
        begin
            button_reg <= 2'b00;
            button_out <= 1'b0;
        end
        else 
        begin
            // 移位暫存器
            button_reg[1] <= button_reg[0];
            button_reg[0] <= button_in;
            
            // 當檢測到兩個連續的1時，輸出1
            if (button_reg == 2'b11)
                button_out <= 1'b1;
            else
                button_out <= 1'b0;
        end
    end
endmodule