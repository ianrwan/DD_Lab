`define TimeExpire 32'd25000000
module frequency_driver(clk, rst, div_clk);
    input clk, rst;
    output div_clk;
    reg div_clk;
    reg [31:0] count;

    always@(posedge clk) 
    begin
        if (!rst) 
        begin 
            count <= 32'd0;
            div_clk <= 1'b0;
        end
        else 
        begin
            if (count == `TimeExpire) 
            begin
                count <= 32'd0;
                div_clk <= ~div_clk;
            end
            else 
            begin
                count <= count + 32'd1;
            end
        end
    end
endmodule