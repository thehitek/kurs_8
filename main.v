module main

(input wire clk, reset, hooked, unhooked, write_mode,
input wire [1:0]mode_in,
output wire [6:0]out_mode, 
output wire [6:0] out1_action, 
output wire [6:0] out2_action, 
output wire [6:0] out_height);

wire [1:0] mode;
wire [2:0] action;
wire [2:0] height;
wire sdiv;

count_div2 m1(.clk(clk) ,.sync(sdiv));
moore m2(.clk(sdiv), .reset(reset), .mode_out(mode), .mode_in(mode_in), .hooked(hooked), .unhooked(unhooked), .action(action), .height(height), .write_mode(write_mode));
coder_mode m3(.data(mode), .seg_mode(out_mode));
coder_height m4(.data(height), .seg_height(out_height));
coder_action m5(.data(action), .seg1_action(out1_action), .seg2_action(out2_action));

endmodule
