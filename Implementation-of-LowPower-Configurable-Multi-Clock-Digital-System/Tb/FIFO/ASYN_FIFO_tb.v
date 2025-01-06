module ASYN_FIFO_tb #(parameter DATA_WIDTH_tb = 8 , FIFO_DEPTH_tb = 8,POINTER_WIDTH_tb = 4) ();
  reg                      wclk_tb;
  reg                      wrst_n_tb;
  reg                      winc_tb;
  reg                      rclk_tb;
  reg                      rrst_n_tb;
  reg                      rinc_tb;
  reg  [DATA_WIDTH_tb-1:0] wdata_tb;
  wire                     rempty_tb;
  wire                     wfull_tb;
  wire [DATA_WIDTH_tb-1:0] rdata_tb;


ASYN_FIFO #(.DATA_WIDTH(DATA_WIDTH_tb), .FIFO_DEPTH(FIFO_DEPTH_tb), .POINTER_WIDTH(POINTER_WIDTH_tb))
DUT (
.wclk(wclk_tb),
.wrst_n(wrst_n_tb),
.winc(winc_tb),
.rclk(rclk_tb),
.rrst_n(rrst_n_tb),
.rinc(rinc_tb),
.wdata(wdata_tb),
.rempty(rempty_tb),
.wfull(wfull_tb),
.rdata(rdata_tb));



parameter CLOCK_PERIOD_W=10;
parameter CLOCK_PERIOD_R=20;

always#(CLOCK_PERIOD_W/2.0)   wclk_tb=!wclk_tb;
always#(CLOCK_PERIOD_R/2.0)   rclk_tb=!rclk_tb;


initial 
 begin
   rclk_tb   = 1'd0;
   wclk_tb   = 1'd0;
   wrst_n_tb = 1'd1;
   rrst_n_tb = 1'd1;
   #(CLOCK_PERIOD_W)
    wrst_n_tb = 1'd0;
   #(CLOCK_PERIOD_R)
    rrst_n_tb = 1'd0;
   #(CLOCK_PERIOD_W)
    wrst_n_tb = 1'd1;
   #(CLOCK_PERIOD_R)
    rrst_n_tb = 1'd1;
    
   #(CLOCK_PERIOD_W)
    winc_tb  = 1'd1;
    wdata_tb = 8'hff;
    #(CLOCK_PERIOD_W)
    winc_tb  = 1'd1;
    wdata_tb = 8'hAB;
   #(CLOCK_PERIOD_R)
   rinc_tb  = 1'd1;
   #(CLOCK_PERIOD_R)
    rinc_tb  = 1'd0;
   #(10*CLOCK_PERIOD_R)
   $finish;
   
 end
 endmodule
   
   



