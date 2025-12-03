module main(
    input MAX10_CLK1_50,  // clock 50 MHz
    input SW0,            // reset
    input SW1,            // input
    output [6:0] HEX0     // seven dispaly output
    // output reg [2:0] OUTNUM
);
    wire clk_1Hz;
    wire [2:0] state_code;
    
    // frequency_divider.v
    frequency_divider freq_div (
        .clk(MAX10_CLK1_50),
        .rst(SW0),
        .div_clk(clk_1Hz)
    );
    
    // moore_machine.v
    moore_machine fsm (
        // .clk(MAX10_CLK1_50),
        .clk(clk_1Hz),     // clock 1 Hz
        .rst(SW0),
        .in(SW1),
        .state_out(state_code)
    );
    
    // seven_display.v
    seven_display seg7 (
        .num(state_code),
        .seg(HEX0)
    );

    // always@(*)
    // begin
    //     OUTNUM = state_code;
    // end
endmodule