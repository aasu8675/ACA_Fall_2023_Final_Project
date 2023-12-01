`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Aamir Suhail Burhan
// 
// Create Date: 11/27/2023 12:58:09 PM
// Design Name: 
// Module Name: if_stage
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This module consists of functionality to fetch instruction from memory based on the program counter.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`include "io_def.vh"

module if_stage (
    input CLK,
    input RESET,
    output reg [31:0] instruction
);

    // Signals for memory interaction
    reg [31:0] if_pc;  // Program Counter
    wire [63:0] if_instr;  // Instruction fetched from memory
    reg if_mem_rd;  // Read strobe interface
    wire if_mem_ready;  // Transaction status
    

    // Connect to memory interface
    mem_example if_mem (
        .clk_mem(CLK),
        .rst_n(RESET),
        .addr(if_pc),
        .width(`RAM_WIDTH32), // Assuming a 32-bit instruction width
        .data_out(if_instr),
        .rstrobe(if_mem_rd),
        .transaction_complete(if_mem_ready),
        .ready()
    );

    // State machine for IF stage
    reg [1:0] if_state;

    localparam IF_STATE_IDLE = 2'b00;
    localparam IF_STATE_FETCH = 2'b01;

    always @(posedge CLK or negedge RESET) begin
        if (!RESET) begin
            if_state <= IF_STATE_IDLE;
            if_pc <= 32'h0; // Set program counter to 0 at reset
        end else begin
            case (if_state)
                IF_STATE_IDLE: begin
                    if_mem_rd <= 0;
                    // if_mem_ready <= 0;
                    if_pc <= if_pc + 4; // Increment the PC for the next instruction fetch
                    if_state <= IF_STATE_FETCH;
                end

                IF_STATE_FETCH: begin
                    if_mem_rd <= 1;
                    if (if_mem_ready) begin
                        instruction <= if_instr;
                        if_state <= IF_STATE_IDLE;
                    end
                end
            endcase
        end
    end

endmodule
