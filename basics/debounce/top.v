module top (
    input clk_25mhz,
    output [3:0] led,
    input [6:0] btn
);
    reg [3:0] cnt = 0;
    reg [23:0] clk_cnt = 0;
    reg prev_btn = 0;

    always @(posedge clk_25mhz) 
    begin
        clk_cnt <= clk_cnt + 1;
    end

    always @(posedge clk_cnt[20]) 
    begin
        prev_btn <= btn[1];
        if (prev_btn== 1'b0 && btn[1]==1'b1)
            cnt <= cnt + 1;
    end

    assign led = cnt;
endmodule
