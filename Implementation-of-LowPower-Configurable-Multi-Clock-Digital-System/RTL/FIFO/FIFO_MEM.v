module FIFO_MEM #(parameter DATA_WIDTH = 8 , FIFO_DEPTH = 8,POINTER_WIDTH = 4) (
  input                      wclk,
  input                      wrst_n,
  input  [POINTER_WIDTH-2:0] raddr,
  //input                      wclken,
  input                      winc,
  input                      wfull,
  input  [DATA_WIDTH-1:0]    wdata,
  input  [POINTER_WIDTH-2:0] waddr,
  output [DATA_WIDTH-1:0]    rdata
  );
  
  reg [DATA_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
  integer i;
  
  //assign wclken = winc & !wfull ;
  
  always @ (posedge wclk or negedge wrst_n )
   begin
     if (!wrst_n)
       begin
         for (i = 'd0 ; i < FIFO_DEPTH ; i = i + 'd1)
           mem[i] <= {DATA_WIDTH{1'd0}};
         end
      else if (winc && !wfull)
        mem[waddr] <= wdata ;
      end
      
      
      assign rdata = mem[raddr] ;
      
      
endmodule 
        
         
  
