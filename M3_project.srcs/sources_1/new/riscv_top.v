`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Aamir Suhail Burhan
// 
// Create Date: 11/30/2023 12:06:14 PM
// Design Name: 
// Module Name: riscv_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This module serves as the top module which defines connectivity between all stages and instantiates them.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module riscv_top (
    input CLK,
    input RESET
);

    wire [31:0] if_instruction;
    wire [31:0] id_rs1_data, id_rs2_data;
    wire [4:0] id_rd;
    wire [2:0] id_funct3;
    wire [6:0] id_funct7, id_opcode;
    wire [31:0] exe_alu_result;
    wire [4:0] exe_rd_out;
    wire [1:0] exe_mem_operation;

    // Instantiating modules
    if_stage if_inst (
        .CLK(CLK),
        .RESET(RESET),
        .instruction(if_instruction)
    );

    id_stage #(
        .REG_FILE_DEPTH(32),
        .REG_FILE_WIDTH(32)
    ) id_inst (
        .CLK(CLK),
        .RESET(RESET),
        .instruction(if_instruction),
        .rs1_data(id_rs1_data),
        .rs2_data(id_rs2_data),
        .rd(id_rd),
        .funct3(id_funct3),
        .funct7(id_funct7),
        .opcode(id_opcode)
    );

    exe_stage exe_inst (
        .CLK(CLK),
        .RESET(RESET),
        .rs1_data(id_rs1_data),
        .rs2_data(id_rs2_data),
        .rd(id_rd),
        .funct3(id_funct3),
        .funct7(id_funct7),
        .opcode(id_opcode),
        .alu_result(exe_alu_result),
        .rd_out(exe_rd_out),
        .mem_operation(exe_mem_operation)
    );

    // TODO: Add other functionality

endmodule

