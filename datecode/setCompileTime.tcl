# ############## When using Synplify Pro, use this ######################
#set buildtime [clock format [clock seconds] -format {32'h %y%m%d%H}]
#set_option -hdl_param -set SYNTHESIS_DATE $buildtime


# ############## When using Vivado Synthesis, use this ######################
set buildtimeHDL [clock format [clock seconds] -format {32'h%y%m%d%H}]
set buildtimeVal [clock format [clock seconds] -format {32'h%y%m%d%H}]
