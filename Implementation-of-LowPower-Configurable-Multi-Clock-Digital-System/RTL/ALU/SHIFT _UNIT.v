module SHIFT_UNIT (
  input [15:0] A,B,
  input CLK ,Shift_Enable,RST,
  input  [3:0] ALU_FUN ,
  output reg [15:0] SHIFT_OUT,
  output reg SHIFT_flag );
 
  always @(posedge CLK or negedge RST)
  begin 
  
  if ( !RST)
    SHIFT_OUT <= 16'd0;
  else
   begin
    if (Shift_Enable)
      begin
    case (ALU_FUN)
      2'b1100: begin
             SHIFT_OUT <= A >> 1;
             SHIFT_flag <=1'd1;
             end
      2'b1101: begin
             SHIFT_OUT <= A << 1;
             SHIFT_flag <=1'd1;
             end
      2'b1110: begin
             SHIFT_OUT <= B >> 1;
             SHIFT_flag <=1'd1;
             end
      2'b1111: begin
             SHIFT_OUT <= B << 1;
             SHIFT_flag <=1'd1;
             end
    endcase
  end
else begin
SHIFT_OUT <= 16'd0;
SHIFT_flag <= 1'd0;

end
end
  end
endmodule
      