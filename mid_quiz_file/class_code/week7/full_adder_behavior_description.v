module full_adder_behavior_description(a, b, cin, sum, cout);
input a, b, cin;
output sum, cout;

reg cout, sum;

always@(a, b, cin)
begin
    {cout, sum} = a + b + cin
end
endmodule