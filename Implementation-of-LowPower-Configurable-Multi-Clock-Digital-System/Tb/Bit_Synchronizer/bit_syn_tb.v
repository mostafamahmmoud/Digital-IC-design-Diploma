module bit_syn_tb();
  parameter no_s_tb      = 2 ;
  parameter bus_width_tb = 4 ;
  
  reg                      RST_tb;
  reg                      CLK_tb;
  reg   [bus_width_tb-1:0] ASYNC_tb;
  wire  [bus_width_tb-1:0] SYNC_tb;



bit_syn #(.no_s(no_s_tb),.bus_width(bus_width_tb)) DUT (
.RST(RST_tb),
.CLK(CLK_tb),
.ASYNC(ASYNC_tb),
.SYNC(SYNC_tb));


always #10 CLK_tb = !CLK_tb ;

initial 
 begin
   CLK_tb = 1'd0;
   RST_tb = 1'd1;
   ASYNC_tb = 'b1101;
   #10 RST_tb = 1'd0;
   #10 RST_tb = 1'd1;
   #100 $finish; 
  end
  
endmodule
  