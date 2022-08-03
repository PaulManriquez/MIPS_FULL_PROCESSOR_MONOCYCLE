module DataMem(
	input clk,
	input rst,
	input [31:0] WD,	// 32bit data input word
	input [31:0] A,		// Address for 16 locations (2**4)
	input we,			// Active high
	output [31:0] RD	// 32bit output word
);

	// Declare A bidimensional Array for the RAM
	reg [31:0] ram [0:63];
	reg [31:0] addr_buff;
	
	// RAM's don't have reset
	// The default value from each location is X
	// The write is synchronous
	
	initial
	begin
		$readmemb("ram_init.bin", ram);
	end
	
	always @(posedge clk or negedge rst) begin
		if(~rst) begin  
             	$readmemb("ram_init.bin", ram);
		end  
		else begin  
			if(we) begin
				ram[A] = WD;
				$writememb("ram_init.bin", ram);
			end
		end  	
		
	end
	
	
	// The read is synchronous As the Address
	// was buffered on the clk using Addr_buff
	assign RD = ram[A];
endmodule