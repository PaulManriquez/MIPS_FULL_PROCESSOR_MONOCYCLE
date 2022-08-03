module Control(
	input [5:0]  		Opcode,
	output reg			RegDst,
	output reg 	 		ALUSrc,
	output reg 	 		MemtoReg,	
	output reg	 		RegWrite,
	output reg	 		MemWrite,
	output reg	 		Branch,
	output reg [2:0] 	ALUOp,	
	output reg		 	Jump,		
	output reg	 		XorBne	
);

	
	always @(Opcode) begin
		
		case(Opcode)
			6'b000000 : {RegDst,ALUSrc,MemtoReg, RegWrite, MemWrite, Branch,ALUOp, Jump, XorBne} = 11'b10010000000;	// R-Type (add, sub, and, or, slt)  000
			6'b100011 : {RegDst,ALUSrc,MemtoReg, RegWrite, MemWrite, Branch,ALUOp, Jump, XorBne} = 11'b01110000100;	// LW		001	
			6'b101011 : {RegDst,ALUSrc,MemtoReg, RegWrite, MemWrite, Branch,ALUOp, Jump, XorBne} = 11'b11101001000;	// SW		010
			
			6'b000100 : {RegDst,ALUSrc,MemtoReg, RegWrite, MemWrite, Branch,ALUOp, Jump, XorBne} = 11'b00000101100;	// BEQ	011
			6'b000101 : {RegDst,ALUSrc,MemtoReg, RegWrite, MemWrite, Branch,ALUOp, Jump, XorBne} = 11'b00000110001;	// BNE	100***
			6'b000010 : {RegDst,ALUSrc,MemtoReg, RegWrite, MemWrite, Branch,ALUOp, Jump, XorBne} = 11'b00000110110;	// jump	101***
			default:		{RegDst,ALUSrc,MemtoReg, RegWrite, MemWrite, Branch,ALUOp, Jump, XorBne} = 11'bzzzzzzzzzzz;
		endcase
	end
endmodule