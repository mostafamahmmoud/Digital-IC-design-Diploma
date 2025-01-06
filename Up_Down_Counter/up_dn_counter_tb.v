module up_dn_counter_tb ();
  reg [4:0] IN_tb;
  reg       load_tb,up_tb,down_tb,clk_tb;
  wire [4:0] counter_tb;
  wire       high_tb,low_tb;
  
  always #5 clk_tb=~clk_tb;
  
  initial
   begin 
     $dumpfile ("up_dn_counter.vcd");
     $dumpvars;
     load_tb = 1'd0;
     up_tb = 1'd0;
     down_tb = 1'd0;
     clk_tb = 1'd0;
     IN_tb = 5'd10;
    #10 load_tb = 1'd1;
    #10 if ( counter_tb == 5'd10)
         $display ("test 1 is passed ");
        else
         $display ("test 1 is failed ") ;
    #10 up_tb = 1'd1;
        if ( counter_tb == 5'd10)
          $display (" test 2 is passed ");
        else
          $display ("test 2 is failed ");
        load_tb = 1'd0;
    #10 if (counter_tb == 5'd11)
         $display ("test 3 is passed ");
       else
         $display ("test 3 is failed ");
    #10 down_tb = 1'd1;
        up_tb = 1'd0;
    #10 if (counter_tb == 5'd10)
         $display ("test 4 is passed");
       else 
       $display ("test 4 is faild ");
    #100 
    $finish;
  end
  
  up_dn_counter DUT(
  .IN(IN_tb),
  .counter(counter_tb),
  .load(load_tb),
  .up(up_tb),
  .down(down_tb),
  .high(high_tb),
  .low(low_tb));
  
endmodule
