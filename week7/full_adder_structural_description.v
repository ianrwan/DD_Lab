module full_adder_structural_description(a, b, cin, sum, cout);
input a, b, cin;
output sum, cout;

wire w1, w2, w3;

half_adder_structural_description half_adder1(a, b, w1, w2);
half_adder_structural_description half_adder2(cin, w1, sum, w3);

or or1(cout, w3, w2);
endmodule