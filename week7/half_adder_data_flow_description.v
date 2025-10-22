module half_adder_data_flow_description(a, b, sum, carry);

input a, b;
output sum, carry;

assign sum = a^b;
assign carry = a&b;

endmodule