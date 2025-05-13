`timescale 1ns / 1ps

module executeTB;
    reg clk_tb, rst_tb, alusrc_tb, regdst_tb;
    reg [1:0] ctlwb_in_tb;
    reg [2:0] ctlm_in_tb;
    reg [31:0] npc_tb, rdata1_tb, rdata2_tb, s_extend_tb;
    reg [4:0] instr_2016_tb, instr_1511_tb;
    reg [1:0] alu_op_tb;
    reg [5:0] funct_tb;
    wire [1:0] ctlwb_out_tb;
    wire [2:0] ctlm_out_tb;
    wire [31:0] branch_addr_tb, alu_result_out_tb, rdata2_out_tb;
    wire [4:0] muxout_tb;
    wire alu_zero_tb;

    execute uut (
        .clk(clk_tb), .rst(rst_tb),
        .ctlwb_in(ctlwb_in_tb), .ctlm_in(ctlm_in_tb),
        .npc(npc_tb),
        .rdata1(rdata1_tb),
        .rdata2(rdata2_tb),
        .s_extend(s_extend_tb),
        .instr_2016(instr_2016_tb), .instr_1511(instr_1511_tb),
        .alu_op(alu_op_tb),
        .funct(funct_tb),
        .alusrc(alusrc_tb),
        .regdst(regdst_tb),
        .ctlwb_out(ctlwb_out_tb),
        .ctlm_out(ctlm_out_tb),
        .branch_addr(branch_addr_tb),
        .alu_result_out(alu_result_out_tb),
        .rdata2_out(rdata2_out_tb),
        .muxout_out(muxout_tb),
        .alu_zero_out(alu_zero_tb)
    );
    
    initial clk_tb = 0;
    always #5 clk_tb = ~clk_tb;
    initial begin
        rst_tb = 1; 
        ctlwb_in_tb = 2'b10; ctlm_in_tb = 3'b001;
        npc_tb = 32'd100;
        rdata1_tb = 32'd10; rdata2_tb = 32'd20;
        s_extend_tb = 32'd4;
        instr_2016_tb = 5'd5;
        instr_1511_tb = 5'd10;
        alu_op_tb = 2'b10;
        funct_tb = 6'b100000;
        alusrc_tb = 1;
        regdst_tb = 1;
        #10;
        rst_tb = 0; // Release Reset
        #10; // Test different ALU operations
        alusrc_tb = 0; regdst_tb = 0;
        s_extend_tb = 32'd8;
        alu_op_tb = 2'b01;
        funct_tb = 6'b100010;
        #10; // Test branch calculation
        s_extend_tb = 32'd16;
        npc_tb = 32'd200;
        #10;
    end
endmodule


