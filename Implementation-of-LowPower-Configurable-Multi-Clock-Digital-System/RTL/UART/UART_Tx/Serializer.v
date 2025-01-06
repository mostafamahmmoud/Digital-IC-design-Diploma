module serializer (
  input [7:0] P_DATA ,
  input ser_en,
  input CLK,RST,
  output reg ser_done,
  output ser_data );
  
  reg [3:0] counter ;
  reg [7:0] ser_reg;
  
  always @(posedge CLK or negedge RST)
   begin
     if (!RST)
       ser_reg <= 'd1;
     else if (ser_en && counter != 4'd8)
         begin
         ser_reg <= P_DATA;
         counter <= counter + 4'd1;
         ser_done <= 1'd0;
         end
       else
         ser_done <= 1'd1;
    end
    assign {ser_data,P_DATA[6:0]} = ser_reg;
  endmodule
    
  
  
