module UART_Tx (
  input [7:0] P_DATA ,
  input       DATA_Valid,
  input       CLK,RST,
  input       PAR_TYP,
  input       PAR_EN,
  output      TX_OUT,
  output      busy );
  
serializer U_serializer (
.CLK(CLK),
.RST(RST),
.ser_done(ser_done),
.ser_en(ser_en),
.P_DATA(P_DATA));
  
parity_calc U_parity_calc (
.CLK(CLK),
.RST(RST), 
.P_DATA(P_DATA),
.DATA_Valid(DATA_Valid),
.PAR_TYP(PAR_TYP),
.par_bit(par_bit));

FSM U_FSM (
.CLK(CLK),
.RST(RST),
.DATA_Valid(DATA_Valid),
.PAR_EN(PAR_EN),
.ser_done(ser_done),
.ser_en(ser_en),
.mux_sel(mux_sel),
.busy(busy));

MUX U_MAX (
.CLK(CLK),
.RST(RST),
.par_bit(par_bit),
.mux_sel(mux_sel),
.start_bit(start_bit),
.stop_bit(stop_bit),
.ser_data(ser_data),
.TX_OUT(TX_OUT));

endmodule