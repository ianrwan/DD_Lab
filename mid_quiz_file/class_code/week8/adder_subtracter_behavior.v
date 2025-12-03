module adder_subtracter_behavior(a, b, sel, out, overflow, result, bxor);
input[3:0] a, b;
input sel;
output reg [3:0] out;
output reg overflow;

output reg[3:0] bxor;
output reg signed [4:0] result;

reg c_temp;

always @(*) 
begin
    bxor = (sel == 1'b0) ? b : ~b;
    result = sel + a + bxor;
    
    out = result[3:0];
    
    c_temp = a[2,0] + b[2,0];
end
endmodule