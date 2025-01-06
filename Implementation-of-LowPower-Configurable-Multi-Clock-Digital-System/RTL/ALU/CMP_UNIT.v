module CMP_UNIT (
  input [15:0] A,B,
  input CLK,CMP_Enable,RST,
  input [3:0] ALU_FUN ,
  output reg CMP_OUT,CMP_flag);
  
  always @ (posedge CLK or negedge RST )
  begin
    if (!RST)
      CMP_OUT <= 1'd0;
    else 
      begin
      
      if (CMP_Enable) begin
      case (ALU_FUN)
       2'b1000: begin
              CMP_OUT <= 1'd0;
              CMP_flag <= 1'd1;
              end
       2'b1001: begin 
              CMP_flag <= 1'd1;
              if (A == B)
               CMP_OUT <= 1'd1;
              else
                CMP_OUT <= 1'd0;
              end
        2'b1010:begin
              CMP_flag <= 1'd1;
              if (A > B)
               CMP_OUT <= 1'd2;
              else
                CMP_OUT <= 1'd0;
              end
        2'b1001: begin 
               CMP_flag <= 1'd1;
              if (A < B)
               CMP_OUT <= 1'd3;
              else
                CMP_OUT <= 1'd0;
              end
                
        endcase
      end
    else begin
     CMP_OUT <= 1'd0;
     CMP_flag <= 1'd0;   
    
    end
  end
      end
    endmodule
       
       
       
        
  
