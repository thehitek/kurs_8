`timescale 1ms/10ns
module main_tb;
localparam T=20, sec = 1000000;

reg clk;
reg reset;
reg [1:0]mode_in;
reg t_hooked;
reg t_unhooked;
reg t_write_mode;

wire [6:0]t_out_mode;
wire [6:0]t_out1_act;
wire [6:0]t_out2_act;

main test(.clk(clk) ,.reset(reset) ,.out_mode(t_out_mode) ,.mode_in(mode_in), .out1_action(t_out1_act), 
  .out2_action(t_out2_act), .hooked(t_hooked), .unhooked(t_unhooked), .write_mode(t_write_mode));


always begin
  clk = 1'b0;
  #(T/2);
  clk = 1'b1;
  #(T/2);
end

initial begin
  mode_in = 2'd1;

  reset = 1'b0;
  t_hooked = 1'b0;
  t_unhooked = 1'b0;
  t_write_mode = 1'b0;

  #(sec*1.5)
  
  t_write_mode = 1'b1;
  #(sec*2);
  t_write_mode = 1'b0;
  #(sec*5);


  t_hooked = 1'b1;
  #(sec*2);
  t_hooked = 1'b0;
  #(sec*5);

  t_unhooked = 1'b1;
  #(sec*2);
  t_unhooked = 1'b0;
  #(sec*5);

end
endmodule
