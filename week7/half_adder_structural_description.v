module half_adder_structural_description(a, b, sum, carry);

input a, b;
output sum, carry;

xor xor1(sum, a, b);
and and1(carry, a, b);

endmodule