module Reg(
    CLK,
    AddrA, 
    AddrB, 
    AddrD,
    DataD,
    DataA,
    DataB,
    RegWEn
);
    input 		       CLK, RegWEn;
    input[4:0] 		   AddrA, AddrB, AddrD;
    input[31:0]		   DataD;
    output[31:0]	   DataA, DataB;
    reg[31:0] 		   mem [0:31];

    always@(posedge CLK) begin
        if (RegWEn == 1'b1) mem[AddrD] <= DataD; //write
    end
    assign DataA = mem[AddrA];
    assign DataB = mem[AddrB];

endmodule
