module CLK_DIV_tb ();
 reg         i_ref_clk_tb;
 reg         i_rst_n_tb;
 reg         i_clk_en_tb;
 reg   [2:0] i_div_ratio_tb;
 wire        o_div_clk_tb ;
 
 CLK_DIV DUT (
 .i_ref_clk(i_ref_clk_tb),
 .i_rst_n(i_rst_n_tb),
 .i_clk_en(i_clk_en_tb),
 .i_div_ratio(i_div_ratio_tb),
 .o_div_clk(o_div_clk_tb));
 
 
  always #10 i_ref_clk_tb = ~i_ref_clk_tb;
    

    initial begin
        i_ref_clk_tb   = 1'd0;
        i_rst_n_tb     = 1'd1;
        i_clk_en_tb    = 1'd1;
         

        // Test different divided ratios
        #10 
        i_rst_n_tb         = 1'd0;
        #10 
            i_rst_n_tb     = 1'd1;
            
            
        for (i_div_ratio_tb = 2; i_div_ratio_tb <= 4; i_div_ratio_tb = i_div_ratio_tb + 1) begin
            #100;
             i_clk_en_tb = 1;
            #1000;
             i_clk_en_tb = 0;
            #100;
        end
      
        
         $finish;
    end
endmodule