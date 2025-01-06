module parity_Check (
  input       CLK,
  input       RST,
  input       PAR_TYP,
  input [7:0] P_DATA,
  input       par_chk_en,
  input       sampled_bit,
  output reg  par_err );

localparam even = 1'd0,
           odd  = 1'd1;
           
  reg parity_bit;
  
always @ (posedge CLK or negedge RST )
 begin 
   if(!RST)
     par_err <= 1'd0;
   else if ( par_chk_en )
     begin
       if  ( sampled_bit == parity_bit)
            par_err <= 1'd0;
       else
            par_err <= 1'd1;
      end
    end
    
    
    always @(*)
     begin
       if ( par_chk_en )
         begin 
           case (PAR_TYP)
             even : parity_bit =   ^  (P_DATA) ;
             odd  : parity_bit =   ~^ (P_DATA) ;
           endcase
         end
       end
     endmodule
       
      