`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Aamir Suhail Burhan
// 
// Create Date: 11/27/2023 01:04:15 PM
// Design Name: 
// Module Name: mem_stage
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This module implements a memory load/store operations 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mem_stage (
    input wire CLK,
    input wire RESET,
    input wire [31:0] alu_result,
    input wire [4:0] rd_out,
    input wire [1:0] mem_operation,
    input wire [31:0] data_from_memory,
    output reg [31:0] data_to_memory,
    output reg [4:0] rd_writeback
);
    always @(posedge CLK or posedge RESET) begin
        if (RESET) begin
            data_to_memory <= 32'h0;
            rd_writeback <= 5'b0;
        end else begin
            // TODO: Perform memory access here (e.g., read or write to data memory)
            // TODO: Update data_to_memory and rd_writeback accordingly
        end
    end
endmodule
