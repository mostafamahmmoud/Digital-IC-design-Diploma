module UART_RX ( 
 input        CLK,
 input        RST,
 input        RX_IN,
 input  [4:0] Prescale,
 input        PAR_EN,
 input        PAR_TYP,
 output       data_valid,
 output [7:0] P_DATA );
 
 wire [3:0] bit_cnt;
 wire [4:0] edge_cnt;
 wire       strt_glitch   ,stp_err   ,par_err;
 wire       stp_chk_en,strt_chk_en,par_chk_en;
 wire       enable, deser_en, data_samp_en;
 wire       sampled_bit;

RX_FSM U0_RX_FSM (
 .RX_IN(RX_IN),
 .PAR_EN(PAR_EN),
 .CLK(CLK),
 .RST(RST),
 .bit_cnt(bit_cnt),
 .edge_cnt(edge_cnt),
 .strt_glitch(strt_glitch),
 .par_err(par_err),
 .stp_err(stp_err),
 .strt_chk_en(strt_chk_en),
 .par_chk_en(par_chk_en),
 .stp_chk_en(stp_chk_en),
 .deser_en(deser_en), 
 .edge_bit_en(edge_bit_en), 
 .data_samp_en(data_samp_en),
 .data_valid(data_valid)
 );
 
 deserializer U0_deserializer (
 .sampled_bit(sampled_bit),
 .deser_en(deser_en),
 .bit_cnt(bit_cnt),
 .edge_cnt(edge_cnt),
 .CLK(CLK),
 .RST(RST),
 .P_DATA(P_DATA)
 );
 
 
 data_sampling U0_data_sampling (
 .RX_IN(RX_IN),
 .Prescale(Prescale),
 .CLK(CLK),
 .RST(RST),
 .edge_cnt(edge_cnt),
 .data_samp_en(data_samp_en),
 .sampled_bit(sampled_bit)
 );
 
 
 edge_bit_counter U0_edge_bit_counter (
 .edge_bit_en(edge_bit_en),
 .CLK(CLK),
 .RST(RST),
 .bit_cnt(bit_cnt),
 .edge_cnt(edge_cnt)
 );
 
 strt_Check U0_strt_Check (
 .sampled_bit(sampled_bit),
 .strt_chk_en(strt_chk_en),
 .CLK(CLK),
 .RST(RST),
 .strt_glitch(strt_glitch)
 );
 
 parity_Check U0_parity_Check (
 .sampled_bit(sampled_bit),
 .par_chk_en(par_chk_en),
 .PAR_TYP(PAR_TYP),
 .P_DATA(P_DATA),
 .CLK(CLK),
 .RST(RST),
 .par_err(par_err)
 );
 
 Stop_Check U0_Stop_Check (
 .sampled_bit(sampled_bit),
 //.bit_cnt(bit_cnt),
 .stp_chk_en(stp_chk_en),
 .CLK(CLK),
 .RST(RST),
 .stp_err(stp_err)
 );
 
 
 endmodule