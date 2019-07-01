module TB();
  reg clk=0;
  reg rst;
  processor ps(clk,rst);
  always begin #20 clk=~clk;end

  initial begin #100000; $stop; end
endmodule 
  
