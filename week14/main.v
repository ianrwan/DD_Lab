module main(clock, reset, dot_row, dot_col);
input clock, reset;
output reg [7:0] dot_row, dot_col;

wire div_clk;
reg [2:0] row_count;

frequency_divider f1(
    .clk(clock),
    .rst(reset),
    .div_clk(div_clk)
);

always @(posedge div_clk, negedge reset) // 如果是在看 waveform 請將 div_clk 換成 clock，因為 div_clk 是經過 frequency_divider 的值
begin
    if(~reset) // 如果 reset = 0 則全暗
    begin
        dot_row <= 8'b11111111; // 此處與講義不一樣，講義設定為 8'b00000000，但我認為是設 8'b11111111
        dot_col <= 8'b00000000;
        row_count <= 0;
    end
    else
    begin
        row_count <= row_count + 1;
        case(row_count)
            3'd0: dot_row <= 8'b01111111;
            3'd1: dot_row <= 8'b10111111;
            3'd2: dot_row <= 8'b11011111;
            3'd3: dot_row <= 8'b11101111;
            3'd4: dot_row <= 8'b11110111;
            3'd5: dot_row <= 8'b11111011;
            3'd6: dot_row <= 8'b11111101;
            3'd7: dot_row <= 8'b11111110;    
        endcase
        case(row_count)
            3'd0: dot_col <= 8'b00000000;
            3'd1: dot_col <= 8'b01100110;
            3'd2: dot_col <= 8'b01100110;
            3'd3: dot_col <= 8'b00000000;
            3'd4: dot_col <= 8'b10000001;
            3'd5: dot_col <= 8'b01000010;
            3'd6: dot_col <= 8'b00111100;
            3'd7: dot_col <= 8'b00000000;
        endcase
    end
end
endmodule