module Adder #(parameter WIDTH)(  ////WIDTH=#INSTRUCTIONS
	input [WIDTH-1:0]SrcA,    // Clock 
	input [WIDTH-1:0]SrcB, // Clock Enable
	output reg [WIDTH-1:0] Result  // PC+4
);

 always @ ( SrcA or SrcB)
 begin
     Result = SrcA + SrcB;
 end

endmodule 