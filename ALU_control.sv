module ALU_control(
  input  [5:0]instruction,
  input  [2:0]ctrl,
  output reg [2:0]ctrl_out 
);
  
  always @(instruction,ctrl)
    if(ctrl == 3'b000) begin 
      case ({ctrl,instruction}) 
        9'b000100000: ctrl_out = 3'b000;    //MIPS OP ADD
        9'b000100010: ctrl_out = 3'b001;    //MIPS OP SUB
        9'b000100100: ctrl_out = 3'b010;    //MIPS OP AND
        9'b000100101: ctrl_out = 3'b011;    //MIPS OP OR
        9'b000101010: ctrl_out = 3'b100;    //MIPS OP SLT
      endcase
    end else begin
      case(ctrl)
          3'b001: ctrl_out=3'b000;  //MIPS OP ADD   LW
          3'b010: ctrl_out=3'b000;  //MIPS OP ADD   SW 
          3'b011: ctrl_out=3'b001;  //MIPS OP SUB   BEQ
          3'b100: ctrl_out=3'b001;  //MIPS OP SUB   BNE
          3'b101: ctrl_out=3'b111;  // MIPS J
      endcase
  end

endmodule
      