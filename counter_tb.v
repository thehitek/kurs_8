`timescale 1ns/10ps
module counter_tb;
localparam T=2;
reg clk;
wire sdiv;

count_div2 test(.clk(clk), .sync(sdiv));

always begin
  clk = 1'b0;
  #(T/2);
  clk = 1'b1;
  #(T/2);
end
endmodule
