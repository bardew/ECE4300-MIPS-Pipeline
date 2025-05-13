`timescale 1ns / 1ps

module control(
    input wire clk,
    input wire rst,
    input wire [5:0] opcode,
    input wire [5:0] funct,
    output reg [1:0] wb,
    output reg [2:0] mem,
    output reg [3:0] ex
);

    // Opcodes
    parameter [5:0] RTYPE = 6'b000000;
    parameter [5:0] LW    = 6'b100011;
    parameter [5:0] SW    = 6'b101011;
    parameter [5:0] BEQ   = 6'b000100;
    parameter [5:0] NOP   = 6'b100000;
    // Funct Code
    parameter [5:0] ADD   = 6'b100000;
    parameter [5:0] SUB   = 6'b100010;
    parameter [5:0] AND   = 6'b100100;
    parameter [5:0] OR    = 6'b100101;

    always @(*) begin
        wb  <= 2'b00;
        mem <= 3'b000;
        ex  <= 4'b0000;
        case (opcode)
            RTYPE: begin 
                wb  <= 2'b10;
                mem <= 3'b000;
                case (funct)
                    ADD: ex <= 4'b0010;   // add
                    SUB: ex <= 4'b0110;   // sub
                    AND: ex <= 4'b0000;   // and
                    OR:  ex <= 4'b0001;   // or
                    default: ex <= 4'b0000;
                endcase
            end
            LW: begin 
                wb  <= 2'b11;
                mem <= 3'b010;
                ex  <= 4'b0001;
            end
            SW: begin
                wb  <= 2'b00;
                mem <= 3'b001; 
                ex  <= 4'b0001;
            end
            BEQ: begin
                wb  <= 2'b00;
                mem <= 3'b100;
                ex  <= 4'b0010;
            end
            NOP: begin
                wb  <= 2'b00;
                mem <= 3'b000;
                ex  <= 4'b0000;
            end
            default: begin
                wb  <= 2'b00;
                mem <= 3'b000;
                ex  <= 4'b0000;
            end
        endcase
    end
endmodule
