module IMEM (
    address,
    inst
);
    input[31:0] address;
    output[31:0] inst;
    reg[31:0] mem[0:1023];
    
    assign inst = mem[address >> 2];

endmodule
