module ALU_TOP #(
  parameter A_WIDTH = 16 ,
  parameter LM_WIDTH = 1 )
  (
  input [A_WIDTH-1:0] A,B,
  input [3:0] ALU_FUN,
  input CLK,RST,
  output [A_WIDTH-1:0] Arith_OUT,
  output carry_OUT,
  output Arith_flag,Logic_flag,CMP_flag,SHIFT_flag,
  output [A_WIDTH-1:0] Logic_OUT,
  output CMP_OUT,
  output [A_WIDTH-1:0] SHIFT_OUT );
  
  wire Arith_Enable,Logic_Enable,CMP_Enable,Shift_Enable;
  
  Decoder_Unit U_Decoder (
  .ALU_FUN(ALU_FUN),
  .Arith_Enable(Arith_Enable),
  .Logic_Enable(Logic_Enable),
  .CMP_Enable(CMP_Enable),
  .Shift_Enable(Shift_Enable));
  
  
  ARITHMETIC_UNIT U_Arithmetic(
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN),
  .RST(RST),
  .CLK(CLK),
  .Arith_OUT(Arith_OUT),
  .carry_OUT(carry_OUT),
  .Arith_flag(Arith_flag),
  .Arith_Enable(Arith_Enable));
  
  
  LOGIC_UNIT U_Logic(
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN),
  .CLK(CLK),
  .RST(RST),
  .Logic_OUT(Logic_OUT),
  .Logic_flag(Logic_flag),
  .Logic_Enable(Logic_Enable));
  
CMP_UNIT U_CMP (
  .A(A),
  .B(B),
  .ALU_FUN(ALU_FUN),
  .CLK(CLK),
  .RST(RST),
  .CMP_OUT(LCMP_OUT),
  .CMP_flag(CMP_flag),
  .CMP_Enable(CMP_Enable));
  
  SHIFT_UNIT U_SHIFT (
  .A(A),
  .B(B),
  .RST(RST),
  .ALU_FUN(ALU_FUN),
  .CLK(CLK),
  .SHIFT_OUT(SHIFT_OUT),
  .SHIFT_flag(SHIFT_flag),
  .Shift_Enable(SHIFT_Enable));
  
  
endmodule
  
  
  

  

  
  
  
  

