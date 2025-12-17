module seven_seg_decoder(
    input [3:0] hex_value,
    output reg [6:0] seg_out
);
    
    // 七段顯示器編碼 (共陽極)
    // 位元順序: g f e d c b a
    always @(*) begin
        case (hex_value)
            4'h0: seg_out = 7'b1000000; // 0
            4'h1: seg_out = 7'b1111001; // 1
            4'h2: seg_out = 7'b0100100; // 2
            4'h3: seg_out = 7'b0110000; // 3
            4'h4: seg_out = 7'b0011001; // 4
            4'h5: seg_out = 7'b0010010; // 5
            4'h6: seg_out = 7'b0000010; // 6
            4'h7: seg_out = 7'b1111000; // 7
            4'h8: seg_out = 7'b0000000; // 8
            4'h9: seg_out = 7'b0010000; // 9
            4'hA: seg_out = 7'b0001000; // A (10)
            4'hB: seg_out = 7'b0000011; // B (11)
            4'hC: seg_out = 7'b1000110; // C (12)
            4'hD: seg_out = 7'b0100001; // D (13)
            4'hE: seg_out = 7'b0000110; // E (14)
            4'hF: seg_out = 7'b0001110; // F (15)
            default: seg_out = 7'b1111111; // 全暗
        endcase
    end
    
endmodule