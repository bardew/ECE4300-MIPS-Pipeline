`timescale 1ns / 1ps

module memoryTB();
    reg clk_tb, rst_tb;
    reg [31:0] ALUResult_tb, WriteData_tb;
    reg [4:0] WriteReg_tb;
    reg [1:0] WBControl_tb;
    reg MemWrite_tb, MemRead_tb, Branch_tb, Zero_tb;
    wire [31:0] ReadData_out_tb, ALUResult_out_tb;
    wire [4:0] WriteReg_out_tb;
    wire [1:0] WBControl_out_tb;
    wire PCSrc_tb;

    memory uut (
        .clk(clk_tb),
        .rst(rst_tb),
        .ALUResult(ALUResult_tb),
        .WriteData(WriteData_tb),
        .WriteReg(WriteReg_tb),
        .WBControl(WBControl_tb),
        .MemWrite(MemWrite_tb),
        .MemRead(MemRead_tb),
        .Branch(Branch_tb),
        .Zero(Zero_tb),
        .ReadData_out(ReadData_out_tb),
        .ALUResult_out(ALUResult_out_tb),
        .WriteReg_out(WriteReg_out_tb),
        .WBControl_out(WBControl_out_tb),
        .PCSrc(PCSrc_tb)
    );

    initial clk_tb = 0;
    always #5 clk_tb = ~clk_tb;

    initial begin
        rst_tb = 1;  
        ALUResult_tb = 32'h00000004;
        WriteData_tb = 32'h12345678;
        WriteReg_tb = 5'h02;
        WBControl_tb = 2'b01;
        MemWrite_tb = 0;
        MemRead_tb = 1;
        Branch_tb = 0;
        Zero_tb = 0;
        #10;

        rst_tb = 0; // Release Reset
        #10;

        // Step 2: Memory Write
        MemWrite_tb = 1;
        MemRead_tb = 0;
        #10; // Allow write to occur

        MemWrite_tb = 0;
        MemRead_tb = 1;
        #10; // Verify write by reading back

        // Step 3: Branch Operation
        Branch_tb = 1;
        Zero_tb = 1;
        #10; // Check PCSrc_tb behavior
    end
endmodule

