module strt_Check (
  input      CLK,
  input      RST,
  input      strt_chk_en,
  input      sampled_bit,
  output reg strt_glitch );
  
  always @ (posedge CLK or negedge RST)
   begin
     if (!RST)
       strt_glitch <= 1'd0;
     else if ( strt_chk_en )
       begin
         if ( sampled_bit == 1'd0)
           strt_glitch <= 1'd0;
         else
           strt_glitch <= 1'd1;
        end
      end
    endmodule
