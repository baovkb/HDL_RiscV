module Datapath(
    clk,
    rst,
    ImmSel,
    RegWEn,
    Bsel,
    ALUSel,
    MemRW,
    WBSel,
    AuipcSel,
    inst
);
    input clk, RegWEn, Bsel, WBSel, AuipcSel, rst;
    input[1:0] MemRW, ImmSel;
    input[2:0] ALUSel;
    output[31:0] inst;
    wire[31:0] tmp_PCRes, tmp_PCin, wb, tmp_DataA, tmp_DataB, tmp_imm, tmp_Bsel, tmp_ALURes, tmp_DataR, tmp_mux2lui;
    
    //connect to PC
    PC PC_call(
        .rst(rst),
        .clk(clk),
        .PCin(tmp_PCin),
        .PCRes(tmp_PCRes)
    );

    //connect to Adder
    Adder add4(
        .A(tmp_PCRes),
        .B(32'h4),
        .Y(tmp_PCin)
    );
    
    //connect to IMEM
    IMEM IMEM_call(
        .address(tmp_PCRes),
        .inst(inst)
    );

    //connect to Reg
    Reg Reg_call(
        .CLK(clk),
        .AddrA(inst[19:15]), 
        .AddrB(inst[24:20]), 
        .AddrD(inst[11:7]),
        .DataD(wb),
        .DataA(tmp_DataA),
        .DataB(tmp_DataB),
        .RegWEn(RegWEn)
    );

    //connect to IMMGen
    ImmGen ImmGen_call(
        .inst(inst[31:7]),
        .ImmSel(ImmSel),
        .imm(tmp_imm)
    );

    //connect to mux
    mux2_32bits mux2Bsel(
        .a(tmp_DataB),
        .b(tmp_imm),
        .sel(Bsel),
        .y(tmp_Bsel)
    );

    //connect to mux for lui
    mux2_32bits mux2Lui(
        .a(tmp_DataA),
        .b(32'b0),
        .sel(AuipcSel),
        .y(tmp_mux2lui)
    );

    //connect to ALU
    ALU ALU_call(
        .A(tmp_mux2lui),
        .B(tmp_Bsel),
        .ALUSel(ALUSel),
        .Res(tmp_ALURes),
        .Overflow()
    );

    // connect to DMEM
    DMEM DMEM_call(
        .clk(clk),
        .Addr(tmp_ALURes),
        .DataW(tmp_DataB),
        .DataR(tmp_DataR),
        .ReadEn(MemRW[1]),
        .WriteEn(MemRW[0])
    );

    //connect to mux wb
    mux2_32bits mux2Wbsel(
        .a(tmp_DataR),
        .b(tmp_ALURes),
        .sel(WBSel),
        .y(wb)
    );

endmodule
