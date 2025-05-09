`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2025 02:47:43 PM
// Design Name: 
// Module Name: img_rom
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


module img_rom #(
    parameter DATA_WIDTH = 12,
    parameter ADDR_WIDTH = 16,
    parameter MEMFILE    = "all_images.mem"
) (
    input  wire [ADDR_WIDTH-1:0] addr,
    output wire [DATA_WIDTH-1:0] dout
);
    (* rom_style = "distributed" *)
    reg [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

    initial begin
        $readmemh(MEMFILE, mem);
    end

    // asynchronous read ? dout ??? addr ????????
    assign dout = mem[addr];
endmodule
