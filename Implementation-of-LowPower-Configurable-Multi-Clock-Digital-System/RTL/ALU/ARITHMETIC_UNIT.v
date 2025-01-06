module ARITHMETIC_UNIT (
  input [15:0] A,B,
  input [3:0] ALU_FUN ,
  input CLK ,Arith_Enable,RST,
  output reg [15:0] Arith_OUT,
  output reg carry_OUT,Arith_flag);
 
  always @ (posedge CLK or negedge RST)
  begin
      if (!RST)
       begin
    Arith_OUT <= 16'd0;
    carry_OUT <= 1'd0;
       end
  else
    begin 
      
     if (Arith_Enable) begin
    case (ALU_FUN)
      2'b0000: begin 
        Arith_flag <= 1'd1;
        Arith_OUT <= A + B;
        carry_OUT <= A + B;
       end
      2'b0001:begin 
        Arith_flag <= 1'd1;
        Arith_OUT <= A - B;
        carry_OUT <= A - B;
      end
      2'b0010:begin 
        Arith_flag = 1'd1;
        Arith_OUT <= A * B;
        carry_OUT <= A * B;
      end
      2'b0011:begin 
        Arith_flag <= 1'd1;
        Arith_OUT <= A / B;
        carry_OUT <= A / B;
      end
      endcase
  end
else begin
  carry_OUT <= 1'd0;
  Arith_OUT <= 16'd0;
  Arith_flag <= 1'd0;
end
end
end
endmodule

   
