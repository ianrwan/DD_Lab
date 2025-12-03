module half_adder_behavior_description(a, d, sum, carry);
input a, d;
output sum, carry;

reg sum, carry;

always@(a, d)
begin
    if(a == 0 && d == 0)
    begin
        sum = 0;
        carry = 0;
    end

    else if(a === 1 && d == 1)
    begin
        sum = 0;
        carry = 1;
    end
    else
    begin
        sum = 1;
        carry = 0;
    end

end
endmodule