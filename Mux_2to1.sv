module Mux_2to1 
#(
	parameter WIDTH = 32
)
( 
input 	[WIDTH-1:0] X, Y,
input 	Sel,
output	[WIDTH-1:0] Z
);

assign Z = (Sel == 1'b0 ) ? X :
           (Sel == 1'b1 ) ? Y :
           1'bX;

endmodule
