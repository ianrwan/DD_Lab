module main(a, b, sum, c_out);
input a, b;
output reg sum, c_out; // 記住要有 reg 

always@(*)
begin
    {c_out, sum} = a+b;
end
endmodule