module Datapath (input clk,rst,pc_write,pc_write_cond,IorD,IR_write,Pc_src
,input readmem,writemem,MtoS,ld_A,ld_B,pop,push,tos,Sel_A,Sel_B
,input[1:0]controller_command
,output[2:0]opcode);
  
  wire zero,pc_en,pc_jump_en;
  wire[7:0] command,A_in,B_in;
  wire[7:0] alu_result,a_out,b_out,alu_out_reg;
  wire[7:0]readmem_out;
  wire [4:0] pc;
  wire [4:0]pc_next;
  wire [4:0] address;
  wire [7:0] memory_out,d_out,d_in;

  
  //PC PART
  assign pc_jump_en = pc_write_cond & zero;
  assign pc_en = pc_jump_en | pc_write;
  Pcreg p(clk,pc_en,pc_next,pc); 

  //MEMORY PART
  Mux #(5) memory_mux(command[4:0],pc,IorD,address); 
  Memory memroy(address,a_out,clk,writemem,readmem,readmem_out);

  //saving readmem_out in IR reg and MDR reg
  Reg #(8) MDR(clk,1'b1,readmem_out,memory_out);
  Reg #(8) IR(clk,IR_write,readmem_out,command);
  assign opcode=command[7:5]; //assign operation type and send it to controller

  //STACK PART
  Mux #(8) MtoS_mux(memory_out,alu_out_reg,MtoS,d_in);
  Stack stack(clk,pop,push,tos,d_in,d_out);
  Reg #(8) A_reg(clk,ld_A,d_out,a_out);
  Reg #(8) B_reg(clk,ld_B,d_out,b_out);
  assign zero=(d_out==8'b0)?1'b1:1'b0;

  //ALU PART
  Mux #(8) A_in_mux({1'b0,1'b0,1'b0,pc},a_out,Sel_A,A_in);
  Mux #(8) B_in_mux(8'b00000001,b_out,Sel_B,B_in);
  ALU alu(controller_command,A_in,B_in,alu_result);
  Reg #(8) ALU_reg(clk,1'b1,alu_result,alu_out_reg);

  //SET NEXT PC
  Mux #(5) pc_next_mux(command[4:0],alu_result[4:0],Pc_src,pc_next);
  
  
  
endmodule
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  


