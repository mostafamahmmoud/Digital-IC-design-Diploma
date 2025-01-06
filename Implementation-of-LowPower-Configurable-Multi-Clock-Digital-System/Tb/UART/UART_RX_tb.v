module UART_RX_tb ();
reg        RX_IN_tb,PAR_EN_tb,PAR_TYP_tb;
reg        CLK_tb,RST_tb;
reg  [4:0] Prescale_tb;
wire [7:0] P_DATA_tb;
wire       data_valid_tb;





parameter CLOCK_PERIOD=10;

always#(CLOCK_PERIOD/2.0)   CLK_tb=!CLK_tb;





UART_RX DUT (
.RX_IN(RX_IN_tb),
.Prescale(Prescale_tb),
.PAR_EN(PAR_EN_tb),
.PAR_TYP(PAR_TYP_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.P_DATA(P_DATA_tb),
.data_valid(data_valid_tb));






initial
begin
$dumpfile("UART_RX_tb.vcd");
$dumpvars;
initialize();
reset();

PAR_EN_tb  ='b1;
PAR_TYP_tb ='b1;

///////FRAME 1 VALID//////
//START
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
//////-----DATA 10101010---------
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);

//PARITY
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);


//STOP
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);


/////stop  error frame 

//START
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
//////-----DATA 10001010---------
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);

//PARITY
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);


//STOP
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);



////////PARITY ERROR FRAME
//START
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
//////-----DATA 10000010---------
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);

//PARITY
RX_IN_tb='b0;
repeat(16) #(CLOCK_PERIOD);


//STOP
RX_IN_tb='b1;
repeat(16) #(CLOCK_PERIOD);
#100
$finish;

end
task initialize;
  begin
    CLK_tb = 1'd0;
    RX_IN_tb='b0;
    Prescale_tb='d16;
    PAR_EN_tb='b0;
    PAR_TYP_tb='b0;
  end
endtask







 task reset ;
	begin
		#(CLOCK_PERIOD)
		RST_tb  = 'b0;           // rst is activated
		#(CLOCK_PERIOD)
		RST_tb  = 'b1;
	end
endtask



endmodule
