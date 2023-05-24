module coder_height
(input wire [2:0] data,
output wire [6:0] seg_height);

reg [6:0]code;

assign seg_height=code;

always @*
case(data)
  3'b000: code = 7'b1000000;
  3'b001: code = 7'b1111001;
  3'b010: code = 7'b0100100;
  3'b011: code = 7'b0110000;
  3'b100: code = 7'b0011001;
  3'b101: code = 7'b0010010;
  3'b110: code = 7'b0000010;
  3'b111: code = 7'b1111000;
  default: code = 7'b1111111;
endcase
endmodule
