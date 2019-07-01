module ALU (input [1:0]controller_command ,
 input [7:0] A , B,output reg[7:0] res);
   always@(*)begin
    case(controller_command)
      //3'b000:res=B;
      2'b00:res= A+B;
      2'b01:res= A-B;
      2'b10:res= A&B;
      //3'b101:res= A|B;  
      2'b11:res= ~A;
      //3'b111:res= A;
    endcase
  end
  
endmodule
