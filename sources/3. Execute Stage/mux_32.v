`timescale 1ns / 1ps

module mux_32(
    input [31:0] a, b,
    input sel,
    output [31:0] y
);

    assign y = sel ? b : a;

endmodule
