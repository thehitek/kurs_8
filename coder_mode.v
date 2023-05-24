module coder_mode
(input wire [1:0] data,
output wire [6:0] seg_mode);
reg [6:0]code;
assign seg_mode=code;
always @*
case(data)
  2'b00: code = 7'b1000000; // 0:  0
  2'b01: code = 7'b1111001; // 1: 90
  2'b10: code = 7'b0100100; // 2: 180
  2'b11: code = 7'b0110000; // 3: -90
endcase
endmodule
