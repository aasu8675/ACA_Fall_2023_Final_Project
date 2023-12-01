`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Aamir Suhail Burhan
// 
// Create Date: 11/25/2023 02:58:46 PM
// Design Name: 
// Module Name: exe_stage
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

module exe_stage (
    input CLK,
    input RESET,
    input [31:0] rs1_data,
    input [31:0] rs2_data,
    //input wire [31:0] immediate,
    input [4:0] rd,
    input [2:0] funct3,
    input [6:0] funct7,
    input [6:0] opcode,
    output reg [31:0] alu_result,
    output reg [4:0] rd_out,
    output reg [1:0] mem_operation
);
    always @(posedge CLK or negedge RESET) begin
        if (!RESET) begin
            alu_result <= 32'h0;
            rd_out <= 5'b0;
            mem_operation <= 2'b00;
        end else begin
            case (opcode)
                7'b0110011: begin // R-type instructions
                    rd_out <= rd;
                    case (funct3)
                        3'b000: begin // ADD, SUB
                            case (funct7)
                                7'b0000000: alu_result <= rs1_data + rs2_data; // ADD
                                7'b0100000: alu_result <= rs1_data - rs2_data; // SUB
                                default: alu_result <= 32'h0; // Default case
                            endcase
                        end
                        3'b001: alu_result <= rs1_data << rs2_data; // SLL
                        3'b010: alu_result <= (rs1_data < rs2_data) ? 32'h1 : 32'h0; // SLT
                        3'b011: alu_result <= (rs1_data < rs2_data) ? 32'h1 : 32'h0; // SLTU
                        3'b100: alu_result <= rs1_data ^ rs2_data; // XOR
                        3'b101: begin
                            case (funct7)
                                7'b0000000: alu_result <= rs1_data >> rs2_data; // SRL
                                7'b0100000: alu_result <= $signed(rs1_data) >>> rs2_data; // SRA
                                default: alu_result <= 32'h0; // Default case
                            endcase
                        end
                        3'b110: alu_result <= rs1_data | rs2_data; // OR
                        3'b111: alu_result <= rs1_data & rs2_data; // AND
                        default: alu_result <= 32'h0; // Default case
                    endcase
                end
                7'b0000011: begin // Load instructions
                    rd_out <= rd;
                    case (funct3)
                        3'b000: mem_operation <= 2'b01; // LB
                        3'b001: mem_operation <= 2'b01; // LH
                        3'b010: mem_operation <= 2'b01; // LW
                        default: mem_operation <= 2'b00; // Default case
                    endcase
                end
                7'b0100011: begin // Store instructions
                    case (funct3)
                        3'b000: mem_operation <= 2'b10; // SB
                        3'b001: mem_operation <= 2'b10; // SH
                        3'b010: mem_operation <= 2'b10; // SW
                        default: mem_operation <= 2'b00; // Default case
                    endcase
                end
                // Default
                default: begin
                    alu_result <= 32'h0;
                    rd_out <= 5'b0;
                    mem_operation <= 2'b00;
                end
            endcase
        end
    end
endmodule

