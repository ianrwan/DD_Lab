module adder_subtracter_data_flow(a, b, sel, out, overflow);
input[3:0] a, b;
input sel;
output[3:0] out;
output overflow;

wire[3:0] bxor;
wire[3:0] carry;

// assign bxor = (sel == 1'b0) ? b : ~b;
assign bxor = b ^ {4{sel}}

full_adder f0(a[0], bxor[0], sel, out[0], carry[0]);
full_adder f1(a[1], bxor[1], carry[0], out[1], carry[1]);
full_adder f2(a[2], bxor[2], carry[1], out[2], carry[2]);
full_adder f3(a[3], bxor[3], carry[2], out[3], carry[3]);

assign overflow = carry[2] ^ carry[3];
endmodule