module MUX (
  input [1:0] mux_sel,
  input start_bit,
  input stop_bit,
  input ser_data,
  input par_bit,
  input CLK,RST,
  output reg TX_OUT );

always @(posedge CLK or negedge RST)
 begin
   if(!RST)
     TX_OUT <= 1'd0;
   else 
     begin
       case (mux_sel)
         2'b00  : TX_OUT <= 1'd0;       //start
         2'b01  : TX_OUT <= 1'd1;      //stop
         2'b10  : TX_OUT <= ser_data; //ser_data
         2'b11  : TX_OUT <= par_bit; //par_bit
         
       endcase
     end
   end
 endmodule
  