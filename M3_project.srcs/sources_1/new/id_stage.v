`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Aamir Suhail Burhan
// 
// Create Date: 11/27/2023 12:59:26 PM
// Design Name: 
// Module Name: id_stage
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This module consists of functionality which decodes the instruction fed by the instruction fetch module.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module id_stage #(
    parameter REG_FILE_DEPTH = 32,
    parameter REG_FILE_WIDTH = 32
)(
    input CLK,
    input RESET,
    input [31:0] instruction,
    output reg [31:0] rs1_data,
    output reg [31:0] rs2_data,
    //output reg [31:0] immediate,
    output reg [4:0] rd,
    output reg [2:0] funct3,
    output reg [6:0] funct7,
    output reg [6:0] opcode
);

    reg [REG_FILE_WIDTH-1:0] register_file [REG_FILE_DEPTH-1:0];  // Register file
    integer i; // for looping control
    
    always @(posedge CLK or negedge RESET) begin
        if (!RESET) begin
            rs1_data <= 32'h0;
            rs2_data <= 32'h0;
            // immediate <= 32'h0;
            rd <= 5'b0;
            funct3 <= 3'b0;
            funct7 <= 7'b0;
            opcode <= 7'b0;
            
            // Register file clearing
            for (i = 0; i < REG_FILE_DEPTH; i = i + 1) begin
                register_file[i] <= {REG_FILE_WIDTH{1'b0}};
            end
            
        end else begin
            // Extract fields from the instruction for register type

            opcode <= instruction[6:0];
            rd <= instruction[11:7];
            funct3 <= instruction[14:12];
            rs1_data <= register_file[instruction[19:15]];
            rs2_data <= register_file[instruction[24:20]];
            funct7 <= instruction[31:25];

            // Other formats to be added later
        end
    end

endmodule
