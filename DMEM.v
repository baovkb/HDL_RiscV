module DMEM (
    clk,
    Addr,
    DataW,
    DataR,
    ReadEn,
    WriteEn
);
    input clk, ReadEn, WriteEn;
    input[9:0] Addr;
    input[31:0] DataW;
    output[31:0] DataR;

    reg [31:0]mem[0:1023];

    assign DataR = ReadEn ? mem[Addr] : 32'bz;
    always @(posedge clk) begin
        if (WriteEn)    mem[Addr] <= DataW;  
    end
    
endmodule