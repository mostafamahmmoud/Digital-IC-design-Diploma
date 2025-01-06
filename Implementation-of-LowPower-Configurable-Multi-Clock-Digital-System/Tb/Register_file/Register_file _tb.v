module Register_file_tb ();
  reg [15:0] WrData_tb;
  reg [3:0] Address_tb;
  reg WrEn_tb , RdEn_tb, CLK_tb, RST_tb;
  wire [15:0] RdData;
  
  
  always #5 CLK_tb = ~CLK_tb;
  
  Register_file DUT (
  .CLK(CLK_tb),
  .RST(RST_tb),
  .WrEn(WrEn_tb),
  .RdEn(RdEn_tb),
  .Address(Address_tb),
  .WrData(WrData_tb),
  .RdData(RdData_tb));
  
  initial 
  begin
    CLK_tb = 1'd0;
    WrEn_tb = 1'd0;
    RdEn_tb = 1'd0;
    WrData_tb = 16'd10;
    Address_tb = 3'd0;
   #10 RST_tb = 1'd0;
   #10 RST_tb = 1'd1;
   #10 WrEn_tb = 1'd1;
       Address_tb = 3'd0;
   #10 
   WrEn_tb = 1'd0;
   #20 WrEn_tb = 1'd1;
       Address_tb = 3'd2;
       WrData_tb = 16'd5;
   #20 WrEn_tb = 1'd0;
   #10 RdEn_tb = 1'd1;
       Address_tb = 3'd0;
   #20 
       Address_tb = 3'd2;
   #20 RdEn_tb = 1'd0;
   #20 WrEn_tb = 1'd1;
       Address_tb = 3'd1;
       WrData_tb = 16'd19;
   
   #20 Address_tb = 3'd7;
       WrData_tb = 16'd22;
   #20 WrEn_tb = 1'd0;
   #20 RdEn_tb = 1'd1;
       Address_tb = 3'd7;
       
       
       
   
  
     #100
     $finish;
   end
 endmodule
    
    
  
