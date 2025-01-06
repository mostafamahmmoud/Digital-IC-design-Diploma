module SYS_CTRL_tb ();
reg            CLK_tb;
reg            RST_tb;
reg  [15:0]    ALU_OUT_tb;
reg            ALU_OUT_VLD_tb;
reg  [7:0]     RF_RdData_tb;
reg            RF_RdData_VLD_tb;
reg  [7:0]     UART_RX_DATA_tb;
reg            FIFO_FULL_tb;
reg            UART_RX_VLD_tb;
wire [3:0]     ALU_FUN_tb;
wire           ALU_EN_tb;
wire           CLKG_EN_tb;
wire [3:0]     RF_Address_tb;
wire           RF_WrEn_tb;
wire           RF_RdEn_tb;
wire [7:0]     RF_WrData_tb;   //reg_file
wire [7:0]     UART_TX_DATA_tb;  //FIFO
wire           UART_TX_VLD_tb;   //FIFO
wire           CLKDIV_EN_tb;



SYS_CTRL DUT (
.CLK(CLK_tb),
.RST(RST_tb),
.ALU_OUT(ALU_OUT_tb),
.ALU_OUT_VLD(ALU_OUT_VLD_tb),
.RF_RdData(RF_RdData_tb),
.RF_RdData_VLD(RF_RdData_VLD_tb),
.UART_RX_DATA(UART_RX_DATA_tb),
.FIFO_FULL(FIFO_FULL_tb),
.UART_RX_VLD(UART_RX_VLD_tb),
.ALU_FUN(ALU_FUN_tb),
.ALU_EN(ALU_EN_tb),
.CLKG_EN(CLKG_EN_tb),
.RF_Address(RF_Address_tb),
.RF_WrEn(RF_WrEn_tb),
.RF_RdEn(RF_RdEn_tb),
.RF_WrData(RF_WrData_tb),
.UART_TX_DATA(UART_TX_DATA_tb),
.UART_TX_VLD(UART_TX_VLD_tb),
.CLKDIV_EN(CLKDIV_EN_tb)
);

always #10 CLK_tb = !CLK_tb ;

initial 
 begin 
   CLK_tb       = 1'd0;
   RST_tb       = 1'd1;
   FIFO_FULL_tb = 1'd0;
   #10 
   RST_tb       = 1'd0;
   #10
   RST_tb       = 1'd1;
   
   #20
   UART_RX_DATA_tb  = 8'hbb; //read_CMD
   UART_RX_VLD_tb   = 1'd1;
   #10 
   UART_RX_DATA_tb  = 'b0001; //address
   UART_RX_VLD_tb   = 1'd1;
   #10 
   UART_RX_DATA_tb  = 8'hff;
   RF_RdData_VLD_tb = 1'd1;
   #100 
   UART_RX_DATA_tb  = 8'hAA; //write_CMD
   UART_RX_VLD_tb   = 1'd1;
   #10 
   UART_RX_DATA_tb  = 'b0001; //Address
   UART_RX_VLD_tb   = 1'd1;
   #10 
   UART_RX_DATA_tb  = 'hff; //wrie_value
   UART_RX_VLD_tb   = 1'd1;
   #100 
   UART_RX_DATA_tb  = 8'hCC; //ALU_oper_CMD
   UART_RX_VLD_tb   = 1'd1;
   #10 
   UART_RX_DATA_tb  = 'h5; //wrie_value_A
   UART_RX_VLD_tb   = 1'd1;
   #10 
   UART_RX_DATA_tb  = 'h10; //wrie_value_B
   UART_RX_VLD_tb   = 1'd1;
   #10 
   UART_RX_DATA_tb  = 'b0110; //ALU_FUN_0110_ADD
   UART_RX_VLD_tb   = 1'd1;
   #20 
   ALU_OUT_tb       = 'd15;
   ALU_OUT_VLD_tb   = 1'd1;
   
   
   #100 
   $finish;
 end
 endmodule
   
   
   