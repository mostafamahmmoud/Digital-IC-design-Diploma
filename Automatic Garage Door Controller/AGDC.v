module AGDC (
  input UP_Max,DN_Max,
  input activate,CLK,RST,
  output reg UP_M,DN_M);
  
reg [1:0] current_state,next_state;

localparam [2:0] IDLE = 3'b000,
                 MV_UP = 3'b001,
                 MV_DN = 3'b010;
                 
         
always @ (posedge CLK or negedge RST)
  begin
  if (!RST)
    current_state <= IDLE ;
  else
    current_state <= next_state;
  end
  
  always @ (*)
   begin
     case (current_state)
       IDLE : begin
              if ( activate )
                next_state = MV_UP;
              else
                begin
                next_state = IDLE;
                UP_M = 1'd0;
                DN_M = 1'd0;
                end
              end
      
      MV_UP : if (UP_Max)
              next_state = IDLE;
              else
                begin 
                  UP_M = 1'd1;
                  DN_M = 1'd0;
                  next_state = MV_DN;
                end
    
      MV_DN : if(DN_Max)
              next_state = IDLE;
              else
                begin
                  UP_M = 1'd0;
                  DN_M = 1'd1;
                  next_state = MV_UP;
                end
                
      default : begin 
                next_state = IDLE;
                UP_M = 1'd0;
                DN_M = 1'd0;
                end
                
        endcase
      end
endmodule
              
                
                  
       