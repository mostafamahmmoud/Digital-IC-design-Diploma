module Stop_Check (
  input      CLK,
  input      RST,
  input      stp_chk_en,
  //input      [3:0] bit_cnt 
  input      sampled_bit,
  output reg stp_err );
  
  always @ (posedge CLK or negedge RST)
   begin
     if (!RST)
       stp_err <= 1'd0;
     else if ( stp_chk_en )
       begin
         if ( sampled_bit == 1'd1)
           stp_err <= 1'd0;
         else
           stp_err <= 1'd1;
        end
      end
    endmodule
