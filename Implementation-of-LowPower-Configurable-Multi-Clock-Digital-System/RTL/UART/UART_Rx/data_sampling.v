module data_sampling (
  input       CLK,
  input       RST,
  input       RX_IN,
  input [4:0] Prescale,
  input       data_samp_en,
  input [4:0] edge_cnt,
  output reg  sampled_bit );
  
  reg [2:0] s_bit ;
  
  always @ (posedge CLK or negedge RST)
   begin
     if (!RST)
       s_bit <= 1'd0;
     else if (data_samp_en)
       begin
         case (edge_cnt)
           (Prescale/2)-1 : s_bit[0] <= RX_IN; //7
           (Prescale/2)   : s_bit[1] <= RX_IN; //8
           (Prescale/2)+1 : s_bit[2] <= RX_IN; //9
           default        : s_bit    <= 3'd0; 
           
         endcase
       end
    end
       
    always @(*)
     begin
       case (s_bit)
         3'b000 : sampled_bit = 1'd0;
         3'b001 : sampled_bit = 1'd0;
         3'b010 : sampled_bit = 1'd0;
         3'b011 : sampled_bit = 1'd1;
         3'b100 : sampled_bit = 1'd0;
         3'b101 : sampled_bit = 1'd1;
         3'b110 : sampled_bit = 1'd1;
         3'b111 : sampled_bit = 1'd1;
       endcase
     end
     
   endmodule
         
           
  
