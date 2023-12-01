set_property SRC_FILE_INFO {cfile:c:/CU_Boulder/SEMESTER_3/ACA/Project/Project_3/M3_Project/M3_project.srcs/sources_1/ip/pll/pll.xdc rfile:../../../M3_project.srcs/sources_1/ip/pll/pll.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:54 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in]] 0.100
