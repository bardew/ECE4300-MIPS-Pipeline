`timescale 1ns / 1ps

module if_stage (
    input  wire clk, reset, 
    input  wire ex_mem_pcrsrc, 
    input  wire [31:0] ex_mem_npc,
    output wire [31:0] IF_ID_instr,
    output wire [31:0] IF_ID_npc
);

    wire [31:0] pc;
    wire [31:0] pc_plus; 
    wire [31:0] npc; 
    wire [31:0] instr;

    // Program Counter
    pc_counter pc_counter1 (
        .clk(clk),
        .reset(reset),
        .npc(npc),
        .pc(pc)
    );

    // PC Adder: Compute PC + 4
    pc_adder incrementer1 (
        .PC(pc),
        .Next_PC(pc_plus)
    );

    // Next PC selection: choose branch target if branch is taken
    assign npc = ex_mem_pcrsrc ? ex_mem_npc : pc_plus;

    // Fetch instruction from memory
    instruction_memory instruction_memory1 (
        .clk(clk),
        .addr(pc),
        .data(instr)
    );

    // IF/ID Latch
    if_id_register if_id_latch1 (
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .npc(npc),
        .instrout(IF_ID_instr),
        .npcout(IF_ID_npc)
    );
endmodule

