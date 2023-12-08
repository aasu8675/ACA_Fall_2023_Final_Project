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


/* Simple SAXPY Operation
   
   for(int i = 0; i < 2; i++)
   {
       z[i] = (a * x[i]) + y[i];
   }

*/


//////////////////////////////////////////////////////////////////////////////////


/* Instructions to be loaded:
   
   I-type:
   
   +--------------+-----+-----+-----+-------+
   |    imm[11:0] | rs1 |funct3| rd  |opcode|
   +--------------+-----+-----+-----+-------+
   |      12      |  5  |  3  |  5  |  7    |
   +--------------+-----+-----+-----+-------+
   
   
   1. Add Immediate Value of a into R9: [0000000 00011] 00000 000 01001 0010011
   2. Load Value of x[0] into R1: [0000000 00000] 00000 010 00001 0000011
   3. Load Value of y[0] into R2: [0000000 00001] 00000 010 00010 0000011
   4. Multiply 'a * x[0]' Result in R8: 1111111 00001 01001 000 01000 0110011
   5. Add y[0] + R8, Result placed in R5: 0000000 00010 01000 000 00101 0110011
   6. Store R5 Result in Memory: 0000000 00101 01010 010 00000 0100011
   
*/

//////////////////////////////////////////////////////////////////////////////////
   
module if_stage #(
    parameter MEM_DEPTH = 1024,
    parameter MEM_WIDTH = 32
)(
    input CLK,
    input RESET,
    output reg [MEM_WIDTH-1:0] instruction
);

    // Memory signals
    reg [MEM_WIDTH-1:0] instr_mem [0:MEM_DEPTH-1];

    // Memory read address
    reg [9:0] PC;  // 10 bit Program Counter to read 1024 blocks of memory
    integer i;

    always @(posedge CLK) begin
        if (!RESET) begin
            PC <= 10'b0000000000;
            
            instr_mem[0] <= 32'b0000000_00011_00000_000_01001_0010011;  // ADDI R9, R0, 3   
            instr_mem[1] <= 32'b0000000_00000_00000_010_00001_0000011;  // LW R1, 0(R0)
            instr_mem[2] <= 32'b0000000_00001_00000_010_00010_0000011;  // LW R2, 1(R0)
            
            instr_mem[3] <= 32'h0;  // NOP
            instr_mem[4] <= 32'h0;  // NOP
   
            
            instr_mem[5] <= 32'b1111111_00001_01001_000_01000_0110011;  // Custom Instruction: MUL R8, R9, R1
            
            instr_mem[6] <= 32'h0;  // NOP
            instr_mem[7] <= 32'h0;  // NOP
            instr_mem[8] <= 32'h0;  // NOP
            
            instr_mem[9] <= 32'b0000000_00010_01000_000_00101_0110011;  // ADD R5, R2, R8
            instr_mem[10] <= 32'h0;  // NOP
            instr_mem[11] <= 32'h0;  // NOP
            instr_mem[12] <= 32'h0;  // NOP
            
            instr_mem[13] <= 32'b0000000_00101_00000_010_00101_0100011; // SW R5, 5(R0)
            
            for (i = 14; i < MEM_DEPTH; i = i + 1) begin
                instr_mem[i] <= 32'h0;
            end
        end
        else begin
            // Read data from memory
            instruction <= instr_mem[PC];
            
            // Update Program Counter
            PC <= PC + 1;
        end
    end

endmodule
