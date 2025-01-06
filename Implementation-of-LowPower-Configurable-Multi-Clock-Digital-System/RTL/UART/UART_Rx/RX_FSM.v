module RX_FSM (
  input       RX_IN,
  input       PAR_EN,
  input       CLK,
  input       RST,
  input [3:0] bit_cnt,
  input [4:0] edge_cnt,
  input       stp_err,
  input       strt_glitch,
  input       par_err,
  output reg  data_samp_en,
  output reg  edge_bit_en,
  output reg  deser_en,
  output reg  data_valid,
  output reg  stp_chk_en,
  output reg  strt_chk_en,
  output reg  par_chk_en );
  
  
  localparam [2:0] IDLE   = 3'b000,
                   START  = 3'b001,
                   DATA   = 3'b011,
                   PARITY = 3'b010,
                   STOP   = 3'b110;
                   
               
                   
  reg [3:0] current_state,next_state;
                   
                   
  always @ (posedge CLK or negedge RST)
  begin
    if(!RST)
      current_state <= IDLE ;
    else
      current_state <= next_state;
    end
    
    
  always @(*)
   begin
    data_samp_en = 1'd0;
    edge_bit_en  = 1'd0;
    deser_en     = 1'd0;
    data_valid   = 1'd0;
    stp_chk_en   = 1'd0;
    strt_chk_en  = 1'd0;        
    par_chk_en   = 1'd0;
    
    case (current_state)
       
      IDLE :  begin
               if ( !RX_IN )
                begin
                 edge_bit_en     = 1'd1;
                 data_samp_en = 1'd1;
                 
                 next_state = START;
                end
                else
                  begin
                  
                  edge_bit_en     = 1'd0;
                  data_samp_en = 1'd0;
                  
                  next_state = IDLE;
                  end
                end
     START :   begin
               data_samp_en = 1'd1;
               edge_bit_en       = 1'd1;
               // strt_chk_en  = 1'd1;
               
               if (edge_cnt != 5'd11)
                 begin
                   strt_chk_en  = 1'd1;
                   next_state = START;
                 end
                 
               else if (!strt_glitch)
          
                   next_state = DATA;
                else
                 next_state = IDLE; 
               end
                 
     DATA :  begin 
              data_samp_en = 1'd1;
              edge_bit_en       = 1'd1; 
              if (bit_cnt != 4'd9)
                 begin 
                     deser_en   = 1'd1;
                     next_state = DATA;
                   end
             else if (PAR_EN)
                     begin
                     next_state = PARITY;
                     end
             else 
                     next_state = STOP;
                   end
          /*   else
                begin
                  deser_en   = 1'd0;
                  next_state = IDLE;
                end */
                 
             //  end
     
      PARITY : begin
              data_samp_en = 1'd1;
              edge_bit_en  = 1'd1;
              
               if (edge_cnt != 5'd10) 
                 par_chk_en = 1'd1;
               else if (!par_err)
                 next_state = STOP;
               else 
                 next_state = IDLE;
                 
                  end
         
      STOP : begin
             data_samp_en = 1'd1;
             edge_bit_en  = 1'd1;
             if (PAR_EN)
               begin
                stp_chk_en = 1'd1;
               if (bit_cnt != 'd10)
                 next_state = STOP;
               else if (edge_cnt != 'd11)
                
                begin
                 
                next_state  = STOP;
                 end
               else if (!stp_err )
                 begin
                   edge_bit_en = 1'd0;
                   data_valid  = 1'd1;
                   next_state = IDLE; 
                 end
               else
                next_state = IDLE;
               end
             else
               begin
                  stp_chk_en = 1'd1;
               if (bit_cnt != 'd9)
                 next_state = STOP;
               else if (edge_cnt != 'd11)
               
                begin
                
                next_state  = STOP;
                 end
               else if (!stp_err )
                 begin
                   edge_bit_en = 1'd0;
                   data_valid  = 1'd1;
                   next_state  = IDLE; 
                 end
               else
                next_state = IDLE;
               end
            
               end
                
            
              
              
    default : begin
             next_state = IDLE;
              end    
           
            endcase
            
          end
          
endmodule
              
                      
                     
              
     
     
     
     
              
                 