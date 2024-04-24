module Controller(
    inst,
    ImmSel,
    RegWEn,
    Bsel,
    ALUSel,
    MemRW,
    WBSel,
    AuipcSel
);
    input[31:0] inst;
    output reg [2:0] ALUSel;
    output reg[1:0] ImmSel;
    output reg[1:0] MemRW;
    output reg RegWEn, Bsel, WBSel, AuipcSel;

    parameter R_TYPE = 7'b0110011;
    parameter I_TYPE_L = 7'b0000011;
    parameter I_TYPE_I = 7'b0010011;
    parameter S_TYPE = 7'b0100011;
    parameter U_TYPE = 7'b0110111;

    always@(*) begin
        case (inst[6:0])
            R_TYPE: begin
                //funct7
                if (inst[31:25] == 7'b0) begin
                    //funct3
                    if (inst[14:12] == 3'b0) begin //add
                        ImmSel = 2'b0;
                        RegWEn = 1;
                        Bsel = 0;
                        ALUSel = 3'b101; 
                        MemRW = 2'b10;
                        WBSel = 1;
                        AuipcSel = 0;
                    end
                end
            end
            I_TYPE_L: begin
                ImmSel = 2'b0;
                RegWEn = 1;
                Bsel = 1;
                ALUSel = 3'b101; 
                MemRW = 2'b10;
                AuipcSel = 0;
                //funct3
                if (inst[14:12] == 3'b010) begin //lw   
                    WBSel = 0;
                end
            end
            I_TYPE_I: begin
                ImmSel = 2'b0;
                RegWEn = 1;
                Bsel = 1;
                ALUSel = 3'b101; 
                MemRW = 2'b10;
                AuipcSel = 0;             
                //funct3
                if (inst[14:12] == 3'b000) begin //addi
                    WBSel = 1;
                end
            end

            S_TYPE: begin
                if (inst[14:12 == 3'b010]) begin //sw
                    ImmSel = 2'b01;
                    RegWEn = 0;
                    Bsel = 1;
                    ALUSel = 3'b101; //add
                    MemRW = 2'b01;
                    WBSel = 0;
                    AuipcSel = 0;
                end
            end
            U_TYPE: begin
                ImmSel = 2'b10;
                RegWEn = 1;
                Bsel = 1;
                ALUSel = 3'b101;
                MemRW = 2'b10;
                WBSel = 1;
                AuipcSel = 1;
            end

            default: begin
                ImmSel = 2'b00;
                RegWEn = 0;
                Bsel = 0;
                ALUSel = 3'b101; //add
                MemRW = 2'b00;
                WBSel = 0;
                AuipcSel = 0;
            end
        endcase
    end

endmodule
