module FIFO_WRITE #(parameter POINTER_WIDTH = 4 ) (
  input                          winc,
  input      [POINTER_WIDTH-1:0] wq2_rptr,
  input                          wclk,
  input                          wrst_n,
  output reg                     wfull,
  output     [POINTER_WIDTH-2:0] waddr,
  output reg [POINTER_WIDTH-1:0] wptr 
  );
reg [POINTER_WIDTH-1:0] write_ptr;


always @(posedge wclk or negedge wrst_n )
 begin
  if (!wrst_n)
    write_ptr <= {POINTER_WIDTH{1'd0}};
  else if (!wfull && winc)
    write_ptr <= write_ptr + {POINTER_WIDTH{1'd1}};
  else
    write_ptr <= {POINTER_WIDTH{1'd0}};
  end
  
  assign waddr = write_ptr[POINTER_WIDTH-2:0];
  
  always @(posedge wclk or negedge wrst_n )
   begin
    if (!wrst_n)
      wptr <= {POINTER_WIDTH{1'd0}};
    else
      begin
        case (write_ptr) 
          
          4'b0000: wptr <= 4'b0000;
          4'b0001: wptr <= 4'b0001;
          4'b0010: wptr <= 4'b0011;
          4'b0011: wptr <= 4'b0010;
          4'b0100: wptr <= 4'b0110;
          4'b0101: wptr <= 4'b0111;
          4'b0110: wptr <= 4'b0101;
          4'b0111: wptr <= 4'b0100;
          4'b1000: wptr <= 4'b1100;
          4'b1001: wptr <= 4'b1101;
          4'b1010: wptr <= 4'b1111;
          4'b1011: wptr <= 4'b1110;
          4'b1100: wptr <= 4'b1010;
          4'b1101: wptr <= 4'b1011;
          4'b1110: wptr <= 4'b1001;
          4'b1111: wptr <= 4'b1000;
          
       endcase
     end
   end
     
  
  
  always@(*)
   begin 
     if (wptr[POINTER_WIDTH-1] != wq2_rptr[POINTER_WIDTH-1] && wptr[POINTER_WIDTH-2] != wq2_rptr[POINTER_WIDTH-2] && wptr[POINTER_WIDTH-3:0] != wq2_rptr[POINTER_WIDTH-3:0])
       wfull = 1'd1;
     else
       wfull = 1'd0;
     end


endmodule
  
  
    

