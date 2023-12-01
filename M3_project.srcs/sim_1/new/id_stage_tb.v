`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Aamir Suhail Burhan
// 
// Create Date: 11/30/2023 02:01:00 PM
// Design Name: 
// Module Name: id_stage_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps

module id_stage_tb();

    reg CLK;
    reg RESET;
    reg [31:0] instruction;
    wire [31:0] rs1_data;
    wire [31:0] rs2_data;
    wire [4:0] rd;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [6:0] opcode;

    // Instantiate the id_stage module
    id_stage #(
        .DATA_WIDTH(32),
        .ADDR_WIDTH(32)
    ) id_stage_DUT (
        .CLK(CLK),
        .RESET(RESET),
        .instruction(instruction),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data),
        .rd(rd),
        .funct3(funct3),
        .funct7(funct7),
        .opcode(opcode)
    );

    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    // Reset generation
    initial begin
        RESET = 0;
        #10 RESET = 1;
    end

    // Test scenario
    initial begin
        // Load a sample instruction into the id_stage module
        instruction = 32'h01234567; // You can change this value for testing

        // Wait for a few clock cycles
        #50;

        // Display the results
        $display("rs1_data = %h, rs2_data = %h, rd = %h, funct3 = %h, funct7 = %h, opcode = %h",
                 rs1_data, rs2_data, rd, funct3, funct7, opcode);

        // Stop the simulation
        $stop;
    end

endmodule

