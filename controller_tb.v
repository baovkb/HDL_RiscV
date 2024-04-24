`timescale 1ns / 1ps

module controller_tb();
    reg[31:0] inst_reg;
    wire [2:0] ALUSel_reg;
    wire[1:0] ImmSel_reg, MemRW_reg;
    wire RegWEn_reg, Bsel_reg, WBSel_reg, AuipcSel_reg;

    Controller DUT(
        .inst(inst_reg),
        .ImmSel(ImmSel_reg),
        .RegWEn(RegWEn_reg),
        .Bsel(Bsel_reg),
        .ALUSel(ALUSel_reg),
        .MemRW(MemRW_reg),
        .WBSel(WBSel_reg),
        .AuipcSel(AuipcSel_reg)
    );

    initial begin
        $display("add");
        inst_reg = 32'b00000000000100000000000100110011; //add x3,x0, x1
        #0;
        if (RegWEn_reg == 1) $display("RegWEn match");
        else $display("RegWEn mismatch");
        if (Bsel_reg == 0) $display("BSel_reg match");
        else $display("BSel_reg mismatch");
        if (AuipcSel_reg == 0) $display("Auipc match");
        else $display("Auipc mismatch");
        if (ALUSel_reg == 3'b101) $display("ALUSel_reg match");
        else $display("ALUSel_reg mismatch");
        if(MemRW_reg == 2'b10) $display("WBSel_reg match");
        else $display("WESel mismatch");
        if(WBSel_reg == 1) $display("WBSel_reg match");
        else $display("WESel mismatch");
        
        $display("lw");
        inst_reg = 32'b00000000100000010010011100000011; //lw x14, 8(x2)
        #0;
        if(ImmSel_reg == 2'b0) $display("Immsel_reg match");
        else $display("ImmSel_reg mismatch");
        if(RegWEn_reg == 1) $display("RegWEn match");
        else $display("RegWEn mismatch");
        if(Bsel_reg == 1) $display("BSel_reg match");
        else $display("BSel_reg mismatch");
        if (AuipcSel_reg == 0) $display("Auipc match");
        else $display("Auipc mismatch");
        if(ALUSel_reg == 3'b101) $display("ALUSel_reg match");
        else $display("ALUSel_reg mismatch");
        if(MemRW_reg == 2'b10) $display("MemRW_reg match");
        else $display("MemRW_reg mismatch");
        if(WBSel_reg == 0) $display("WBSel_reg match");
        else $display("WESel mismatch");

        $display("sw");
        inst_reg = 32'b00000000111000010010010000100011; //sw x14, 8(x2)
        #0;
        if(ImmSel_reg == 2'b01) $display("Immsel_reg match");
        else $display("ImmSel_reg mismatch");
        if(RegWEn_reg == 0) $display("RegWEn match");
        else $display("RegWEn mismatch");
        if(Bsel_reg == 1) $display("BSel_reg match");
        else $display("BSel_reg mismatch");
        if (AuipcSel_reg == 0) $display("Auipc match");
        else $display("Auipc mismatch");
        if(ALUSel_reg == 3'b101) $display("ALUSel_reg match");
        else $display("ALUSel_reg mismatch");
        if(MemRW_reg == 1) $display("MemRW_reg match");
        else $display("MemRW_reg mismatch");

        $display("lui");
        inst_reg = 32'b00000000000000111001000000110111; 
        #0;
        if(ImmSel_reg == 2'b10) $display("Immsel_reg match");
        else $display("ImmSel_reg mismatch");
        if(RegWEn_reg == 1) $display("RegWEn match");
        else $display("RegWEn mismatch");
        if(Bsel_reg == 1) $display("BSel_reg match");
        else $display("BSel_reg mismatch");
        if (AuipcSel_reg == 1) $display("Auipc match");
        else $display("Auipc mismatch");
        if(ALUSel_reg == 3'b101) $display("ALUSel_reg match");
        else $display("ALUSel_reg mismatch");
        if(MemRW_reg == 2'b10) $display("MemRW_reg match");
        else $display("MemRW_reg mismatch");
        if(WBSel_reg == 1) $display("WBSel_reg match");
        else $display("WESel mismatch");
        
        $display("addi");
        inst_reg = 32'b00000000101000001000001000010011; // addi 
        #0;
        if(ImmSel_reg == 2'b00) $display("Immsel_reg match");
        else $display("ImmSel_reg mismatch");
        if(RegWEn_reg == 1) $display("RegWEn match");
        else $display("RegWEn mismatch");
        if(Bsel_reg == 1) $display("BSel_reg match");
        else $display("BSel_reg mismatch");
        if (AuipcSel_reg == 0) $display("Auipc match");
        else $display("Auipc mismatch");
        if(ALUSel_reg == 3'b101) $display("ALUSel_reg match");
        else $display("ALUSel_reg mismatch");
        if(MemRW_reg == 2'b10) $display("MemRW_reg match");
        else $display("MemRW_reg mismatch");
        if(WBSel_reg == 1) $display("WBSel_reg match");
        else $display("WESel mismatch");
    end

endmodule
