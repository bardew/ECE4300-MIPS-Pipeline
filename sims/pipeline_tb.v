`timescale 1ns / 1ps

module pipeline_tb;
    reg clk, reset;

    pipeline uut (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        #10;
        reset = 0;
        #240;
        $finish;
    end
endmodule

