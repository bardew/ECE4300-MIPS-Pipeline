`timescale 1ns / 1ps

module if_stageTB;
    reg clk_tb;
    reg reset_tb;
    reg ex_mem_pcrsrc_tb;
    reg [31:0] ex_mem_npc_tb;
    wire [31:0] IF_ID_instr_tb, IF_ID_npc_tb;

    if_stage uut (
        .clk(clk_tb),
        .reset(reset_tb),
        .ex_mem_pcrsrc(ex_mem_pcrsrc_tb),
        .ex_mem_npc(ex_mem_npc_tb),
        .IF_ID_instr(IF_ID_instr_tb),
        .IF_ID_npc(IF_ID_npc_tb)
    );

    initial clk_tb = 0;
    always #5 clk_tb = ~clk_tb;

    initial begin
        $display("Applying reset...");
        reset_tb = 1;
        ex_mem_pcrsrc_tb = 0;
        ex_mem_npc_tb = 32'hFFFFFFFF;
        #10; 
        $display("Releasing reset...");
        #20;
        $display("PC should be incrementing...");
        #40;
        $display("Forcing branch...");
        ex_mem_pcrsrc_tb = 1;
        ex_mem_npc_tb = 32'h00000000;
        #50;
        $display("Returning to normal operation...");
        ex_mem_pcrsrc_tb = 0;
        #100;
        $display("Test complete.");
        $finish;
    end

    initial begin
        $monitor("Time: %0d | PCSrc: %b | NPC: %h | Instruction: %h", 
        $time, ex_mem_pcrsrc_tb, IF_ID_npc_tb, IF_ID_instr_tb);
    end
endmodule

