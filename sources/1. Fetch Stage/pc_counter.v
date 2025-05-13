`timescale 1ns / 1ps

module pc_counter (
    input clk,
    input reset,
    input [31:0] npc,
    output reg [31:0] pc
);
    always @(posedge clk || reset) begin
        if (reset)
            pc <= 0;
        else
            pc <= npc;
    end
endmodule

