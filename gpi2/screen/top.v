module top (
    input             clk_25mhz,
    output reg [3:0]  led,
    output [27:0]     gpio
);

    // ===============================================================
    // System Clock generation
    // ===============================================================
    wire locked;
    wire clk_vga;

    // Exact 24Mhz clock
    pll pll_i (
        .clkin(clk_25mhz),
        .clkout0(clk_vga),
        .locked(locked)
    );

    wire hsync, vsync, blank;
    wire [9:0] x;
    wire [9:0] y;
    wire [17:0] color;

    // Counts frames and counts seconds on leds
    reg old_vsync;
    reg [5:0] fc;

    always @(posedge clk_vga) begin
        old_vsync <= vsync;
	if (vsync && !old_vsync) begin
            fc <= fc + 1;
            if (fc == 59) begin
                led <= led + 1;
                fc <= 0;
            end
	end
    end

    // VGA generator
    vga_video vga_instance (
      .clk(clk_vga),
      .resetn(locked),
      .vga_hsync(hsync),
      .vga_vsync(vsync),
      .vga_blank(blank),
      .h_pos(x),
      .v_pos(y)
    );

    // tricolor
    //assign color = (x<213) ? {6'h3f, 6'h00, 6'h00} : (x<426) ? {6'h3f, 6'h3f, 6'h3f} : {6'h00, 6'h00, 6'h3f};
    
    // checkers
    assign color = x[4] ^ y[4] ? 18'h3ffff : 18'h3f000;

    // Set the GPIO pins
    assign gpio[0] = clk_vga;
    assign gpio[1] = ~blank; // de
    assign gpio[2] = vsync;
    assign gpio[3] = hsync;

    assign gpio[18] = 1'b1; // Backlight
    assign gpio[19] = 1'b1;
    assign gpio[27] = 1'b1;
    assign gpio[26] = 1'b1;
    assign gpio[11] = 1'b1;
    assign gpio[10] = 1'b1;

    assign {gpio[25], gpio[24], gpio[23], gpio[22], gpio[21], gpio[20]} = color[17:12];
    assign {gpio[17], gpio[16], gpio[15], gpio[14], gpio[13], gpio[12]} = color[11:6];
    assign {gpio[9],  gpio[8],  gpio[7],  gpio[6],  gpio[5],  gpio[4]}  = color[0:5];

endmodule

