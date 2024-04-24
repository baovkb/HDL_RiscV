module PC(
    PCin,
    PCRes,
    clk,
    rst
);
    input clk, rst;
    input [31:0] PCin;
    output reg[31:0] PCRes;

    always@(posedge clk or posedge rst) begin
        if (rst) 
            PCRes <= 32'h0;
        else 
            PCRes <= PCin;
    end

endmodule