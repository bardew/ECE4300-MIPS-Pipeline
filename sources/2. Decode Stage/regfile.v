`timescale 1ns / 1ps

module regfile(
    input wire          clk, 
    input wire          rst,
    input wire          regwrite,
    input wire [4:0]    rs, rt, rd,
    input wire [31:0]   writedata,
    output reg [31:0]  A_readdat1, B_readdat2
);

    reg [31:0] REG [0:31];
    integer i;

    always @(*)
    begin
        assign A_readdat1 = REG[rs];
        assign B_readdat2 = REG[rt];
    end
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 32; i = i + 1)
                REG[i] <= 0;
        end
        else if (regwrite && (rd != 0)) begin
            REG[rd] <= writedata;
        end
    end
    
endmodule
