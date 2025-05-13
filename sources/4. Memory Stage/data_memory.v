`timescale 1ns / 1ps

module data_memory(
    input clk,
    input [31:0] Address,
    input [31:0] WriteData,
    input MemWrite,
    input MemRead,
    output reg [31:0] ReadData
);

    reg [31:0] memory [0:255];

    always @(posedge clk) begin
        if (MemWrite)
            memory[Address >> 2] <= WriteData;
        else if (MemRead)
            ReadData <= memory[Address >> 2];
    end

    integer i;
    initial begin
        $readmemb("data.mem", memory);
        for (i = 0; i < 6; i = i + 1) begin
            $display(memory[i]);
        end
    end

endmodule
