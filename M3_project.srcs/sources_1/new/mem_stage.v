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


module mem_stage #(
    parameter MEM_DEPTH = 1024,
    parameter MEM_WIDTH = 32
)(
    input CLK,
    input RESET,
    input [31:0] alu_result,
    input [4:0] rd,
    input [2:0] mem_operation_type,
    input register_type_op,
    input [31:0] data_to_be_stored,
    input [31:0] mem_address,
    output reg [31:0] data_out,
    output reg [4:0] destination_register, 
    output reg write_back_status,
    output [31:0] result
);
    reg [MEM_WIDTH-1:0] data_memory [0:MEM_DEPTH-1]; // Data Memory

    integer i;
    
    assign result = data_memory[5]; // Where the data will be store of the operation
    
    always @(posedge CLK) begin
        if (!RESET) begin
            data_memory[0] <= 32'h6;    // Value of x[0]
            data_memory[1] <= 32'h8;    // Value of y[0]
            // Reset memory content to zero
            for (i = 2; i < MEM_DEPTH; i = i + 1) begin
                data_memory[i] <= 32'h0;
            end
            
            data_out <= 32'h0;
            destination_register <= 4'h0;
            write_back_status <= 1'b0;
        end else begin
            // Read or write data based on the memory operation
            // Current Code focuses on loading or storing Words
            // Address Will be truncated as I'm using 1024 Depth which needs only 10 bits
            case (mem_operation_type)
                3'b011:  begin 
                    data_out <= data_memory[mem_address[9:0]];  // Load operation
                    destination_register <= rd;
                    write_back_status <= 1'b1;
                end
                
                3'b110:  begin
                    data_memory[mem_address[9:0]] <= data_to_be_stored;  // Store operation
                    data_out <= 32'h0;
                    write_back_status <= 1'b0;
                end
                default: begin 
                    data_out <= 32'h0; // Default case
                    write_back_status <= 1'b0;
                end   
            endcase
        end
        
        if(register_type_op == 1'b1) begin
            write_back_status <= 1'b1;
            destination_register <= rd;
            data_out <= alu_result;
        end  
    end
endmodule
