module Decoder_Unit (
  input  [3:0] ALU_FUN,
  output reg Arith_Enable,Logic_Enable,CMP_Enable,Shift_Enable);
  always @ (*)
  begin
    case (ALU_FUN)
      2'b0000: begin 
             Arith_Enable = 1'd1;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd0;
             end
     
      2'b0001: begin 
             Arith_Enable = 1'd1;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd0;
             end
    
      2'b0010: begin 
             Arith_Enable = 1'd1;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd0;
             end
    
      2'b0011: begin 
             Arith_Enable = 1'd1;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd0;
             end
     
      2'b0100: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd1;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd0; 
             end
        
      2'b0101: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd1;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd0; 
             end
             
      2'b0110: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd1;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd0; 
             end
             
      2'b0111: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd1;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd0; 
             end
             
     
      2'b1000: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd1;
             Shift_Enable = 1'd0; 
             end 
             
      2'b1001: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd1;
             Shift_Enable = 1'd0; 
             end 
             
      2'b1010: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd1;
             Shift_Enable = 1'd0; 
             end 
             
      2'b1011: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd1;
             Shift_Enable = 1'd0; 
             end 
             
             
      2'b1100: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd1;
           end
           
       2'b1101: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd1;
           end
           
       2'b1110: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd1;
           end
           
       2'b1111: begin
             Arith_Enable = 1'd0;
             Logic_Enable = 1'd0;
             CMP_Enable = 1'd0;
             Shift_Enable = 1'd1;
           end
    endcase
  end
endmodule      
      
      
