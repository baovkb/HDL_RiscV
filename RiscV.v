module RiscV(
    rst,
    clk
);
    input rst, clk;
    wire RegWEn, Bsel, WBSel, AuipcSel;
    wire[1:0] ImmSel, MemRW;
    wire[2:0] ALUSel;
    wire[31:0] inst;

    Datapath dtpath(
        .clk(clk),
        .rst(rst),
        .ImmSel(ImmSel),
        .RegWEn(RegWEn),
        .Bsel(Bsel),
        .ALUSel(ALUSel),
        .MemRW(MemRW),
        .WBSel(WBSel),
        .AuipcSel(AuipcSel),
        .inst(inst)
    );

    Controller contr(
        .ImmSel(ImmSel),
        .RegWEn(RegWEn),
        .Bsel(Bsel),
        .ALUSel(ALUSel),
        .MemRW(MemRW),
        .WBSel(WBSel),
        .AuipcSel(AuipcSel),
        .inst(inst)
    );
endmodule
