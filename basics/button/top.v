module top (
    output [3:0] led,
    input  [2:1] btn,
);
    assign led = btn;

endmodule
