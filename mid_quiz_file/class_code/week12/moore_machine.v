module moore_machine(
    input clk,
    input rst,
    input in,
    output reg [2:0] state_out
);
    // define state
    parameter S0 = 3'b000;
    parameter S1 = 3'b001; 
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;
    parameter S6 = 3'b110;

    reg [2:0] current_state;
    reg [2:0] next_state;

    // asynchronized reset
    always @(posedge clk or negedge rst) 
    begin
        if(!rst) 
        begin
            current_state <= S0;
        end
        else 
        begin
            current_state <= next_state;
        end
    end

    // next state
    always @(*) 
    begin
        case (current_state)
            S0: next_state = (in) ? S2 : S1;
            S1: next_state = (in) ? S3 : S2;
            S2: next_state = (in) ? S4 : S3;
            S3: next_state = (in) ? S5 : S4;
            S4: next_state = (in) ? S6 : S5;
            S5: next_state = (in) ? S0 : S6;
            S6: next_state = (in) ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    // ouput state 
    always @(*) 
    begin
        case (current_state)
            S0: state_out = 3'b000; // 0
            S1: state_out = 3'b001; // 1
            S2: state_out = 3'b010; // 2
            S3: state_out = 3'b011; // 3
            S4: state_out = 3'b100; // 4
            S5: state_out = 3'b101; // 5
            S6: state_out = 3'b110; // 6
            default: state_out = 3'b000;
        endcase
    end
endmodule