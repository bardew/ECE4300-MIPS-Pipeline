`timescale 1ns / 1ps

module instruction_memory (
    input clk,
    input  [31:0] addr,
    output reg [31:0] data
);
    reg [31:0] memory [0:127];
    integer i;
    initial begin
        $readmemb("instr.mem", memory);
        for (i = 0; i < 24; i = i + 1) begin
            $display(memory[i]);
        end
    end
    
    always @(posedge clk) begin
        data <= memory[addr >> 2];
    end

endmodule

