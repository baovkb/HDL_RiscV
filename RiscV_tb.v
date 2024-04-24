`timescale 1ns/1ps

module RiscV_tb();
    reg clk, rst;
    reg[2:0] i;

    RiscV DUT(
        .clk(clk),
        .rst(rst)
    );

    initial begin
        #200 $stop;
    end

    initial begin
        $readmemh("instruction.txt", DUT.dtpath.IMEM_call.mem);

        rst = 1;
        #10;
        rst = 0;
        clk = 0;

        forever #10 begin
            clk = ~clk;
            #1;  
            if (clk == 1) begin
                for (i = 0; i < 6; i = i + 1) begin
                    $display("x%d = %d", i, DUT.dtpath.Reg_call.mem[i]);
                end
                $display("DMEM[23] = %d", DUT.dtpath.DMEM_call.mem[23]);
                // $stop; 
            end
        end
    end
    
endmodule

/*
@0 39037
@4 30B7
@8 15137
@C 101B7
@10 A08213
@14 202B3
@18 312123
@1C 212083

lui x0, 57
lui x1, 3
lui x2, 21
lui x3, 16
addi x4, x1, 10
add x5, x4, x0
sw x3, 2(x2)
lw x1, 2(x2)

x0 = 57
x1 = 3
x2 = 21
x3 = 16
x4 = 13
x5 = 70
DMEM[23] = 16
x1 = 16
*/