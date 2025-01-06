module SYS_CTRL (
input            CLK,
input            RST,
input  [15:0]    ALU_OUT,
input            ALU_OUT_VLD,
input  [7:0]     RF_RdData,
input            RF_RdData_VLD,
input  [7:0]     UART_RX_DATA,
input            FIFO_FULL,
input            UART_RX_VLD,
output reg [3:0] ALU_FUN,
output reg       ALU_EN,
output reg       CLKG_EN,
output reg [3:0] RF_Address,
output reg       RF_WrEn,
output reg       RF_RdEn,
output reg [7:0] RF_WrData,  //reg_file
output reg [7:0] UART_TX_DATA, //FIFO
output reg       UART_TX_VLD, //FIFO
output reg       CLKDIV_EN
);

reg [3:0] current_state,next_state;

localparam [3:0] IDLE                  = 4'b0000,
                 address            = 4'b0001,
                 write_data            = 4'b0011,
                 read_data             = 4'b0010,
                 write_fifo            = 4'b0110,
                 write_alu_oper_A      = 4'b0111,
                 write_alu_oper_B      = 4'b0101,
                 alu_fun               = 4'b0100,
                 alu_write_fifo        = 4'b1100,
                 alu_write_fifo_second = 4'b1101;
                 
                 
                 
always @ (posedge CLK or negedge RST )
 begin
   if (!RST)
     current_state <= IDLE;
   else
     current_state <= next_state;
 end
  
always @(*) 
 begin
   CLKDIV_EN      = 1'd1;
   ALU_EN         = 1'd0;
   CLKG_EN        = 1'd0;
   RF_WrEn        = 1'd0;
   RF_RdEn        = 1'd0;
   UART_TX_VLD    = 1'd0;
   ALU_FUN        = 4'd0;
   RF_Address     = 4'd0;
   UART_TX_DATA   = 8'd0;
   RF_WrData      = 8'd0;
   
   
   
   
   
  case (current_state)
    IDLE : begin
           if      (UART_RX_DATA == 8'hAA && UART_RX_VLD)
                    next_state = address;
           else if (UART_RX_DATA == 8'hBB && UART_RX_VLD)
                    next_state = read_data;
           else if (UART_RX_DATA == 8'hCC && UART_RX_VLD)
                    next_state = write_alu_oper_A;
           else if (UART_RX_DATA == 8'hDD && UART_RX_VLD)
                 begin
                    CLKG_EN    = 1'd1; 
                    next_state = alu_fun;
                    
                  end
           else
                    next_state = IDLE;
          end
          
   address : begin
                 RF_WrEn       = 1'd1;
              if (UART_RX_VLD)
                 begin
                 RF_Address    = UART_RX_DATA [3:0];
                 next_state    = write_data;
                 end
               else
                 next_state = address;
               end
               
  write_data : begin
                   RF_WrEn       = 1'd1;
                if (UART_RX_VLD)
                 begin
                   RF_WrData     = UART_RX_DATA ;
                   next_state    = IDLE;
                 end
                else
                   next_state = write_data;
                 end
  
  read_data  : begin
                 RF_RdEn         = 1'd1;
                if (UART_RX_VLD)
                 begin
                   RF_Address    = UART_RX_DATA[3:0];
                   next_state    = write_fifo; 
                 end
                else
                   next_state = read_data;
               end
  
   write_fifo : begin
                     UART_TX_VLD     = 1'd1;
                 if( RF_RdData_VLD && !FIFO_FULL)
                   begin 
                     UART_TX_DATA = RF_RdData;
                     next_state   = IDLE;
                   end
                 else
                   next_state   = write_fifo;
                 end
   
   
   write_alu_oper_A : begin
                         RF_WrEn       = 1'd1;
                         RF_Address    = 4'd0;
                       if( UART_RX_VLD)
                         begin
                         RF_WrData     = UART_RX_DATA ;
                         next_state    = write_alu_oper_B;
                         end
                       else
                         next_state = write_alu_oper_A;
                       end
  
                         
    write_alu_oper_B : begin
                         CLKG_EN       = 1'd1;
                         RF_Address    = 4'd1;
                         RF_WrEn       = 1'd1;
                       if( UART_RX_VLD)
                         begin
                         RF_WrData     = UART_RX_DATA;
                         next_state = alu_fun;
                         end
                       else
                         next_state = write_alu_oper_B;
                       end
  
   alu_fun           : begin 
                           CLKG_EN     = 1'd1;
                           ALU_EN      = 1'd1;
                        if(UART_RX_VLD)
                         begin
                           ALU_FUN    = UART_RX_DATA[3:0];
                           next_state = alu_write_fifo;
                          end
                        else
                          next_state = alu_fun;
                        end
                        
  alu_write_fifo    : begin
                           UART_TX_VLD     = 1'd1;
                       if (ALU_OUT <= 8'b11111111)
                         begin 
                        if(ALU_OUT_VLD && !FIFO_FULL)
                          begin
                            UART_TX_DATA = ALU_OUT;
                            next_state   = IDLE;
                          end
                       else
                           next_state  = alu_write_fifo;
                         end
                       else
                         begin
                           if(ALU_OUT_VLD && !FIFO_FULL)
                          begin
                            UART_TX_DATA  = ALU_OUT[7:0];
                            next_state    = alu_write_fifo_second;
                          end
                          else
                           next_state  = alu_write_fifo;
                          end
                    end
                            
    alu_write_fifo_second : begin  
                            UART_TX_VLD     = 1'd1;
                            UART_TX_DATA    = ALU_OUT[15:8];
                            next_state = IDLE;
                            
                            end 
                                      
      default            : begin
                           CLKDIV_EN       = 1'd1;
                           ALU_EN          = 1'd0;
                           CLKG_EN         = 1'd0;
                           RF_WrEn         = 1'd0;
                           RF_RdEn         = 1'd0;
                           UART_TX_VLD     = 1'd0;
                           ALU_FUN         = 4'd0;
						               UART_TX_DATA    = 8'd0;
                           RF_Address      = 4'd0;
						               RF_WrData       = 8'd0;
                           next_state      = IDLE;
                           end
                        
    endcase
  end

endmodule
          
