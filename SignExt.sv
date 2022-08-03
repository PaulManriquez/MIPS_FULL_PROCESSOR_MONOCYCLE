module SignExt(
  input wire [15:0] DataIn,
  output reg [31:0] DataOut);

  always @*
    begin
      if (DataIn[15]==0)
        DataOut[31:16] = 16'b0000000000000000;
      else
        DataOut[31:16] = 16'b1111111111111111;
		  
		DataOut[15:0] = DataIn;
    end
endmodule