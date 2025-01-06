module FIFO_READ #(parameter POINTER_WIDTH = 4 ) (
  input                          rinc,
  input                          rq2_wptr,
  input                          rclk,
  input                          rrst_n,
  output                         rempty,
  output     [POINTER_WIDTH-2:0] raddr,
  output reg [POINTER_WIDTH-1:0] rptr 
  );
reg [POINTER_WIDTH-1:0] ptr;


always @(posedge rclk or negedge rrst_n )
 begin
  if (!rrst_n)
    ptr <= {POINTER_WIDTH{1'd0}};
  else if (!rempty && rinc)
    ptr <= ptr + {POINTER_WIDTH{1'd1}};
  else
    ptr <= {POINTER_WIDTH{1'd0}};
  end
  
  assign raddr = ptr[POINTER_WIDTH-2:0];
  
  always @(posedge rclk or negedge rrst_n )
   begin
    if (!rrst_n)
      rptr <= {POINTER_WIDTH{1'd0}};
    else
      begin
        case (ptr) 
          
          4'b0000: rptr <= 4'b0000;
          4'b0001: rptr <= 4'b0001;
          4'b0010: rptr <= 4'b0011;
          4'b0011: rptr <= 4'b0010;
          4'b0100: rptr <= 4'b0110;
          4'b0101: rptr <= 4'b0111;
          4'b0110: rptr <= 4'b0101;
          4'b0111: rptr <= 4'b0100;
          4'b1000: rptr <= 4'b1100;
          4'b1001: rptr <= 4'b1101;
          4'b1010: rptr <= 4'b1111;
          4'b1011: rptr <= 4'b1110;
          4'b1100: rptr <= 4'b1010;
          4'b1101: rptr <= 4'b1011;
          4'b1110: rptr <= 4'b1001;
          4'b1111: rptr <= 4'b1000;
          
       endcase
     end
   end
     
  
  
  assign rempty = rq2_wptr == rptr ? 1 : 0;


endmodule
  
  
    