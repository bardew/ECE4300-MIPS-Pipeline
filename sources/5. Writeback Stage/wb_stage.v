`timescale 1ns / 1ps

module wb_stage (
    input wire WBControl,
    input wire [31:0]  ALUResult, ReadData,
    output wire [31:0] WriteData

);

    wire [31:0] mux_out;

    mux_2x1 mux_inst (
        .a(ALUResult),
        .b(ReadData),
        .sel(WBControl),
        .y(WriteData)
    );

endmodule
