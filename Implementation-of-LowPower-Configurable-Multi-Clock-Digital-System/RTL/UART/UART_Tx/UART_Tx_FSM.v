module UART (
  input [7:0] P_DATA ,
  input       DATA_VALID,
  input       PAR_EN,  
  input       PAR_TYP,
  input       CLK,
  input       RST,
  output      TX_OUT,
  output      Busy 
  );
  wire count_max ,count_dn;
  reg [1:0] current_state , next_state ;
  reg [7:0] data;
  reg [7:0] counter ;
  reg tx_reg ,busy_reg ;
  localparam [3:0] IDLE  = 4'b0000;
  localparam [3:0] START = 4'b0001;
  localparam [3:0] DATA  = 4'b0010;
  localparam [3:0] STOP  = 4'b0100;
  
  
  always @ (posedge CLK or negedge RST )
     begin
  if (!RST)
    current_state <= IDLE ;
  else
    current_state <= next_state;
  end

always @(*)
 begin
   counter  = 1'd0;
   tx_reg   = 1'd1;
   data     = 8'h0;
   busy_reg = 1'd0;
  case(current_state)
   IDLE: begin
            if (DATA_VALID)
              begin
               data = P_DATA;
               next_state = START ;
              end
                 else
                    begin
                    busy_reg = 1'd0;
                    tx_reg = 1'd1;
                    next_state = IDLE ;
                    end
                end
    START : begin
            tx_reg     = 1'd0;
            next_state = DATA;
            counter    = 8'd0;
            end  
            
    DATA : begin
          if (counter <= 8'd8)
             begin
               tx_reg  = data[counter];
               counter = counter + 1;

             end
           else if (PAR_EN)
             begin
             
                tx_reg = PAR_TYP ^ data [7:0] ;
                next_state = STOP;
           end
           else 
            next_state = STOP;
          
           end
     STOP : begin 
             tx_reg     = 1'd1;
            if (counter <= 8'd11) 
              counter      = counter + 1 ;
            
            else begin 
                 busy_reg     = 1'd0;
                 next_state   = IDLE ;
                 end
                 next_state   = IDLE ;
           end
         endcase 
       end
       
       assign TX_OUT = tx_reg ;
       assign Busy   = busy_reg ;
       
       
     endmodule 