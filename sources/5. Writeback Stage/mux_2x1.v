`timescale 1ns / 1ps

module mux_2x1 (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire sel,
    output wire [31:0] y
);

    assign y = (sel) ? b : a;

endmodule

