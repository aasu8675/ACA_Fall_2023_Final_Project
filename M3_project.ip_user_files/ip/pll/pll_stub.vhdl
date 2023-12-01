-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
-- Date        : Sun Nov 26 13:05:40 2023
-- Host        : AAMIR running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/CU_Boulder/SEMESTER_3/ACA/Project/Project_3/M3_Project/M3_project.runs/pll_synth_1/pll_stub.vhdl
-- Design      : pll
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pll is
  Port ( 
    clk_mem : out STD_LOGIC;
    clk_cpu : out STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in : in STD_LOGIC
  );

end pll;

architecture stub of pll is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_mem,clk_cpu,locked,clk_in";
begin
end;
