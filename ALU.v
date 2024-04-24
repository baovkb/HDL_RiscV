module ALU (
    A,
    B,
    ALUSel,
    Res,
    Overflow
);
    input[31:0] A, B;
    input[2:0] ALUSel;
    output reg[31:0] Res;
    output reg Overflow;
    reg extra;

    always @(*) begin
        case (ALUSel)
            3'b000: Res = !A;
            3'b001: Res = A & B;
            3'b010: Res = A ^ B;
            3'b011: Res = A | B;
            3'b100: Res = A - 1;
            3'b101: begin
                {extra, Res} = {A[31], A} + {B[31],B};
                Overflow = extra ^ Res[31];
            end
            3'b110: begin
                {extra, Res} = {A[31], A} - {B[31], B};
                Overflow = extra ^ Res[31];
            end
            3'b111: Res = A + 1;
            default: Res = 32'b0;
        endcase
    end
    
endmodule
