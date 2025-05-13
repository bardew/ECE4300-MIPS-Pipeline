`timescale 1ns / 1ps

module ex_mem_latch(
    input clk,
    input [1:0] ctlwb_in, 
    input [2:0] ctlm_in,
    input [31:0] adder_in, 
    input [31:0] alu_result_in, 
    input [31:0] rdata2_in,
    input [4:0] muxout_in,
    input       zero_in,

    output reg [1:0] ctlwb_out, 
    output reg [2:0] ctlm_out,
    output reg [31:0] adder_out, 
    output reg [31:0] alu_result_out, 
    output reg [31:0] rdata2_out,
    output reg [4:0] muxout_out,
    output reg       zero_out
);

    always @(posedge clk) begin
        ctlwb_out      <= ctlwb_in;
        ctlm_out       <= ctlm_in;
        adder_out      <= adder_in;
        alu_result_out <= alu_result_in;
        rdata2_out     <= rdata2_in;
        muxout_out     <= muxout_in;
        zero_out       <= zero_in;  // Forward the ALU zero flag to the next stage
    end
    
endmodule
