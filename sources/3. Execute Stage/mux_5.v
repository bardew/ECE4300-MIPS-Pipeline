`timescale 1ns / 1ps

module mux_5(
    input [4:0] a, b,
    input sel,
    output [4:0] y
);

    assign y = sel ? b : a;
    
endmodule


