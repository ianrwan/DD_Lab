module full_adder(a, b, cin, sum, cout);
input a, b, cin;
output sum, cout;

wire w1, w2, w3;

half_adder h1(a, b, w1, w2);
half_adder h2(cin, w1, sum, w3);

assign cout = w3 | w2;
endmodule