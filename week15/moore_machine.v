module moore_machine(
    input clk,
    input rst,
    input in,
    output reg [1:0] state_out
);
    // define state
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;

    reg [1:0] current_state;  // 修正：改為 2 位元
    reg [1:0] next_state;     // 修正：改為 2 位元

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
            S0: next_state = (in) ? S1 : S0;
            S1: next_state = (in) ? S2 : S1;
            S2: next_state = (in) ? S0 : S2;
            default: next_state = S0;
        endcase
    end

    // output state 
    always @(*) 
    begin
        case (current_state)
            S0: state_out = 2'b00; // 0
            S1: state_out = 2'b01; // 1
            S2: state_out = 2'b10; // 2
            default: state_out = 2'b00;  // 修正：改為 2 位元
        endcase
    end
endmodule