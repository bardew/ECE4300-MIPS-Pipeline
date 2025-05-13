`timescale 1ns / 1ps

module pc_adder (
    input [31:0] PC,
    output [31:0] Next_PC
    );
    
    assign Next_PC = PC + 4;

endmodule
