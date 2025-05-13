`timescale 1ns / 1ps

module pipeline (
    input clk,
    input reset
);

    // IF Stage Signals
    wire [31:0] IF_ID_instr;
    wire [31:0] IF_ID_npc;
    wire PCSrc;

    // ID Stage Signals
    wire [1:0]   id_ex_wb;
    wire [2:0]   id_ex_mem;
    wire [3:0]   id_ex_execute;
    wire [31:0]  id_ex_npc;
    wire [31:0]  id_ex_readdat1;
    wire [31:0]  id_ex_readdat2;
    wire [31:0]  id_ex_sign_ext;
    wire [4:0]   id_ex_instr_bits_20_16;
    wire [4:0]   id_ex_instr_bits_15_11;
    wire [5:0]   id_ex_funct;

    // EX Stage Signals
    wire [1:0]   ctlwb_out;
    wire [2:0]   ctlm_out;
    wire [31:0]  branch_addr;
    wire [31:0]  alu_result_out;
    wire [31:0]  rdata2_out;
    wire [4:0]   muxout_out;
    wire         alu_zero;

    // MEM Stage Signals
    wire [31:0]  ALUResult_out;
    wire [31:0]  ReadData_out;
    wire [4:0]   WriteReg_out;
    wire [1:0]   WBControl_out;

    // WB Stage Signals
    wire [31:0]  writeback_data;
    wire [4:0]   writeback_reg;

    //----------------------------------------
    // IF Stage
    //----------------------------------------
    if_stage IF_stage (
        .clk(clk),
        .reset(reset),
        .ex_mem_pcrsrc(PCSrc),
        .ex_mem_npc(branch_addr),
        .IF_ID_instr(IF_ID_instr),
        .IF_ID_npc(IF_ID_npc)
    );

    //----------------------------------------
    // ID Stage
    //----------------------------------------
    decode ID_stage (
        .clk(clk),
        .rst(reset),
        .wb_reg_write(WBControl_out[1]),  
        .mem_wb_write_data(writeback_data),  
        .if_id_instr(IF_ID_instr),
        .if_id_npc(IF_ID_npc),
        .if_id_rd(WriteReg_out),
        .id_ex_wb(id_ex_wb),
        .id_ex_mem(id_ex_mem),
        .id_ex_execute(id_ex_execute),
        .id_ex_npc(id_ex_npc),
        .id_ex_readdat1(id_ex_readdat1),
        .id_ex_readdat2(id_ex_readdat2),
        .id_ex_sign_ext(id_ex_sign_ext),
        .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16),
        .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11),
        .id_ex_funct(id_ex_funct)
    );



    //----------------------------------------
    // EX Stage
    //----------------------------------------
    execute EX_stage (
        .clk(clk),
        .rst(reset),
        .ctlwb_in(id_ex_wb),
        .ctlm_in(id_ex_mem),
        .npc(id_ex_npc),
        .rdata1(id_ex_readdat1),
        .rdata2(id_ex_readdat2),
        .s_extend(id_ex_sign_ext),
        .instr_2016(id_ex_instr_bits_20_16),
        .instr_1511(id_ex_instr_bits_15_11),
        .alu_op(id_ex_execute[1:0]),
        .funct(id_ex_funct),
        .alusrc(id_ex_execute[2]),
        .regdst(id_ex_execute[3]),
        .ctlwb_out(ctlwb_out),
        .ctlm_out(ctlm_out),
        .branch_addr(branch_addr),
        .alu_result_out(alu_result_out),
        .rdata2_out(rdata2_out),
        .muxout_out(muxout_out),
        .alu_zero_out(alu_zero)
    );

    //----------------------------------------
    // MEM Stage
    //----------------------------------------
    memory MEM_stage (
        .clk(clk),
        .rst(reset),
        .ALUResult(alu_result_out),
        .WriteData(rdata2_out),
        .WriteReg(muxout_out),
        .WBControl(ctlwb_out),
        .MemWrite(ctlm_out[0]),
        .MemRead(ctlm_out[1]),
        .Branch(ctlm_out[2]),
        .Zero(alu_zero),
        .ReadData_out(ReadData_out),
        .ALUResult_out(ALUResult_out),
        .WriteReg_out(WriteReg_out),
        .WBControl_out(WBControl_out),
        .PCSrc(PCSrc)
    );

    //----------------------------------------
    // WB Stage
    //----------------------------------------
    wb_stage WB_stage (
        .WBControl(WBControl_out[0]),
        .ALUResult(ALUResult_out),
        .ReadData(ReadData_out),
        .WriteData(writeback_data)
    );

endmodule
