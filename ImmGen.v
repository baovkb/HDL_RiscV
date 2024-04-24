module ImmGen(
    inst,
    ImmSel,
    imm
);
    input[24:0] inst;
    input[1:0] ImmSel;
    output reg[31:0] imm;
    reg[19:0] tmp;

    parameter I_TYPE = 2'b00;
    parameter S_TYPE = 2'b01;
    parameter U_TYPE = 2'b10;

    always@(*) begin
        case(ImmSel)
            I_TYPE: begin
                tmp = inst[24:13];
                imm = (tmp[11] == 0) ? {20'h0, inst[24:13]} : {20'hfffff, inst[24:13]};
            end
            S_TYPE: begin
                tmp = {inst[24:18], inst[4:0]};
                imm = (tmp[11] == 0) ? {20'h0, {inst[24:18], inst[4:0]}} : {20'hfffff, {inst[24:18], inst[4:0]}};
            end
            U_TYPE: begin
                tmp = inst[24:5];
                imm = (tmp[19] == 0) ? {12'h0, inst[24:5]} : {12'hfff, inst[24:5]};
            end
            default: 
                imm = 32'b0;
        endcase
    end

endmodule
