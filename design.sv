module Processor(  
      input clk,                    
      input rst                        
 );
 
parameter WIDTH = 32;

wire 	[31:0] w_instruction;
wire 	[31:0] w_next_pc;
wire 	[31:0] w_pc;
wire 	[31:0] w_pc1;
wire 	[31:0] w_inst_ext;
wire 	[31:0] w_ext_pc1;
wire 	w_and;
wire 	[31:0] w_extpc1_branch;
wire 	[4:0] w_rt_rd;
wire 	[31:0] w_r1;
wire 	[31:0] w_r2;
wire 	[31:0] w_r2_ext;
wire 	[31:0] w_alu;
wire 	[31:0] w_dm;
wire 	[31:0] w_dm_alu;
wire 	[2:0] w_alu_ctrl;
wire 	w_zero;
wire 	w_xor;


wire	w_RegDst;
wire 	w_Jump;
wire 	w_Branch;
wire 	w_MemtoReg;
wire 	[2:0] w_ALUOp;
wire 	w_MemWrite;
wire 	w_ALUSrc;
wire 	w_RegWrite;
wire 	w_XorBne;

Control
Control_1
(
	.Opcode(w_instruction[31:26]),
	.RegDst(w_RegDst),
	.Jump(w_Jump),
	.Branch(w_Branch),
	.MemtoReg(w_MemtoReg),
	.ALUOp(w_ALUOp),
	.MemWrite(w_MemWrite),
	.ALUSrc(w_ALUSrc),
	.RegWrite(w_RegWrite),
	.XorBne(w_XorBne)
);

ALU_control
Alu_control_1
(
	.instruction(w_instruction[5:0]),
	.ctrl(w_ALUOp),
	.ctrl_out(w_alu_ctrl)
);

PC #(
	.WIDTH(WIDTH)
) 
PC_1
(
	.clk(clk),
	.rst(rst),
	.DataIn(w_next_pc),
	
	.DataOut(w_pc) 
);

Adder #(
	.WIDTH(WIDTH)
) 
Adder_1
(
	.SrcA(w_pc),
	.SrcB(1),
	.Result(w_pc1) 
);

InstMem 
InstMem_1
(
	.addr(w_pc),
  	.q(w_instruction) 
);

Mux_2to1 
#(
  .WIDTH(5)
)
Mux_2to1_rt_rd
( 
	.X(w_instruction[20:16]), 
	.Y(w_instruction[15:11]),
	.Sel(w_RegDst),
	.Z(w_rt_rd)
);

RegFile 
RegFile_1
(
	.clk(clk), 
	.reset(rst), 
	.Read_Register_1(w_instruction[25:21]),
	.Read_Register_2(w_instruction[20:16]),
	.Write_Register(w_rt_rd), 
	.Write_Data(w_dm_alu),
	.reg_Write(w_RegWrite),
	
	.Read_Data_1(w_r1),
	.Read_Data_2(w_r2)
);

Mux_2to1 
#(
	.WIDTH(WIDTH)
)
Mux_2to1_r2_ext
( 
	.X(w_r2), 
	.Y(w_inst_ext),
	.Sel(w_ALUSrc),
	
	.Z(w_r2_ext)
);


SignExt 
SignExt_1
(
	.DataIn(w_instruction[15:0]), 
	.DataOut(w_inst_ext)
);

Adder #(
	.WIDTH(WIDTH)
) 
Adder_2
(
	.SrcA(w_pc1),
	.SrcB(w_inst_ext),
	
	.Result(w_ext_pc1) 
);

Mux_2to1 
#(
	.WIDTH(WIDTH)
)
Mux_2to1_branch1
( 
	.X(w_pc1), 
	.Y(w_ext_pc1),
	.Sel(w_and),
	
	.Z(w_extpc1_branch)
);

Mux_2to1 
#(
	.WIDTH(WIDTH)
)
Mux_2to1_branch2
( 
	.X(w_extpc1_branch), 
	.Y({w_pc1[31:26],w_instruction[25:0]}),
	.Sel(w_Jump),
	
	.Z(w_next_pc)
);

ALU 
ALU_1
(
    .ALUCtl(w_alu_ctrl),
	.SrcA(w_r1),
	.SrcB(w_r2_ext),
	.Result(w_alu),
	.Zero(w_zero)
);


XOR_gate 
XOR_gate_1
(
	.A(w_zero), 
	.B(w_XorBne),
	
	.Y(w_xor)
);

AND_gate 
AND_gate_1
(
	.A(w_xor), 
	.B(w_Branch),
	.Y(w_and) 
);

DataMem 
DataMem_1
(
	.clk(clk),
	.rst(rst),
	.WD(w_r2),
	.A(w_alu),
	.we(w_MemWrite),
	.RD(w_dm)
);

Mux_2to1 
#(
	.WIDTH(WIDTH)
)
Mux_2to1_mem
( 
	.X(w_alu), 
	.Y(w_dm),
	.Sel(w_MemtoReg),
	.Z(w_dm_alu)
);

 
endmodule