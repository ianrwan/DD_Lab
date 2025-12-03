module special_multiply(input [3:0] in, output reg [6:0] out);
always@(*)
begin
    case (in)
		4'b0000: out = 7'b1111001; // out = 0+1
		4'b0001: out = 7'b0100100; // out = 1+1
		4'b0010: out = 7'b0110000; // out = 2+1
		4'b0011: out = 7'b0000010; // out = 3*2
		4'b0100: out = 7'b0000000; // out = 4*2
		4'b0101: out = 7'b0001000; // out = 5*2
		4'b0110: out = 7'b0000011; // out = 6*2-1
		4'b0111: out = 7'b0100001; // out = 7*2-1
		4'b1000: out = 7'b0001110; // out = 8*2-1
		default: out = 7'b1000000;
    endcase
end
endmodule