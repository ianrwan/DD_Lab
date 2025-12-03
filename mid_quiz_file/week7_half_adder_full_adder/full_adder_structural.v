module main(c_in, a, b, sum, c_out);
input c_in, a, b;
output sum, c_out;

wire w1, w2, w3;

half_adder h1(a, b, w1, w2);
half_adder h2(c_in, w1, sum, w3);
or or1(c_out, w3, w2);
endmodule