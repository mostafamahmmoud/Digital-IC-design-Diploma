module CLK_DIV (
 input          i_ref_clk,
 input          i_rst_n,
 input          i_clk_en,
 input  [2:0]   i_div_ratio,
 output  reg    o_div_clk );
 
 reg  [31:0] counter = 32'd0 ;
 wire [2:0]  half,odd,halfp1;
 reg flag = 1'd0;
 
 always @ (posedge i_ref_clk or negedge i_rst_n)
  begin
      o_div_clk <= 1'd0;
      counter   <= 32'd0;
      flag      <= 1'd0;
    if(!i_rst_n)
      begin
      o_div_clk <= 1'd0;
      counter   <= 32'd0;
      flag      <= 1'd0;
      end
    else if ( i_clk_en && (i_div_ratio > 3'd1))
      begin 
        if (counter == half && !odd)
          begin
            counter     <= 1'd0;
            o_div_clk   <= ~o_div_clk;
          end
        else if (((counter == halfp1 && !flag) || (counter == half && flag )) && odd)
          begin
            counter     <= 32'd0;
            o_div_clk   <= ~o_div_clk;
            flag        <= ~flag;
          end
        else
          counter <= counter + 32'd1;
        end
      end
    

assign half      =  i_div_ratio >> 1  ;
assign odd       =  i_div_ratio[0]; 
assign halfp1    = half + 3'd1;


endmodule 