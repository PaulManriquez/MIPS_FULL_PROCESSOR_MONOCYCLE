module InstMem
  #(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32)
(
	input [(ADDR_WIDTH-1):0] addr,
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the ROM variable
  reg [DATA_WIDTH-1:0] rom[0:DATA_WIDTH-1];
	

	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file single_port_rom_init.txt.  Without this file,
	// this design will not compile.

	initial
	begin
		$readmemb("rom_init.bin", rom);
	end

	always @ (addr)
	begin
		q = {rom[addr]};
	end
	//
endmodule