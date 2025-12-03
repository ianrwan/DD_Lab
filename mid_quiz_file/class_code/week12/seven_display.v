module seven_display(
    input [2:0] num,
    output reg [6:0] seg
);
    // 七段顯示器編碼 (0 on, 1 off)
    always @(*) begin
        case (num)
            3'b000: seg = 7'b1000000; // 0
            3'b001: seg = 7'b1111001; // 1
            3'b010: seg = 7'b0100100; // 2
            3'b011: seg = 7'b0110000; // 3
            3'b100: seg = 7'b0011001; // 4
            3'b101: seg = 7'b0010010; // 5
            3'b110: seg = 7'b0000010; // 6
            3'b111: seg = 7'b1111000; // 7
            default: seg = 7'b1000000; // 0
        endcase
    end
endmodule