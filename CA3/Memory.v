module Memory(input[4:0] address,input[7:0] writedata, input clk,writemem,readmem,output[7:0] readmem_out);

reg [7:0]Memory[0:31];
initial begin
		// Memory[0] = 8'b10011001;//push 25 be stack
		// Memory[1] = 8'b10011010;//push 26 be stack
		// Memory[2] = 8'b10011011;//push 27 be stack
		// Memory[3] = 8'b10011100;//push 28 be stack
		// Memory[4] = 8'b10011101;//push 29 be stack
		// Memory[5] = 8'b00000000;//add 
		// Memory[6] = 8'b00000000;//add
		// Memory[7] = 8'b00000000;//add
		// Memory[8] = 8'b00000000;//add
		// Memory[9] = 8'b10111110;//pop be 30

		// Memory[25] = 8'b00001001;
		// Memory[26] = 8'b00000111;
		// Memory[27] = 8'b00000101;
		// Memory[28] = 8'b00000011;
		// Memory[29] = 8'b00000001;

		// Memory[0] = 8'b10011101;	// push 8 in St
		// Memory[1] = 8'b01100000;	//not 00001000
		
		// Memory[2] = 8'b10111111;	// pop 10111011 from st and store it on Memory[31]
		// Memory[3] = 8'b10111110;	// pop 0 from st and store it on Memory[30]

		// Memory[27] = 8'b01100110;//102
		// Memory[28] = 8'b10101010;//170
		// Memory[29] = 8'b00001000;//8
		// Memory[30] = 8'b00010000;//16
    // Memory[0]=8'b10001110 // push M[14]
    // Memory[1]=8'b10001111 // push M[15]
    // Memory[2]=8'b10010000 // push M[16]
    // Memory[3]=8'b10010001 // push M[17]
    // Memory[4]=8'b10010010 // push M[18]
    // Memory[5]=8'b10110011 // pop M[19]
    // Memory[0]=8'b00001010 // add  -4 + -3 = -7
    // Memory[0]00100011 // sub  -7 - 2 = -9
    // Memory[0]01100000 // not -9 = 8
    // Memory[0]10010100 // push M[20]
    // Memory[0]11101101 // jz 13
    // 00000000
    // 00000000
    // 11011111 // jump 31
    // 00000001 // data memory  az inja shooroo mishe
    // 00000010
    // 11111101
    // 11111100
    // 00000101
    // 00000111
    // 00000000

	end
always @(posedge clk)begin
  if (writemem)
    Memory[address] <= writedata ;


  end
  assign readmem_out=readmem?Memory[address]:8'b0;
endmodule
