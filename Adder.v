module Adder(
    A,
    B,
    Y
);
    input[31:0] A, B;
    output[31:0] Y;

    assign Y = A + B;
endmodule
