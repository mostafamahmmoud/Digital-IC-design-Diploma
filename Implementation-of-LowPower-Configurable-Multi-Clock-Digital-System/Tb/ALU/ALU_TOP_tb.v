module ALU_TOP_tb ();
  reg [15:0] A_tb,B_tb;
  reg [3:0] ALU_FUN_tb ;
  reg CLK_tb;
  reg RST_tb;
  wire [15:0] Arith_OUT_tb , Logic_OUT_tb,SHIFT_OUT_tb;
  wire carry_OUT_tb,Arith_flag_tb,Logic_flag_tb,CMP_flag_tb,CMP_OUT_tb,SHIFT_flag_tb;
  
  
 ALU_TOP DUT(
  .A(A_tb),
  .B(B_tb),
  .CLK(CLK_tb),
  .RST(RST_tb),
  .Arith_OUT(Arith_OUT_tb),
  .Logic_OUT(Logic_OUT_tb),
  .CMP_OUT(CMP_OUT_tb),
  .SHIFT_OUT(SHIFT_OUT_tb),
  .carry_OUT(carry_OUT_tb),
  .Arith_flag(Arith_flag_tb),
  .Logic_flag(Logic_flag_tb),
  .CMP_flag(CMP_flag_tb),
  .SHIFT_flag(SHIFT_flag_tb),
  .ALU_FUN(ALU_FUN_tb));
  

always begin
 #6 CLK_tb = 1'd1;
 #4 CLK_tb = 1'd0;
 end
 

initial
begin 
  CLK_tb = 1'd0;
 
  A_tb = 16'd10;
  B_tb = 16'd5;
  #10 RST_tb = 1'd0;
  if ( Arith_OUT_tb == 16'd0 )
    $display ("reset test is passed" );   
  else
    $display ("reset test is faild ");
  #10 RST_tb = 1'd1;
  // Arith_operations
  #10 ALU_FUN_tb = 4'b0000;
  #10 if ( Arith_OUT_tb == 16'd15)
   $display ("ADD test is passed" );   
  else
    $display ("ADD test is faild ");
    
  #10 ALU_FUN_tb = 4'b0001;
  #10 ALU_FUN_tb = 4'b0010;
  #10 ALU_FUN_tb = 4'b0011;

  //Logic_operations
  
  #20 ALU_FUN_tb = 4'b0101;
  #20 ALU_FUN_tb = 4'b0101;
  #20 ALU_FUN_tb = 4'b0110;
  #20 ALU_FUN_tb = 4'b0111;
 
 //CMP_operations
  
  #20 ALU_FUN_tb = 4'b1000;
  #20 ALU_FUN_tb = 4'b1001;
  #20 ALU_FUN_tb = 4'b1010;
  #20 ALU_FUN_tb = 4'b1011;
  
  //SHIFT_operations
 
  #20 ALU_FUN_tb = 4'b1100;
  #20 ALU_FUN_tb = 4'b1101;
  #20 ALU_FUN_tb = 4'b1110;
  #20 ALU_FUN_tb = 4'b1111;

  
  
#100 
$finish;
end
endmodule
  
  
  
  
  
