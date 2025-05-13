`timescale 1ns / 1ps

module execute (
    input  wire clk, rst,
    input  wire [1:0] ctlwb_in,
    input  wire [2:0] ctlm_in,
    input  wire [31:0] npc, rdata1, rdata2, s_extend,
    input  wire [4:0] instr_2016, instr_1511,
    input  wire [1:0] alu_op,
    input  wire [5:0] funct,
    input  wire alusrc, regdst,
    output wire [1:0] ctlwb_out,
    output wire [2:0] ctlm_out,
    output wire [31:0] branch_addr, alu_result_out, rdata2_out,
    output wire [4:0] muxout_out,
    output wire alu_zero_out
);

    wire [31:0] alu_in2;
    wire [2:0] alu_control;
    wire [31:0] alu_result;
    wire alu_zero;
    wire [4:0] regdst_muxout;
    
    // Branch target computation (adder).  
    ex_adder adder_inst(
        .a(npc),
        .b(s_extend),
        .result(branch_addr)
    );

    // ALU Source MUX: choose between register data or immediate value
    mux_32 alusrc_mux(
    .a(rdata2),
    .b(s_extend),
    .sel(alusrc),
    .y(alu_in2)
    );

    // ALU Control: derive control signals from alu_op and funct field
    alu_control alu_ctrl_inst(
        .alu_op(alu_op),
        .funct(funct),
        .select(alu_control)
    );

    // ALU: perform arithmetic/logical operations
    alu alu_inst(
        .a(rdata1),
        .b(alu_in2),
        .control(alu_control),
        .result(alu_result),
        .zero(alu_zero)
    );

    // Register Destination MUX: choose between rt and rd fields
    mux_5 regdst_mux(
    .a(instr_2016),
    .b(instr_1511),
    .sel(regdst),
    .y(regdst_muxout)
    );


    // EX/MEM Latch: pass signals to the memory stage
    ex_mem_latch ex_mem_reg(
        .clk(clk),
        .ctlwb_in(ctlwb_in),
        .ctlm_in(ctlm_in),
        .adder_in(branch_addr),
        .alu_result_in(alu_result),
        .rdata2_in(rdata2),
        .muxout_in(regdst_muxout),
        .zero_in(alu_zero),
        .ctlwb_out(ctlwb_out),
        .ctlm_out(ctlm_out),
        .alu_result_out(alu_result_out),
        .rdata2_out(rdata2_out),
        .muxout_out(muxout_out),
        .zero_out(alu_zero_out)
    );
    
endmodule
