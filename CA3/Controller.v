module Controller (input[2:0] opcode,output reg pc_write,pc_write_cond,IorD,IR_write,Pc_src
,output reg readmem,writemem,MtoS,ld_A,ld_B,pop,push,tos,Sel_A,Sel_B
,output reg[1:0]controller_command
,input clk,rst);

    

    reg [3:0]ns=0,ps=0;
    always@(ps,opcode)begin
        {pc_write,pc_write_cond,IorD,IR_write,Pc_src,readmem,writemem,MtoS,ld_A,ld_B,pop,push,tos,Sel_A,Sel_B}=15'b0;
        controller_command=2'b0;
        case(ps) 

            4'd0:begin //IF state
                IorD=1'b0;
                readmem=1'b1;
                Sel_A=1'b1;
                Sel_B=1'b1;
                controller_command = 2'b00;
                Pc_src=1'b0;
                pc_write=1'b1;
                IR_write=1'b1;
                
                
            end

            4'b0001:begin
                
                tos=1'b1;
            end
            4'b0010:begin
                IorD=1;
                readmem=1;
            end
            4'b0011:begin
                MtoS=1;
                push=1;
            end
            4'b0100:begin
                pop=1;
            end
            4'b0101:begin
                ld_A=1;
            end
            4'b0110:begin
                pop=1;
            end
            4'b0111:begin
                ld_B=1;
            end
            4'b1000:begin
                Sel_A=0;
                Sel_B=0;
                controller_command=opcode[1:0];
            end
            4'b1001:begin
                Sel_A=0;
                controller_command=2'b11;
            end
            4'b1010:begin
                MtoS=0;
                push=1;
            end
            4'b1011:begin
                IorD=1;
                writemem=1;
            end
            4'b1100:begin
                pc_write_cond=1;
                Pc_src=1;
            end
            4'b1101:begin
                Pc_src=1;
                pc_write=1;
            end
            default:begin
                {pc_write,pc_write_cond,IorD,IR_write,Pc_src,readmem,writemem,MtoS,ld_A,ld_B,pop,push,tos,Sel_A,Sel_B}=15'b0;
                controller_command=2'b0;
            end

                endcase
        
    end


    always @(ps, opcode)begin
        case(ps) 

            4'd0:begin //IF state
                ns=4'b0001;
            end

            4'b0001:begin
                case(opcode)
                    3'b0:begin//add
                        ns=4'b0100;
                    end
                    3'b001:begin//sub
                        ns=4'b0100;
                    end
                    3'b010:begin//and
                        ns=4'b0100;
                    end
                    3'b011:begin//not
                        ns=4'b0100;
                    end
                    3'b100:begin//push
                        ns=4'b0010;
                    end
                    3'b101:begin
                        ns=4'b0100;
                    end
                    3'b110:begin
                        ns=4'b1101;
                    end
                    3'b111:begin
                        ns=4'b1100;
                    end
                endcase
                
            end
            4'b0010:begin
                ns=4'b0011;
            end
            4'b0011:begin
                ns=4'b0;
            end
            4'b0100:begin
                ns=4'b0101;
            end
            4'b0101:begin
                case(opcode)
                    3'b0:begin
                        ns=4'b0110;
                    end
                    3'b001:begin
                        ns=4'b0110;
                    end
                    3'b010:begin
                        ns=4'b0110;
                    end
                    3'b011:begin
                        ns=4'b1001;
                    end
                    3'b101:begin
                        ns=4'b1011;
                    end
                
                endcase
            end
            4'b0110:begin
                ns=4'b0111;
            end
            4'b0111:begin
                ns=4'b1000;
            end
            4'b1000:begin
                ns=4'b1010;
            end
            4'b1001:begin
                ns=4'b1010;
            end
            4'b1010:begin
                ns=4'b0;
            end
            4'b1011:begin
                ns=4'b0;
            end
            4'b1100:begin
                ns=4'b0;
            end
            4'b1101:begin
                ns=4'b0;
            end
            default:begin
                ns=4'b0;
            end

                endcase
        
    end


    always@(posedge clk,posedge rst)begin
            ps <= ns;
    end


endmodule