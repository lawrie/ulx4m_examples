module top(
    input clk_25mhz,
    output [3:0] led,
    output ftdi_rxd,
    input ftdi_txd
);

wire clk;
pll pll(
    .clki(clk_25mhz),
    .clko(clk)
);

wire [7:0] led_out;
attosoc soc(
    .clk(clk),
    .led(led_out),
    .uart_tx(ftdi_rxd),
    .uart_rx(ftdi_txd)
);

assign led = led_out[3:0];

endmodule
