module top (
    input clk_25mhz,
    output [3:0] led,
    input [6:0] btn
);
    reg [3:0] cnt = 0;

    always @(posedge btn[1]) 
    begin
        cnt <= cnt + 1;
    end

    assign led = cnt;
endmodule
