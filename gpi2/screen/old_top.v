module top (
    input             clk_25mhz,
    output reg [3:0]  led,
    output [27:0]     gpio
);

  // ===============================================================
  // System Clock generation
  // ===============================================================
  wire locked;
  wire [3:0] clocks;

  ecp5pll
  #(
      .in_hz( 25*1000000),
    .out0_hz(24*1000000),
    .out0_tol_hz(1000000)
  )
  ecp5pll_inst
  (
    .clk_i(clk_25mhz),
    .clk_o(clocks),
    .locked(locked)
  );

    wire clk_vga = clocks[0];
    wire hsync, vsync, blank;
    wire [5:0] red =   6'h3f;
    wire [5:0] green = 6'h3f;
    wire [5:0] blue =  6'h3f;
    wire [9:0] x;
    wire [9:0] y;

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
    vga_video vga_instance
    (
      .clk(clk_vga),
      .resetn(locked),
      .vga_hsync(hsync),
      .vga_vsync(vsync),
      .vga_blank(blank),
      .h_pos(x),
      .v_pos(y)
    );

    // Set the GPIO pins
    assign gpio[0] = clk_vga;
    assign gpio[1] = ~blank; // den
    assign gpio[2] = vsync;
    assign gpio[3] = hsync;

    assign gpio[18] = 1'b1; // Backlight
    assign gpio[19] = 1'b1;

    assign {gpio[25], gpio[24], gpio[23], gpio[22], gpio[21], gpio[20]} = red;
    assign {gpio[17], gpio[16], gpio[15], gpio[14], gpio[13], gpio[12]} = green;
    assign {gpio[9],  gpio[8],  gpio[7],  gpio[6],  gpio[5],  gpio[4]} = blue;

endmodule

