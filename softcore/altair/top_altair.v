module top
(
  input clk_25mhz,
  input ftdi_txd,
  output ftdi_rxd,
  output [3:0] led
);

  reg [5:0] reset_cnt;
  wire resetn = &reset_cnt;

  always @(posedge clk_25mhz) begin
    reset_cnt <= reset_cnt + !resetn;
  end

  altair machine(
    .clk(clk_25mhz),
    .reset(~resetn),
    .rx(ftdi_txd),
    .tx(ftdi_rxd),
    .led(led)
  );

endmodule
