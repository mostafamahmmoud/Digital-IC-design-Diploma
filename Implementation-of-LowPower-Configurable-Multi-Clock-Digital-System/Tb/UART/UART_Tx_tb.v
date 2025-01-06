module UART_tb;

    // Parameters
    parameter CLK_PERIOD = 10; // Clock period in time units

   
    reg CLK_tb;
    reg RST_tb;
    reg PAR_TYP_tb;
    reg PAR_EN_tb;
    reg [7:0] P_DATA_tb;
    reg DATA_Valid_tb;
    wire TX_OUT_tb;
    wire busy_tb;

    // Instantiate the UART TX module
      UART_Tx DUT (
        .CLK(CLK_tb),
        .RST(RST_tb),
        .PAR_TYP(PAR_TYP_tb),
        .PAR_EN(PAR_EN_tb),
        .P_DATA(P_DATA_tb),
        .DATA_Valid(DATA_Valid_tb),
        .TX_OUT(TX_OUT_tb),
        .busy(busy_tb)
    );

    // Clock generation
    always begin
        #(CLK_PERIOD/2) CLK_tb = ~CLK_tb;
    end

initial 
  begin
    DATA_Valid_tb = 1'd0;
    CLK_tb        = 1'd0;
    PAR_EN_tb     = 1'd1;
    PAR_TYP_tb    = 1'd1;
    
    RST_tb        = 1'd0;
   #(CLK_PERIOD) 
        RST_tb = 1'd1;
   #(CLK_PERIOD)
   
   DATA_Valid_tb = 1'd1;
   P_DATA_tb     = 8'h55;
   #(CLK_PERIOD)
    DATA_Valid_tb = 1'd0;
   
   #(10*CLK_PERIOD) 
    if (busy_tb == 1'd0)
     $display (" the transmission is completed ");
   else
     $display (" the transmission is not completed ");
   $finish;
 end
 endmodule

