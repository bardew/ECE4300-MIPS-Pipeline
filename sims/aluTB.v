`timescale 1ns / 1ps

module aluTB;

    reg [31:0] a_tb, b_tb;
    reg [2:0] control_tb;
    wire [31:0] result_tb;
    wire zero_tb;

    alu alu_inst (
        .a(a_tb),
        .b(b_tb),
        .control(control_tb),
        .result(result_tb),
        .zero(zero_tb)
    );

    initial begin
        $monitor("Time: %0d | Control = %b | Result = %h",
        $time, control_tb, result_tb);
        a_tb = 32'h0000000A; 
        b_tb = 32'h00000007;
        control_tb = 3'b010;  // add
        #5;
        control_tb = 3'b000; // and
        #5;
        control_tb = 3'b001; // or
        #5;
        control_tb = 3'b110; // sub
        #5;
        control_tb = 3'b111; // set less than
        #5;
        control_tb = 3'b011;  // invalid opcode
        #5;
        control_tb = 3'b100;  // invalid opcode
        #5;
        $display("ALU Test Complete.");
        $finish;
    end

endmodule

