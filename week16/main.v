module main(
    input MAX10_CLK1_50,
    input KEY0,
    input [3:0] keypadCol,
    output [3:0] keypadRow,
    output [7:0] dot_row,
    output [7:0] dot_col
);

    wire clk_100hz, clk_10000hz;
    wire key_pressed;
    wire [3:0] key_value;

    frequency_driver_100hz u_freq_100hz(
        .clk(MAX10_CLK1_50),
        .rst(KEY0),
        .div_clk(clk_100hz)
    );

    frequency_driver_10000hz u_freq_10000hz(
        .clk(MAX10_CLK1_50),
        .rst(KEY0),
        .div_clk(clk_10000hz)
    );

    keypad u_keypad(
        .clk_100hz(clk_100hz),
        .reset(KEY0),
        .keypadCol(keypadCol),
        .keypadRow(keypadRow),
        .key_pressed(key_pressed),
        .key_value(key_value)
    );

    dot_matrix u_dot_matrix(
        .clk_10000hz(clk_10000hz),
        .reset(KEY0),
        .key_pressed(key_pressed),
        .key_value(key_value),
        .dot_row(dot_row),
        .dot_col(dot_col)
    );

endmodule