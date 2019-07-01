module Pcreg(input clk,pc_write ,input [4:0]pcin,output [4:0]pcout);
  reg [4:0]pc = 0;
  always@(posedge clk)begin
    if(pc_write)
      pc<=pcin;
  end
    
    assign pcout=pc;
endmodule