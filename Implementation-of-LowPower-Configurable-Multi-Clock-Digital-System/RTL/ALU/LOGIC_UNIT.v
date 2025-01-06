module LOGIC_UNIT (
  input [15:0] A,B,
  input CLK , Logic_Enable,RST,
  input  [3:0] ALU_FUN ,
  output reg [15:0] Logic_OUT,
  output reg Logic_flag );
  
  always @(posedge CLK or negedge RST)
  begin 
  
  if ( !RST)
    Logic_OUT <= 16'd0;
  else
   begin
    if (Logic_Enable)
      begin
    case (ALU_FUN)
      2'b0100: begin
             Logic_OUT <= A & B;
             Logic_flag <=1'd1;
             end
      2'b0101: begin
             Logic_OUT <= A | B;
             Logic_flag <=1'd1;
             end
      2'b0110: begin
             Logic_OUT <= ~(A & B);
             Logic_flag <=1'd1;
             end
      2'b0111: begin
             Logic_OUT <= ~(A | B);
             Logic_flag <=1'd1;
             end
    endcase 
  end
else begin
Logic_OUT <= 16'd0;
Logic_flag <= 1'd0;

end
end
  end
endmodule
      
     
      
  
