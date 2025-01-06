module RST_SYN_tb ();
  parameter no_stg_tb = 2; 
  reg               CLK_tb ;
  reg               RST_tb ;
  wire              SYNC_RST_tb ;

RST_SYN #(.no_stg(no_stg_tb)) DUT (
.RST(RST_tb),
.CLK(CLK_tb),
.SYNC_RST(SYNC_RST_tb));

always #10 CLK_tb = !CLK_tb;


initial 
 begin 
   CLK_tb = 1'd0;
   RST_tb = 1'd1;
   RST_tb = 1'b1                                       ;
            #30 

            $display ("\n\nTEST CASE 0")				        ;

            if (SYNC_RST_tb == 1 )
            
                $display ("\nPassed\n")					        ;

            else
                
                $display ("\nFailed\n")					        ;

            #7
            RST_tb = 1'b0                                       ;

            #4
            RST_tb = 1'b1                                       ;

            #9
            $display ("\n\nTEST CASE 1")				        ;

            if (SYNC_RST_tb == 0 )
            
                $display ("\nPassed\n")					        ;

            else
                
                $display ("\nFailed\n")					        ;

   
   #20 

            $display ("\n\nTEST CASE 2")				        ;

            if (SYNC_RST_tb == 1 )
            
                $display ("\nPassed\n")					        ;

            else
                
                $display ("\nFailed\n")					        ;    

            
            	
   #100 $finish;
 end
 
 endmodule
