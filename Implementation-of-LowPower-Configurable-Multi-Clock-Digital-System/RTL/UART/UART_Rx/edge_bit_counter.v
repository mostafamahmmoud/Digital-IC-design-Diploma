module edge_bit_counter (
  input            CLK,
  input            RST,
  input            edge_bit_en,
  output reg [3:0] bit_cnt,
  output reg [4:0] edge_cnt );
  
  always @ (posedge CLK or negedge RST)
   begin
     if (!RST)
       edge_cnt <= 5'd0;
     else if (edge_bit_en)
       edge_cnt <= edge_cnt + 5'd1;
     else
       edge_cnt <= 5'd0;
     end
     
     
     
    always @ (posedge CLK or negedge RST)
     begin
       if (!RST)
         begin
        bit_cnt <= 4'd0;
       edge_cnt <= 5'd0;
         end
      else if (edge_bit_en )
        begin
         if(edge_cnt == 5'd15 )
          begin
        bit_cnt  <= bit_cnt + 4'd1;
        edge_cnt <= 5'd0;
        end
      end
       else
        begin
       bit_cnt  <= 4'd0;
        
        end
    
      end
      
    endmodule
        
        
