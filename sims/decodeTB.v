`timescale 1ns / 1ps

module decodeTB;
    
    reg         clk_tb, rst_tb, wb_reg_write_tb;
    reg [4:0]   wb_write_reg_location_tb;  
    reg [31:0]  mem_wb_write_data_tb, if_id_instr_tb, if_id_npc_tb;
    wire [1:0]  id_ex_wb_tb;
    wire [2:0]  id_ex_mem_tb;
    wire [3:0]  id_ex_execute_tb;
    wire [31:0] id_ex_npc_tb, id_ex_readdat1_tb, id_ex_readdat2_tb, id_ex_sign_ext_tb;
    wire [4:0]  id_ex_instr_bits_20_16_tb, id_ex_instr_bits_15_11_tb, WriteReg_out_tb;

    decode uut (
        .clk(clk_tb),
        .rst(rst_tb),
        .wb_reg_write(wb_reg_write_tb),
        .mem_wb_write_data(mem_wb_write_data_tb),
        .if_id_instr(if_id_instr_tb),
        .if_id_npc(if_id_npc_tb),
        .if_id_rd(WriteReg_out_tb),
        .id_ex_wb(id_ex_wb_tb),
        .id_ex_mem(id_ex_mem_tb),
        .id_ex_execute(id_ex_execute_tb),
        .id_ex_npc(id_ex_npc_tb),
        .id_ex_readdat1(id_ex_readdat1_tb),
        .id_ex_readdat2(id_ex_readdat2_tb),
        .id_ex_sign_ext(id_ex_sign_ext_tb),
        .id_ex_instr_bits_20_16(id_ex_instr_bits_20_16_tb),
        .id_ex_instr_bits_15_11(id_ex_instr_bits_15_11_tb)
    );
    
    assign WriteReg_out_tb = wb_write_reg_location_tb;
    initial clk_tb = 0;
    always #5 clk_tb = ~clk_tb;  

    initial begin
        rst_tb = 1; 
        wb_reg_write_tb = 0;
        wb_write_reg_location_tb = 5'd2;
        mem_wb_write_data_tb = 32'h64;
        if_id_npc_tb = 32'h0000001;
        if_id_instr_tb = 32'h00000000;
        #10;
        rst_tb = 0; // Release Reset
        #10; // R-type: ADD $v0, $a1, $a0
        if_id_instr_tb = 32'h00a41020; 
        if_id_npc_tb = 32'h0000002;
        wb_write_reg_location_tb = 5'd2;
        #10; // Branch: BEQ $zero, $zero, 0x8
        if_id_instr_tb = 32'h10000008; 
        if_id_npc_tb = 32'h0000003;
        wb_write_reg_location_tb = 5'd0;
        #10; // Load Word: LW $v0, 2($a0)
        if_id_instr_tb = 32'h8c820002; 
        if_id_npc_tb = 32'h0000004;
        wb_write_reg_location_tb = 5'd2;
        #10; // Store Word: SW $v0, 2($a0)
        if_id_instr_tb = 32'hac820002;
        if_id_npc_tb = 32'h0000005;
        wb_write_reg_location_tb = 5'd0;
        #10; // Enable register write-back     
        wb_reg_write_tb = 1;
        wb_write_reg_location_tb = 5'd2;
        mem_wb_write_data_tb = 32'hA5A5A5A5;
        #10; // R-type: ADD $v0, $v0, $v0
        if_id_instr_tb = 32'h00421020;
        if_id_npc_tb = 32'h0000006;
        wb_write_reg_location_tb = 5'd2;
        wb_reg_write_tb = 0;
        #10;
    end
endmodule

