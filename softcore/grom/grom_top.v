module grom_top(
  input  clk_25mhz,
  output [3:0] led,
  input [6:0] btn
);

  wire [7:0] display_out;
  wire hlt;

  grom_computer computer(.clk(clk_25mhz),.reset(btn[1]),.hlt(hlt),.display_out(display_out));

  assign led = display_out;
endmodule
