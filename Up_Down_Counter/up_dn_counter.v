module up_dn_counter (
  input [4:0] IN,
  input       load,up,down,clk,
  output reg  high,low,
  output reg [4:0] counter );
  reg [4:0] value ;
  
  always @ (posedge clk )
   begin 
     counter<=value;
   end
  always @ (*)
   begin
     if ( load )
       value = IN;
   else if ( down && !low )
       value = value - 5'd1 ;
   else if ( up && !high )
       value = value + 5'd1;
   else
        counter = value ;
   end
   
   always @ (*) 
    begin 
     if ( counter == 5'd31)
        high = 1'd1;
     else
        high = 1'd0;
    end
   always @ (*) 
    begin 
     if ( counter == 5'd0)
         low = 1'd1;
     else
         low = 1'd0;
    end
endmodule      
