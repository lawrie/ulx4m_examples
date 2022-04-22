module audio(
    input clk_25mhz,
    output [19:18] gpio,
    output [3:0] led
);

parameter TONE_A4 = 25000000/440/2;
parameter TONE_A5 = 25000000/880/2;

reg audio;

assign gpio[19] = audio;
assign gpio[19] = audio;

reg [25:0] counter;
reg [25:0] led_counter;
initial 
begin
    audio = 0;
    counter = 0;
    led_counter = 0;
end

reg [23:0] tone;
always @(posedge clk_25mhz) 
    tone <= tone+1;

always @(posedge clk_25mhz)
	led_counter <= led_counter + 1;

always @(posedge clk_25mhz) 
    if(counter==26'b0) 
    begin
        counter <= (tone[23] ? TONE_A4-1 : TONE_A5-1 ); 
        audio <= ~audio;
    end
    else 
        counter <= counter-1;

assign led = led_counter[25:22];

endmodule
