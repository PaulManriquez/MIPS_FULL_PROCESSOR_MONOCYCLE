
module RegFile
(
  input clk,
  input reset,
  input [4 : 0] Write_Register,
  input [31 : 0] Write_Data,
  input reg_Write,	 

  input [4 : 0] Read_Register_1,
  input [4 : 0] Read_Register_2,
  output [31 : 0]Read_Data_1,
  output [31 : 0]Read_Data_2
);

  reg [31:0] reg_File [0:31];  // 32 bit memory with 32 entries 
  
    
/*--------------------------- Save Data -----------------------------*/
  always @ (posedge clk, negedge reset) begin
    if(~reset) begin
          $readmemb("reg_file.bin", reg_File);
        end
        if(reg_Write) begin                         
        	reg_File[Write_Register] <= Write_Data; 
          $writememb("reg_file.bin", reg_File);
        end  
      end  
/*------------------ Get data from register ------------------------*/
 
  assign Read_Data_1 = reg_File[Read_Register_1];
  assign Read_Data_2 = reg_File[Read_Register_2];

endmodule