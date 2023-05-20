module moore
#(parameter down_to = 3'd0, up_to = 3'd4, start_height = 3'd6, turn_time = 3'd3, 
dn = 3'b000, A1 = 3'b001, up = 3'b010, A2 = 3'b011, 
r1 = 3'b100, r2 = 3'b101, nothing = 3'b110)

(input clk, reset, hooked, unhooked, write_mode,
input [1:0]mode_in, // required angle
output reg [1:0] mode_out, 
output reg [2:0] action, 
output reg [2:0] height);

reg [3:0] state;
reg [2:0] cnt;
reg return=0;

parameter Res = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8, S9 = 9;

always @(posedge clk or posedge reset)
begin
  if (reset)
    state <= Res;
  else begin
  case (state)
    Res:
      state <= S1;
    S1:
      begin
	if (return) begin
	  return <= 1'b0;
	end
	if (write_mode) begin
			 return <= 1'b0;
          
          state <= S2;
	     end
      end 
    S2:
      begin
      if (!return) begin
        if(cnt == turn_time)
          state <= S3;
        if (mode_out == mode_in) begin
          state <= S5;
	end
      end
      else begin
        if(cnt == turn_time)
          state <= S3;
        if (mode_out == 2'd0)
          state <= S1;
        end
      end
    S3:
      begin
      if (!return) begin
        if(cnt == turn_time)
          state <= S4;
        if (mode_out == mode_in) begin
          state <= S5;
	end
      end
      else begin
        if(cnt == turn_time)
          state <= S4;
        if (mode_out == 2'd0)
          state <= S1;
        end
      end
    S4:
      begin
      if (!return) begin
        if(cnt == turn_time || mode_out == mode_in) begin
          state <= S5;
        end
      end
      else begin
        if(cnt == turn_time || mode_out == 2'd0) begin
          state <= S1;
	end
      end
      end
    S5:
      if (height == down_to) begin
        state <= S6;
      end
    S6:
      if (hooked == 1'b1) begin
        state <= S7;
      end
    S7:
      if (height == up_to) begin
        state <= S8;
      end
    S8:
      if (unhooked == 1'b1) begin
        state <= S9;
      end
    S9:
      if (height == start_height) begin
        return <= 1'b1;
        state <= S2;
      end
    default:
      state <= Res;
    endcase
  end
end

always @(posedge clk)
 begin
  case(state)
    Res:
      begin
        cnt <= 3'd0;
		  action <= nothing;
		  mode_out <= 2'd0;
		  height <= start_height;
      end
	 S1:
	 begin
	 if (write_mode || return)
         action <= nothing;
	 if (write_mode) 
			height <= start_height;
	 end
    S2:
      if (cnt == turn_time) begin
        cnt <= 3'd0;
        mode_out <= mode_out + 2'd1;
      end
      else if (mode_out != mode_in || return == 1'b1) begin
        cnt <= cnt + 3'd1;
      end
    S3:
      if (cnt == turn_time) begin
        cnt <= 3'd0;
        mode_out <= mode_out + 2'd1;
      end
      else if (mode_out != mode_in || return == 1'b1) begin
        cnt <= cnt + 3'd1;
      end
    S4:
      if (cnt == turn_time) begin
        cnt <= 3'd0;
        mode_out <= mode_out + 2'd1;
      end
      else if (mode_out != mode_in || return == 1'b1) begin
        cnt <= cnt + 3'd1;
      end
    S5:
    begin
      if (action != dn)
	action <= dn;
      if (height != down_to) begin
        height <= height - 3'd1;
      end
		else begin
		  action <= A1;
		end
    end
    S6:
	 begin
      if (action != A1)
        action <= A1;
		if (hooked == 1'b1)
		  action <= up;
	 end
    S7:
    begin
      if (action != up)
	action <= up;
      if (height != up_to) begin
        height <= height + 3'd1;
      end
		else begin
        action <= A2;
      end
    end
    S8:
		begin
      if (action != A2)
        action <= A2; 
		if (unhooked == 1'b1) begin
        action <= r1;
      end
		end
    S9:
    begin
      if (action != r1)
	action <= r1;
      if (height > start_height) begin
        height <= height - 3'd1;
      end
      else if (height < start_height) begin
        height <= height + 3'd1;
      end
		else begin
		  action <= r2;
		end
    end
  endcase
end
endmodule