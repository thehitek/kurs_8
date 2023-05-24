module coder_action
#(parameter dn = 3'b000, A1 = 3'b001, up = 3'b010, A2 = 3'b011, 
r1 = 3'b100, r2 = 3'b101, nothing = 3'b110)
(input wire [2:0] data,
output wire [6:0] seg1_action,
output wire [6:0] seg2_action);

reg [6:0]code1;
reg [6:0]code2;

assign seg1_action=code1;
assign seg2_action=code2;

//gfedcba

always @*
begin
case(data)
  dn:
  begin
    code1 = 7'b0100001;
    code2 = 7'b0101011;
  end
  A1:
  begin
    code1 = 7'b0001000; 
    code2 = 7'b1111001;
  end
  up: 
  begin
    code1 = 7'b1000001;
    code2 = 7'b0001100;
  end
  A2:
  begin
    code1 = 7'b0001000;
    code2 = 7'b0100100;
  end
  r1:
  begin
    code1 = 7'b0101111;
    code2 = 7'b1111001;
  end
  r2:
  begin
    code1 = 7'b0101111;
    code2 = 7'b0100100;
  end
  nothing:
  begin
    code1 = 7'b1111111;
    code2 = 7'b1111111;
  end
  default:
  begin
    code1 = 7'b1111111;
    code2 = 7'b1111111;
  end
endcase
end
endmodule
