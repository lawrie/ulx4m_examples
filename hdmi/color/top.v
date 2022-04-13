module top
(
  input clk_25mhz,
  output [3:0] gpdi_dp, gpdi_dn
);

    hdmi_video hdmi_video
    (
        .clk_25mhz(clk_25mhz),
        .color(24'h000080),
        .gpdi_dp(gpdi_dp),
        .gpdi_dn(gpdi_dn)	
    );
endmodule
