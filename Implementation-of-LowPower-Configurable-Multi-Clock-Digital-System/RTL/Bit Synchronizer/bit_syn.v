module bit_syn #(parameter no_s = 3 , bus_width = 1) (
  input  [bus_width-1:0]  ASYNC,
  input                   CLK,
  input                   RST,
  output [bus_width-1:0]  SYNC 
  );
 
 
  reg [no_s-1:0] sync_flop [bus_width-1:0] ;

  integer i ;
  
  
always @ (posedge CLK or negedge RST)
begin
  if (!RST)
    begin
      for (i = 'd0 ; i < bus_width ; i = i + 'd1)
      sync_flop[i] <= 'd0;
    end
  else 
   begin 
     for (i = 'd0 ; i < bus_width ; i = i + 'd1)
      sync_flop[i] <= {sync_flop[i][bus_width-1:0],ASYNC[i]};
   end
 end
   
    
    
assign SYNC = sync_flop [no_s-1] ;

endmodule