module top (
    input clk_25mhz,
    output [3:0] led
);
    reg [27:0] cnt = 0;

    always @(posedge clk_25mhz) 
    begin
        cnt <= cnt + 1;
    end

    assign led = cnt[27:24];
endmodule
