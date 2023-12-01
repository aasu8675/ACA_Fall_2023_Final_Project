// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Sun Nov 26 13:05:40 2023
// Host        : AAMIR running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/CU_Boulder/SEMESTER_3/ACA/Project/Project_3/M3_Project/M3_project.runs/pll_synth_1/pll_stub.v
// Design      : pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module pll(clk_mem, clk_cpu, locked, clk_in)
/* synthesis syn_black_box black_box_pad_pin="locked,clk_in" */
/* synthesis syn_force_seq_prim="clk_mem" */
/* synthesis syn_force_seq_prim="clk_cpu" */;
  output clk_mem /* synthesis syn_isclock = 1 */;
  output clk_cpu /* synthesis syn_isclock = 1 */;
  output locked;
  input clk_in;
endmodule
