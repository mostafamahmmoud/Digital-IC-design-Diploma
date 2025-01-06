module deserializer (
  input            CLK,
  input            RST,
  input      [3:0] bit_cnt,
  input            deser_en,
  input [4:0]      edge_cnt,
  input            sampled_bit,
  output reg [7:0] P_DATA );
  
  always @ (posedge CLK or negedge RST)
   begin
     if (!RST)
       P_DATA <= 8'd0;
     else if ( deser_en && bit_cnt != 'd0 && edge_cnt == 'd10 )
        P_DATA[bit_cnt-1] <= sampled_bit;
      end
    endmodule
       
       
  
