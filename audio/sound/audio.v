module audio(
    input clk_25mhz,
    output [12:4] gpio
);

parameter TONE_A4 = 25000000/440/2;
parameter TONE_A5 = 25000000/880/2;

reg audio;

assign gpio[12] = 1'b0; // gain
assign gpio[6]  = 1'b1; // shutdown
assign gpio[4] = audio;

reg [25:0] counter;
initial 
begin
    audio = 0;
    counter = 0;
end

reg [23:0] tone;
always @(posedge clk_25mhz) 
    tone <= tone+1;

always @(posedge clk_25mhz) 
    if(counter==26'b0) 
    begin
        counter <= (tone[23] ? TONE_A4-1 : TONE_A5-1 ); 
        audio <= ~audio;
    end
    else 
        counter <= counter-1;

endmodule
