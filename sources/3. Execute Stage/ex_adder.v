`timescale 1ns / 1ps

module ex_adder(
    input [31:0] a, b,
    output [31:0] result
);
    
    assign result = a + b;
    
endmodule