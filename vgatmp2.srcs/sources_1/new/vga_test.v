`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2025 02:48:45 PM
// Design Name: 
// Module Name: vga_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_test (
    input  wire       clk,
    input  wire       reset,
    input  wire [1:0] sw,       // SW[1:0] ???????? 0,1,2
    output wire       hsync,
    output wire       vsync,
    output wire [11:0] rgb
);

    // --------------------------
    // 1) VGA sync unit
    // --------------------------
    wire        video_on, p_tick;
    wire [9:0]  x, y;
    vga_sync vga_inst (
        .clk(clk), .reset(reset),
        .hsync(hsync), .vsync(vsync),
        .video_on(video_on),
        .p_tick(p_tick),
        .x(x), .y(y)
    );

    // --------------------------
    // 2) scale x,y ? x_index,y_index
    // --------------------------
    // ??????? 160×120:
    wire [7:0] x_index = x[9:2];  
    wire [7:0] y_index = y[9:2];  

    localparam W = 160, H = 120;
    localparam IMG_SIZE = W * H;  // = 19200

    // --------------------------
    // 3) ????? base_addr ??? sw
    // --------------------------
    reg [15:0] base_addr;
    always @(*) begin
        case (sw)
            2'b00: base_addr = 0;
            2'b01: base_addr = IMG_SIZE;
            2'b10: base_addr = IMG_SIZE * 2;
            default: base_addr = 0;
        endcase
    end

    // --------------------------
    // 4) ??????? addr
    // --------------------------
    reg [15:0] addr;
    always @(posedge clk or posedge reset) begin
        if (reset)
            addr <= 0;
        else if (video_on && p_tick)
            addr <= base_addr + y_index * W + x_index;
    end

    // --------------------------
    // 5) instantiate ROM ??? asynchronous read
    // --------------------------
    wire [11:0] rom_data;
    img_rom #(
        .DATA_WIDTH(12),
        .ADDR_WIDTH(16),
        .MEMFILE("all_images.mem")
    ) rom0 (
        .addr(addr),
        .dout(rom_data)
    );

    // --------------------------
    // 6) drive rgb
    // --------------------------
    assign rgb = (video_on ? rom_data : 12'b0);

endmodule
