module FSM (
  input CLK,RST,
  input PAR_EN,
  input ser_done,
  input DATA_Valid,
  output reg ser_en,
  output reg [1:0] mux_sel,
  output reg busy );
  
  
  reg [2:0] current_state,next_state ;
    
    localparam [3:0] IDLE   = 4'b0000;
    localparam [3:0] START  = 4'b0001;
    localparam [3:0] DATA   = 4'b0010;
    localparam [3:0] PARITY = 4'b0100;
    localparam [3:0] STOP   = 4'b1000;
    
  always @(posedge CLK or negedge RST )
    begin 
      if (!RST)
        current_state <= IDLE ;
      else
        current_state <= next_state ;
     end
   

always @(*)

 begin
 ser_en     = 1'd0;
 mux_sel    = 2'b01;
  case (current_state)
    IDLE : begin 
          if (DATA_Valid)
            begin
              ser_en     = 1'd1;
              busy       = 1'd0;
              next_state = START;
            end
          else 
            begin
              busy       = 1'd0;
              mux_sel    = 2'b01;
              ser_en     = 1'd0;
              next_state = IDLE;
            end
          end
     START : begin 
            busy       = 1'd1;
            mux_sel    = 2'b00;
            next_state = DATA;
            end
    DATA  :begin
           if (ser_done && PAR_EN) 
             begin
             busy       = 1'd1;
             mux_sel    = 2'b10;
             next_state = PARITY;
             end
           else 
             begin
            busy       = 1'd1;
            mux_sel    = 2'b10;
            next_state = STOP; 
            
             end
          end
    PARITY : begin
            if (PAR_EN)
              begin 
                busy       = 1'd1;
                mux_sel    = 2'b11;
                next_state = STOP;
              end
            else 
              begin
              busy       = 1'd1;
              mux_sel    = 2'b11;
              next_state = STOP;
               end
            end
            
     STOP  : begin
              mux_sel = 2'b01;
              busy = 1'd1;
              if (DATA_Valid)
                begin
                busy       = 1'd1;
                ser_en     = 1'd1;
                mux_sel    = 2'b00;
                next_state = DATA ;
                end
              else
                begin
                  mux_sel    = 2'b01;
                  busy       = 1'd1;
                  ser_en     = 1'd0;
                  next_state = STOP ;
                end
              end
              
        default : begin  
                  busy       = 1'd0;
                  ser_en     = 1'd0;
                  mux_sel    = 2'b01;
                  next_state = IDLE ;
                 end
           endcase
         end
       endmodule
                
             
    
              