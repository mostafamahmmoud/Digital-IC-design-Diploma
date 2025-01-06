module ASYN_FIFO #(parameter DATA_WIDTH = 8 , FIFO_DEPTH = 8,POINTER_WIDTH = 4) (
  input                      wclk,
  input                      wrst_n,
  input                      winc,
  input                      rclk,
  input                      rrst_n,
  input                      rinc,
  input  [DATA_WIDTH-1:0]    wdata,
  output                     rempty,
  output                     wfull,
  output [DATA_WIDTH-1:0]    rdata
  );
  
wire [POINTER_WIDTH-2:0] waddr,raddr;
wire [POINTER_WIDTH-1:0] wq2_rptr,rq2_wptr;
wire [POINTER_WIDTH-1:0] rptr,wptr;
  
FIFO_MEM #(.DATA_WIDTH(DATA_WIDTH), .FIFO_DEPTH(FIFO_DEPTH), .POINTER_WIDTH(POINTER_WIDTH))
U_FIFO_MEM (
.wclk(wclk),
.wrst_n(wrst_n),
.raddr(raddr),
.winc(winc),
.wfull(wfull),
.wdata(wdata),
.waddr(waddr),
.rdata(rdata));

FIFO_READ #(.POINTER_WIDTH(POINTER_WIDTH))
U_FIFO_READ (
.rinc(rinc),
.rq2_wptr(rq2_wptr),
.rclk(rclk),
.rrst_n(rrst_n),
.rempty(rempty),
.raddr(raddr),
.rptr(rptr));

FIFO_WRITE #(.POINTER_WIDTH(POINTER_WIDTH))
U_FIFO_WRITE (
.winc(winc),
.wq2_rptr(wq2_rptr),
.wclk(wclk),
.wrst_n(wrst_n),
.wfull(wfull),
.waddr(waddr),
.wptr(wptr));

SYNC_R2W #(.POINTER_WIDTH(POINTER_WIDTH))
U_SYNC_R2W (
.wrst_n(wrst_n),
.wclk(wclk),
.rptr(rptr),
.wq2_rptr(wq2_rptr));


SYNC_W2R #(.POINTER_WIDTH(POINTER_WIDTH))
U_SYNC_W2R (
.rrst_n(rrst_n),
.rclk(rclk),
.wptr(wptr),
.rq2_wptr(rq2_wptr));


endmodule



