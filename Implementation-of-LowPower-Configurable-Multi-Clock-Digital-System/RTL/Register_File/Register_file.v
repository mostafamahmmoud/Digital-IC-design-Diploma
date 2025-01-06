module Register_file (
  input [15:0] WrData,
  input [2:0] Address,
  input WrEn , RdEn , CLK ,RST,
  output reg [15:0] RdData);
  
  reg [15:0] Reg_file [7:0] ;
  
always @ ( posedge CLK or negedge RST )
begin
  if (!RST)
    begin
      Reg_file[0] <= 16'd0;
      Reg_file[1] <= 16'd0;
      Reg_file[2] <= 16'd0;
      Reg_file[3] <= 16'd0;
      Reg_file[4] <= 16'd0;
      Reg_file[5] <= 16'd0;
      Reg_file[6] <= 16'd0;
      Reg_file[7] <= 16'd0;
    end
  else
    begin
     if (WrEn)
       Reg_file[Address] <= WrData;
     if(RdData)
       RdData <= Reg_file[Address];
     end
   end
 endmodule
 
       
       
     
      
      