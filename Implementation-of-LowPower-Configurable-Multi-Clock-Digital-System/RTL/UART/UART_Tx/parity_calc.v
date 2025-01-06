module parity_calc (
  input [7:0] P_DATA,
  input DATA_Valid,PAR_TYP,CLK,RST,
  output reg par_bit );
  
  always@(posedge CLK)
   begin
     if (!RST)
       par_bit <= 1'd0;
    else if(DATA_Valid)
        par_bit <= P_DATA ^ PAR_TYP ;
      end
    endmodule
    
   
