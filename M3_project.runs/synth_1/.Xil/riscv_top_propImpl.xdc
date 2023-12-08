set_property SRC_FILE_INFO {cfile:C:/CU_Boulder/SEMESTER_3/ACA/Project/Project_3/M3_Project/M3_project.srcs/constrs_1/new/mfp_nexys4_ddr.xdc rfile:../../../M3_project.srcs/constrs_1/new/mfp_nexys4_ddr.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:15 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports store_complete]
set_property src_info {type:XDC file:1 line:64 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports CPU_RESETN]
set_property src_info {type:XDC file:1 line:66 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; #IO_L9P_T1_DQS_14 Sch=btnc
set_property src_info {type:XDC file:1 line:67 export:INPUT save:INPUT read:READ} [current_design]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLK100MHZ_IBUF]
