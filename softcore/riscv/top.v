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
attosoc soc(
    .clk(clk),
    .led(led),
    .uart_tx(ftdi_rxd),
    .uart_rx(ftdi_txd)
);
endmodule
