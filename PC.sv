module PC #(parameter WIDTH)(    //// WIDTH=#INSTRUCTIONS 
	input [WIDTH-1:0] DataIn, //pc+4
	input clk,    // Clock
	input rst, // reset
	output reg [WIDTH-1:0] DataOut
);
      always @ (posedge clk or negedge rst) begin   
           if(~rst) begin  
             	DataOut=5'b00000;
             end  
           else begin  
           		DataOut=DataIn;
           end  
      end 
endmodule 

