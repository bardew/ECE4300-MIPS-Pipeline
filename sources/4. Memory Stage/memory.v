`timescale 1ns / 1ps

module memory(
    input clk, rst,
    input [31:0] ALUResult,
    input [31:0] WriteData,
    input [4:0] WriteReg,
    input [1:0] WBControl,
    input MemWrite,
    input MemRead,
    input Branch,
    input Zero,
    output [31:0] ReadData_out,
    output [31:0] ALUResult_out,
    output [4:0] WriteReg_out,
    output [1:0] WBControl_out,
    output PCSrc
);

    wire [31:0] DataMemReadData;

    // Branch decision: PCSrc = Branch AND Zero flag
    and_gate andGate(
        .a(Branch),
        .b(Zero),
        .y(PCSrc)
    );

    // Data Memory Access: read or write data based on control signals
    data_memory dataMem(
        .clk(clk),
        .Address(ALUResult),
        .WriteData(WriteData),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ReadData(DataMemReadData)
    );
    
    // MEM/WB Latch: capture and forward results for the write-back stage
    mem_wb_latch memwb(
        .clk(clk),
        .rst(rst),
        .ALUResult_in(ALUResult),
        .ReadData_in(DataMemReadData),
        .WriteReg_in(WriteReg),
        .WBControl_in(WBControl),
        .ALUResult_out(ALUResult_out),
        .ReadData_out(ReadData_out),
        .WriteReg_out(WriteReg_out),
        .WBControl_out(WBControl_out)
    );

endmodule

