`timescale 1ns / 1ps

module if_id_register (
    input clk,
    input reset,
    input [31:0] instr, npc, 
    output reg [31:0] instrout, npcout
);

    always @(posedge clk) begin
        if (reset) begin
            instrout <= 0;
            npcout   <= 0;
        end else
        begin
            instrout <= instr;
            npcout   <= npc;
        end
    end

endmodule
