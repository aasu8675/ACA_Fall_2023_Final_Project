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


module riscv_top #(
    parameter REG_FILE_DEPTH = 32,
    parameter REG_FILE_WIDTH = 32
)(
    input CLK100MHZ,
    input CPU_RESETN, 
    output store_complete
);
    
    assign store_complete = store_complete_reg;  // Output which shows Memory at Location offset 5 has correct data

    // IF Connectivity
    wire [31:0] if_stage_instruction;
    
    // ID Connectivity
    wire [31:0] id_stage_rs1_data;
    wire [31:0] id_stage_rs2_data;
    wire [11:0] id_stage_immediate;
    wire [4:0] id_stage_rd;
    wire [2:0] id_stage_funct3;
    wire [6:0] id_stage_funct7;
    wire [6:0] id_stage_opcode;
    wire id_stage_write_enable;
    
    // EXE Connectivity
    wire [31:0] exe_stage_alu_result;
    wire [4:0] exe_stage_rd_out;
    wire [31:0] exe_stage_mem_address;
    wire [2:0] exe_stage_mem_operation;
    wire exe_stage_register_type_operation;
    wire [31:0] exe_stage_store_data;
    
    // WB Connectivity
    wire [31:0] wb_data_out;
    wire wb_status;
    wire [4:0] wb_register;
    
    // SAXPY Output
    wire [31:0] saxpy_op;
    reg store_complete_reg;

    // Instantiate modules
    if_stage if_inst (
        .CLK(CLK100MHZ),
        .RESET(CPU_RESETN),
        .instruction(if_stage_instruction)
    );

    id_stage id_inst (
        .CLK(CLK100MHZ),
        .RESET(CPU_RESETN),
        .instruction(if_stage_instruction),
        .write_back_enable(wb_status),
        .write_back_register(wb_register),
        .write_back_value(wb_data_out),
        .rs1_data(id_stage_rs1_data),
        .rs2_data(id_stage_rs2_data),
        .immediate(id_stage_immediate),
        .rd(id_stage_rd),
        .funct3(id_stage_funct3),
        .funct7(id_stage_funct7),
        .opcode(id_stage_opcode),
        .write_enable(id_stage_write_enable)
    );

    exe_stage exe_inst (
        .CLK(CLK100MHZ),
        .RESET(CPU_RESETN),
        .write_enable(id_stage_write_enable),
        .rs1_data(id_stage_rs1_data),
        .rs2_data(id_stage_rs2_data),
        .immediate(id_stage_immediate),
        .rd(id_stage_rd),
        .funct3(id_stage_funct3),
        .funct7(id_stage_funct7),
        .opcode(id_stage_opcode),
        .alu_result(exe_stage_alu_result),
        .rd_out(exe_stage_rd_out),
        .mem_address(exe_stage_mem_address),
        .mem_operation(exe_stage_mem_operation),
        .wb_status(exe_stage_register_type_operation),
        .store_data(exe_stage_store_data)
    );

    mem_stage mem_inst (
        .CLK(CLK100MHZ),
        .RESET(CPU_RESETN),
        .alu_result(exe_stage_alu_result),
        .rd(exe_stage_rd_out),
        .mem_operation_type(exe_stage_mem_operation),
        .register_type_op(exe_stage_register_type_operation),
        .data_to_be_stored(exe_stage_store_data),
        .mem_address(exe_stage_mem_address),
        .data_out(wb_data_out),
        .destination_register(wb_register),
        .write_back_status(wb_status),
        .result(saxpy_op)
    );
    
    /* Checking for correct data at memory offset 5 */
    always@(posedge CLK100MHZ) begin
        if(CPU_RESETN == 1'b0) begin
            store_complete_reg <= 1'b0;
        end else
        if(saxpy_op == 32'h1A) begin
            store_complete_reg <= 1'b1;
        end
        else begin
            store_complete_reg <= 1'b0;
        end
    end
endmodule