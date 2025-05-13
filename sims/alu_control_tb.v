`timescale 1ns / 1ps

module alu_control_tb;

    reg [1:0] alu_op_tb;
    reg [5:0] funct_tb;
    wire [2:0] select_tb;

    alu_control uut (
        .alu_op(alu_op_tb),
        .funct(funct_tb),
        .select(select_tb)
    );

    initial begin
        $monitor("Time: %0d | ALUOp = %b | Funct = %b | Select = %b",
        $time, alu_op_tb, funct_tb, select_tb);
        #1;
        alu_op_tb = 2'b00; funct_tb = 6'b100000; // Expect ADD
        #1;
        alu_op_tb = 2'b01; funct_tb = 6'b100000; // Expect SUBTRACT
        #1;
        // Test R-type instruction cases
        alu_op_tb = 2'b10; funct_tb = 6'b100000; // ADD
        #1;
        funct_tb = 6'b100010; // SUBTRACT
        #1;
        funct_tb = 6'b100100; // AND
        #1;
        funct_tb = 6'b100101; // OR
        #1;
        funct_tb = 6'b101010; // Set Less Than
        #1;
        $display("ALU Control Test Complete.");
        $finish;
    end
endmodule

