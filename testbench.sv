`timescale 1ns/1ps
`include "ALU_control.sv"
`include "ALU.sv"
`include "Control.sv"
`include "PC.sv"
`include "Adder.sv"
`include "InstMem.sv"
`include "Mux_2to1.sv"
`include "RegFile.sv"
`include "SignExt.sv"
`include "XOR_gate.sv"
`include "AND_gate.sv"
`include "DataMem.sv"

module TOP_tb;
 
  reg clk,rts;
  string array[] = {"$zero","$at","$v0","$v1","$a0","$a1","$a2","$a3",
                 "$t0","$t1","$t2","$t3","$t4","$t5","$t6","$t7",
                 "$s0","$s1","$s2","$s3","$s4","$s5","$s6","$s6",
                 "$t8","$t8","$k0","$k1","$gp","$sp","$fp","$ra"};
  integer i,j;
  Processor DUT (clk,rts);
  
  initial begin
	clk = 0;
	rts = 1;
	#2
	rts = 0;
	#2
	rts = 1;
    $monitor("PC: %d", DUT.w_pc);
    #150 //instructions cycles
    $display("--------------------------------------------------");
    for(i = 0; i < 32; i++) begin
      $display("RegFile Content %s : %d ",array[i],DUT.RegFile_1.reg_File[i]);
    end
    $display("--------------------------------------------------");
    for(i = 0; i < 32; i++) begin
      $display("RAM: %d :",DUT.DataMem_1.ram[i]);
    end
    $finish;
  end
  
  always #1 clk = ~clk;
  
endmodule





