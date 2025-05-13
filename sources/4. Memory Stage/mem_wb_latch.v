`timescale 1ns / 1ps

module mem_wb_latch(
    input clk, rst,
    input [31:0] ALUResult_in,
    input [31:0] ReadData_in,
    input [4:0] WriteReg_in,
    input [1:0] WBControl_in,
    output reg [31:0] ALUResult_out,
    output reg [31:0] ReadData_out,
    output reg [4:0] WriteReg_out,
    output reg [1:0] WBControl_out
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ALUResult_out <= 32'b0;
            ReadData_out  <= 32'b0;
            WriteReg_out  <= 5'b0;
            WBControl_out <= 2'b0;
        end else begin
            ALUResult_out <= ALUResult_in;
            ReadData_out  <= ReadData_in;
            WriteReg_out  <= WriteReg_in;
            WBControl_out <= WBControl_in;
        end
    end
endmodule
