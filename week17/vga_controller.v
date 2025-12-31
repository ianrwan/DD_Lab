module vga_controller(
    input clk_25mhz,    // 25MHz 像素時鐘
    input rst,
    output reg hsync,
    output reg vsync,
    output reg [9:0] pixel_x,
    output reg [9:0] pixel_y,
    output reg video_on
);
    // VGA 640x480 時序參數
    parameter H_DISPLAY = 640;
    parameter H_FRONT_PORCH = 16;
    parameter H_SYNC_PULSE = 96;
    parameter H_BACK_PORCH = 48;
    parameter H_TOTAL = H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE + H_BACK_PORCH;
    
    parameter V_DISPLAY = 480;
    parameter V_FRONT_PORCH = 10;
    parameter V_SYNC_PULSE = 2;
    parameter V_BACK_PORCH = 33;
    parameter V_TOTAL = V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE + V_BACK_PORCH;
    
    // 水平計數器
    reg [9:0] h_count;
    // 垂直計數器
    reg [9:0] v_count;
    
    always @(posedge clk_25mhz) 
    begin
        if (!rst) 
        begin
            h_count <= 10'd0;
            v_count <= 10'd0;
            hsync <= 1'b1;
            vsync <= 1'b1;
            video_on <= 1'b0;
            pixel_x <= 10'd0;
            pixel_y <= 10'd0;
        end
        else 
        begin
            // 水平計數器
            if (h_count == H_TOTAL - 1) 
            begin
                h_count <= 10'd0;
                // 垂直計數器
                if (v_count == V_TOTAL - 1)
                    v_count <= 10'd0;
                else
                    v_count <= v_count + 10'd1;
            end
            else
                h_count <= h_count + 10'd1;
            
            // 產生 HSync 信號 (active low)
            if (h_count < H_DISPLAY + H_FRONT_PORCH || 
                h_count >= H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE)
                hsync <= 1'b1;
            else
                hsync <= 1'b0;
            
            // 產生 VSync 信號 (active low)
            if (v_count < V_DISPLAY + V_FRONT_PORCH || 
                v_count >= V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE)
                vsync <= 1'b1;
            else
                vsync <= 1'b0;
            
            // 設定像素座標
            if (h_count < H_DISPLAY)
                pixel_x <= h_count;
            else
                pixel_x <= 10'd0;
                
            if (v_count < V_DISPLAY)
                pixel_y <= v_count;
            else
                pixel_y <= 10'd0;
            
            // 判斷是否在有效顯示區域
            if (h_count < H_DISPLAY && v_count < V_DISPLAY)
                video_on <= 1'b1;
            else
                video_on <= 1'b0;
        end
    end
endmodule