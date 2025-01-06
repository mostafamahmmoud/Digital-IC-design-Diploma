

module AGDC_tb ();
  reg CLK_tb,RST_tb,activate_tb;
  reg UP_Max_tb,DN_Max_tb;
  wire UP_M_tb,DN_M_tb;
  
  parameter CLOCK_PERIOD = 20 ;
  always #(CLOCK_PERIOD/2) CLK_tb = ~ CLK_tb;
task intialization  ;
  begin
    CLK_tb      = 1'd0;
    UP_Max_tb   = 1'd0;
    DN_Max_tb   = 1'd0;
    activate_tb = 1'd0;
    RST_tb      = 1'd0;
  # (CLOCK_PERIOD) 
    RST_tb      = 1'd1;
  end
endtask

initial
begin
 intialization();
 
 # (CLOCK_PERIOD)
 activate_tb = 1'd1;
 # (CLOCK_PERIOD)
 UP_Max_tb = 1'd1;
 # (CLOCK_PERIOD)
 UP_Max_tb = 1'd0;
 # (CLOCK_PERIOD)
 DN_Max_tb   = 1'd1;
 # (CLOCK_PERIOD)
 activate_tb = 1'd0;
 # (10*CLOCK_PERIOD)
 $finish ;
 end
 
 
 AGDC DUT (
 .CLK(CLK_tb),
 .RST(RST_tb),
 .activate(activate_tb),
 .UP_Max(UP_Max_tb),
 .DN_Max(DN_Max_tb),
 .UP_M(UP_M_tb),
 .DN_M(DN_M_tb));
 
 
 
 endmodule
 
 
 
    
    
    
  