module RST_SYN #(parameter no_stg = 2) (
  input               CLK ,
  input               RST ,
  output              SYNC_RST );
  
  reg [no_stg-1:0] register ;
  
  always @ (posedge CLK or negedge RST )
   begin 
     if (!RST)
       begin 
         register <= 'd0;
       end
     else
       begin
         register <= {register[no_stg-2:0],1'd1};
       end
end

assign SYNC_RST = register [no_stg-1] ;

endmodule
