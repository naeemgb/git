module Stack(input clk,pop,push,tos,[7:0]d_in,output [7:0]d_out);
    reg[7:0]stack[31:0];
    reg[7:0] R29;
    reg [7:0]D_out;
    initial begin
        R29=8'b11111111;
    end
    always@(posedge clk)begin
        if(push) begin
            R29 = R29 + 1;
            stack[R29] <= d_in;   
        end
        if(pop)begin
            D_out <= stack[R29];
            R29 = R29 - 1; 
        end
        if(tos)begin
            D_out <= stack[R29];
        end
    end
    assign d_out = D_out;
endmodule