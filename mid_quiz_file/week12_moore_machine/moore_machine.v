module moore_machine(clock_div, reset, in, tmp);
input clock_div, reset, in;
output reg [3:0] tmp;

parameter s0 = 4'b0000;
parameter s1 = 4'b0001;
parameter s2 = 4'b0010;
parameter s3 = 4'b0011;
parameter s4 = 4'b0100;
parameter s5 = 4'b0101;
parameter s6 = 4'b0110;

reg [3:0] current_state, next_state;

always @(posedge clock_div or negedge reset)
begin
	if(!reset)
	begin
		current_state <= s0;
	end
	else
	begin
		current_state <= next_state;
	end
end

always @(*)
begin
	case(current_state)
		s0: next_state <= (~in) ? s1 : s2;
		s1: next_state <= (~in) ? s2 : s3;
		s2: next_state <= (~in) ? s3 : s4;
		s3: next_state <= (~in) ? s4 : s5;
		s4: next_state <= (~in) ? s5 : s6;
		s5: next_state <= (~in) ? s6 : s0;
		s6: next_state <= (~in) ? s0 : s1;
		default: next_state <= s0;
	endcase
end

always @(*)
begin
	case(current_state)
		s0: tmp = s0;
		s1: tmp = s1;
		s2: tmp = s2;
		s3: tmp = s3;
		s4: tmp = s4;
		s5: tmp = s5;
		s6: tmp = s6;
		default: tmp = s0;
	endcase
end
endmodule

